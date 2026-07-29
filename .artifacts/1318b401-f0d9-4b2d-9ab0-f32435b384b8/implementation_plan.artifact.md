# Setup Fastlane Metadata for F-Droid

This plan involves setting up the Fastlane metadata structure required for automated metadata syncing with F-Droid. This will allow F-Droid to automatically pull descriptions, screenshots, and changelogs directly from the repository.

## User Review Required

> [!NOTE]
> I will be extracting descriptions and titles from the current `README.md`.
> I will also look for an app icon in the resources to include in the metadata.

## Proposed Changes

### Metadata Files

- Create the directory structure: `fastlane/metadata/android/en-US/`.
- Create the following text files in `fastlane/metadata/android/en-US/`:
    - `title.txt`: "OpenJournal"
    - `short_description.txt`: A concise summary of the app.
    - `full_description.txt`: A detailed description of the app's features and mission.
- Create `fastlane/metadata/android/en-US/changelogs/63.txt`:
    - This will contain the release notes for version 12.0 (versionCode 63).

### Graphics (Optional/Research)

- Locate the high-resolution app icon and copy it to `fastlane/metadata/android/en-US/images/icon.png`.
- If screenshots are available, they will be organized in `fastlane/metadata/android/en-US/images/phoneScreenshots/`.

## Verification Plan

### Automated Tests
- N/A (Metadata only).

### Manual Verification
- Verify that the directory structure and file contents match the specifications in the provided technical documentation.
