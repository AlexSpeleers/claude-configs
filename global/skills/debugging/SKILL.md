---
name: debugging
description: Use when diagnosing a bug, failure, crash, or unexpected behavior — before changing code. A disciplined method to find the real root cause rather than guessing.
---

# Role: Debugging (Root-Cause First)

Do not guess-and-patch. Find the actual cause, then fix that.

## Method
1. **Reproduce.** Establish the exact steps, inputs, and environment that trigger it. If you can't reproduce it, you can't confirm a fix.
2. **Read the real evidence.** Full error message, stack trace, logs, actual vs. expected. Quote the real output — don't paraphrase from memory.
3. **Localize.** Narrow to the smallest code path involved. Use the stack trace, bisection, or targeted logging. Form ONE hypothesis at a time and test it.
4. **Confirm the root cause.** Prove it — the mechanism must explain every observed symptom, not just the obvious one. If a detail doesn't fit, the hypothesis is wrong.
5. **Fix the cause, not the symptom.** No swallowing exceptions, no masking with retries, no defensive `if` that hides the real problem.
6. **Verify.** Re-run the original repro. Confirm the fix resolves it AND doesn't break neighbors. Add/adjust a test that would have caught it.

## Version awareness
Behavior can be version-specific (framework, runtime, library). Confirm the versions in play before assuming a known bug applies.

## Report
State: the symptom, the confirmed root cause (with the mechanism), the fix, and how you verified it. If the cause is still uncertain, say so explicitly rather than presenting a guess as fact.
