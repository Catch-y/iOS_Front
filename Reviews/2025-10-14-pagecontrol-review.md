# PR Review: 💄 [Fix] PageControl 가이드 텍스트가 2개 이상일 때만 표시되도록 수정

## Summary
- PageControl guide text now guarded by `pageCount >= 2`.

## Review Comments
1. **Guide text visibility condition**
   - **File**: `Catchy/Catchy/Common/UIComponents/Preference/PageControl.swift`
   - **Line**: Within the new `if pageCount >= 2` check
   - **Feedback**: `pageCount` is the current index (0-based), so this condition hides the guide text on the first two pages even when there are multiple pages. If the intent is to hide the guide when there is only one page, the guard should reference `totalPageCount` (e.g. `if totalPageCount > 1`). Otherwise, users on the first pages will never see the guide message.
   - **Suggestion**:
     ```swift
     if totalPageCount > 1 {
         Text(PageControlConstants.guideText)
             .font(.body3)
             .foregroundStyle(Color.g4)
     }
     ```

## Recommendation
- [ ] Request changes
- [ ] Approve
- [x] Comment

The fix is close, but the condition likely needs to look at `totalPageCount` instead of `pageCount` to match the described behaviour.
