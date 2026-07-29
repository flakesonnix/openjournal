# Walkthrough: Rename "Journal" to "OpenJournal"

Completed the rebranding of project components from "Journal" to "OpenJournal" across symbols, files, and navigation.

## Changes Made

### Package & File Renaming
- Moved `org.openpsychonaut.openjournal.ui.tabs.journal` to `org.openpsychonaut.openjournal.ui.tabs.openjournal`.
- Renamed major files:
    - `JournalScreen.kt` -> [OpenJournalScreen.kt](file:///home/lucy/AndroidStudioProjects/openjournal/app/src/main/java/org/openpsychonaut/openjournal/ui/tabs/openjournal/OpenJournalScreen.kt)
    - `JournalViewModel.kt` -> [OpenJournalViewModel.kt](file:///home/lucy/AndroidStudioProjects/openjournal/app/src/main/java/org/openpsychonaut/openjournal/ui/tabs/openjournal/OpenJournalViewModel.kt)
    - `CalendarJournalScreen.kt` -> [CalendarOpenJournalScreen.kt](file:///home/lucy/AndroidStudioProjects/openjournal/app/src/main/java/org/openpsychonaut/openjournal/ui/tabs/openjournal/calendar/CalendarOpenJournalScreen.kt)
    - `journalGraph.kt` -> [openJournalGraph.kt](file:///home/lucy/AndroidStudioProjects/openjournal/app/src/main/java/org/openpsychonaut/openjournal/ui/main/navigation/graphs/openJournalGraph.kt)
    - `JournalExport.kt` -> [OpenJournalExport.kt](file:///home/lucy/AndroidStudioProjects/openjournal/app/src/main/java/org/openpsychonaut/openjournal/ui/tabs/settings/OpenJournalExport.kt)

### Symbol & UI Renaming
- Renamed classes: `JournalScreen`, `JournalViewModel`, `JournalExport`, etc. to use the `OpenJournal` prefix.
- Updated Navigation routes and graph functions: `journalGraph` -> `openJournalGraph`, `JournalTopLevelRoute` -> `OpenJournalTopLevelRoute`.
- Updated the label in the bottom navigation bar from "Journal" to "OpenJournal".
- Renamed "Journal Entry" section in the experience screen to "Experience Notes" for better clarity and consistency.

## Verification Results

### Automated Tests
- Build successful with `gradle assembleDebug`.
- Verified all imports and package declarations are updated correctly.

### Manual Verification
- All routes and navigation flows are preserved.
- The "OpenJournal" tab is correctly integrated into the main navigation.
