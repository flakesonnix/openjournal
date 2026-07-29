# Tasks: Rename "Journal" to "OpenJournal"

- `[x]` Move directory `ui/tabs/journal` to `ui/tabs/openjournal`
- `[x]` Update package declarations in moved files
- `[x]` Rename core symbols and files:
    - `[x]` `JournalExport.kt` -> `OpenJournalExport.kt` and class `JournalExport` -> `OpenJournalExport`
    - `[x]` `JournalScreen.kt` -> `OpenJournalScreen.kt` and class `JournalScreen` -> `OpenJournalScreen`
    - `[x]` `JournalViewModel.kt` -> `OpenJournalViewModel.kt` and class `JournalViewModel` -> `OpenJournalViewModel`
    - `[x]` `JournalScreenPreviewProvider.kt` -> `OpenJournalScreenPreviewProvider.kt`
    - `[x]` `CalendarJournalScreen.kt` -> `CalendarOpenJournalScreen.kt`
- `[x]` Update navigation graph and routes:
    - `[x]` `journalGraph.kt` -> `openJournalGraph.kt`
    - `[x]` `journalGraph` function -> `openJournalGraph`
    - `[x]` Update route objects (`JournalTopLevelRoute`, `JournalScreenRoute`, etc.)
- `[x]` Global search and replace of imports and symbol usages
- `[x]` Verify build and tests
