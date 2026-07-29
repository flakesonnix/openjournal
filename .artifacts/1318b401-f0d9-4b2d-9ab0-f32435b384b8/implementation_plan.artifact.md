# Rename "Journal" to "OpenJournal"

This plan covers renaming the remaining "Journal" references to "OpenJournal" in code symbols, filenames, and package names to complete the rebranding.

## User Review Required

> [!WARNING]
> This change involves renaming the package `org.openpsychonaut.openjournal.ui.tabs.journal` to `org.openpsychonaut.openjournal.ui.tabs.openjournal`. This is a significant refactoring that will affect many files and imports.
>
> Renaming `JournalExport` to `OpenJournalExport` may affect the compatibility of future export files with older app versions, although the schema remains identical. Since we are at version 12.0 (breaking changes), this is acceptable.

## Proposed Changes

### Core Symbols and Files

- **Screens & ViewModels**:
    - `JournalScreen` -> `OpenJournalScreen`
    - `JournalViewModel` -> `OpenJournalViewModel`
    - `JournalScreenPreviewProvider` -> `OpenJournalScreenPreviewProvider`
    - `CalendarJournalScreen` -> `CalendarOpenJournalScreen`
- **Navigation**:
    - `JournalTopLevelRoute` -> `OpenJournalTopLevelRoute`
    - `journalGraph` -> `openJournalGraph`
    - `JournalScreenRoute` -> `OpenJournalScreenRoute`
    - Routes like `AdministrationRouteExplanationRouteOnJournalTab` -> `AdministrationRouteExplanationRouteOnOpenJournalTab`
- **Data**:
    - `JournalExport` -> `OpenJournalExport`
- **Filenames**:
    - `JournalScreen.kt` -> `OpenJournalScreen.kt`
    - `JournalViewModel.kt` -> `OpenJournalViewModel.kt`
    - `JournalScreenPreviewProvider.kt` -> `OpenJournalScreenPreviewProvider.kt`
    - `CalendarJournalScreen.kt` -> `CalendarOpenJournalScreen.kt`
    - `journalGraph.kt` -> `openJournalGraph.kt`
    - `JournalExport.kt` -> `OpenJournalExport.kt`

### Package Renaming

- Move directory `app/src/main/java/org/openpsychonaut/openjournal/ui/tabs/journal` to `app/src/main/java/org/openpsychonaut/openjournal/ui/tabs/openjournal`.
- Update all package declarations and imports from `org.openpsychonaut.openjournal.ui.tabs.journal` to `org.openpsychonaut.openjournal.ui.tabs.openjournal`.

## Verification Plan

### Automated Tests
- Run existing unit tests to ensure no regressions in data parsing or logic.
- Verify that the app builds successfully.

### Manual Verification
- Verify navigation still works correctly.
- Verify the "Journal" tab (now "OpenJournal") displays the list of experiences.
- Verify that "Journal" strings in the UI are updated to "OpenJournal" where appropriate.
