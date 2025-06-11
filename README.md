# Video Reel App

> A cleanly architected Flutter application showcasing vertical reel-like video playback with pagination, caching, and robust state management.

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Video Reel App works on iOS, Android.

---


## 🔗 Data Retrieval

- Fetches videos from:
- https://backend-cj4o057m.fctl.app/bytes/scroll?page=1&limit=10

- Uses the [`http`](https://pub.dev/packages/http) package for API requests

### 🧩 Data Parsing

- Parses API JSON responses using Dart's native `dart:convert` utilities

### 🔄 Pagination & Lazy Loading

- Infinite scrolling with **pagination** for efficient large data handling
- Implements **lazy loading** to improve performance and resource use

### 🧠 Caching

- Caches video metadata to reduce redundant API calls and improve UX

### ⚠️ Error Handling

Handles various failure scenarios:

- API unavailability or failures
- Network issues
- JSON parsing errors

## 🎨 UI & Architecture
📱 Reels Page
Mimics Instagram-style vertical reels interface

Smooth scrolling UX with continuous loading of new videos

## 🧱 Architecture
Clean architecture with domain/data/presentation layer separation

BLoC (flutter_bloc) pattern for robust state management

Dependency injection using get_it



## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Test",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Test Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Test",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Test Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:video_reel_app/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Test",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Test Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Test",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del Test"
    }
}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Alternatively, run `flutter run` and code generation will take place automatically.


## 📚 Project Highlights
✅ Modular & scalable codebase

✅ Linting with very_good_analysis

✅ Full unit & widget test coverage

✅ i18n-ready (internationalization support)

✅ Auto-generated localization code using flutter gen-l10n

✅ Modern UI practices with responsive layout

