# English Sikho — Android Flutter starter

This is an initial source scaffold, not a finished or tested APK.

## Included
- Flutter Android app entry point and theme
- Home dashboard layout
- Feature navigation placeholders
- Reminder preference screen (time selection and local preference storage)
- Small sample verb JSON

## Not yet implemented
- Actual scheduled Android notifications and permission handling
- Full lesson engine and 30-day content
- 3,000+ verified verbs and the PDF
- Quiz engine, revision queue, and persistent learning progress
- Automated tests, Android build, and device testing
- AdMob (intentionally excluded from the first release)

## Build requirements
Install Flutter and Android SDK on a development machine, then run:
1. `flutter create . --platforms=android`
2. `flutter pub get`
3. `flutter run`

The project has not been compiled in this environment. Package versions and Android notification configuration must be verified against the current Flutter/Android toolchain before release.

## Product decisions
- Android only
- Offline-first
- Hindi + English instruction
- No ads or subscription in the MVP
- Daily practice reminder, progress goals, and a searchable Verb Bank
