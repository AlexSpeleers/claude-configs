# Claude Code status line: context usage | 5-hour limit | 7-day limit.
# Reads the status line JSON from stdin and writes a single line to stdout.
# Targets Windows PowerShell 5.1.

$invariantCulture = [System.Globalization.CultureInfo]::InvariantCulture
$missingValue = '--'

function Format-TokenCount([double]$tokenCount) {
    if ($tokenCount -ge 1000000) {
        return ($tokenCount / 1000000).ToString('0.#', $invariantCulture) + 'M'
    }
    if ($tokenCount -ge 1000) {
        return ($tokenCount / 1000).ToString('0.#', $invariantCulture) + 'k'
    }
    return $tokenCount.ToString('0', $invariantCulture)
}

function Format-Percent([double]$percent) {
    return $percent.ToString('0', $invariantCulture) + '%'
}

function Format-TimeRemaining([double]$resetsAtEpochSeconds) {
    $nowEpochSeconds = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
    $secondsRemaining = [Math]::Max(0, $resetsAtEpochSeconds - $nowEpochSeconds)
    $remaining = [TimeSpan]::FromSeconds($secondsRemaining)

    if ($remaining.Days -ge 1) {
        return '{0}d{1}h' -f $remaining.Days, $remaining.Hours
    }
    if ($remaining.Hours -ge 1) {
        return '{0}h{1}m' -f $remaining.Hours, $remaining.Minutes
    }
    return '{0}m' -f $remaining.Minutes
}

# Tokens currently occupying the context window. Falls back to the reported
# percentage when per-request usage is not available yet (start of a session).
function Get-ContextTokensUsed($contextWindow) {
    $currentUsage = $contextWindow.current_usage
    if ($null -ne $currentUsage) {
        return [double]$currentUsage.input_tokens +
            [double]$currentUsage.cache_creation_input_tokens +
            [double]$currentUsage.cache_read_input_tokens
    }
    if ($null -ne $contextWindow.used_percentage -and $null -ne $contextWindow.context_window_size) {
        return [Math]::Round([double]$contextWindow.context_window_size * [double]$contextWindow.used_percentage / 100)
    }
    return $null
}

function Get-ContextSegment($contextWindow) {
    $windowSize = $contextWindow.context_window_size
    $tokensUsed = Get-ContextTokensUsed $contextWindow
    if ($null -eq $tokensUsed -or $null -eq $windowSize -or [double]$windowSize -le 0) {
        return "ctx $missingValue"
    }

    $usedPercent = $contextWindow.used_percentage
    if ($null -eq $usedPercent) {
        $usedPercent = $tokensUsed / [double]$windowSize * 100
    }

    return 'ctx {0}/{1} ({2})' -f (Format-TokenCount $tokensUsed), (Format-TokenCount $windowSize), (Format-Percent $usedPercent)
}

function Get-RateLimitSegment([string]$label, $rateLimitWindow) {
    if ($null -eq $rateLimitWindow -or $null -eq $rateLimitWindow.used_percentage) {
        return "$label $missingValue"
    }

    $usedPercent = Format-Percent $rateLimitWindow.used_percentage
    if ($null -eq $rateLimitWindow.resets_at) {
        return "$label $usedPercent"
    }

    return '{0} {1} left ({2})' -f $label, (Format-TimeRemaining $rateLimitWindow.resets_at), $usedPercent
}

try {
    $statusInput = [Console]::In.ReadToEnd() | ConvertFrom-Json -ErrorAction Stop
} catch {
    $statusInput = $null
}

$segments = @(
    (Get-ContextSegment $statusInput.context_window),
    (Get-RateLimitSegment '5h' $statusInput.rate_limits.five_hour),
    (Get-RateLimitSegment '7d' $statusInput.rate_limits.seven_day)
)

$escape = [char]27
[Console]::Out.Write("$escape[2m" + ($segments -join ' | ') + "$escape[0m")
