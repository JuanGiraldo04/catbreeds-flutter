# 🐱 CatBreeds

A Flutter mobile application that lets users explore cat breeds using [The Cat API](https://api.thecatapi.com/v1/breeds). Built following Clean Architecture principles, feature-first modular structure, and Riverpod for state management.

---

## 📱 Screens

| Splash | Landing | Detail |
|--------|---------|--------|
| App intro with branding | Breed list with search | Full breed information |

---

## 🏗️ Architecture

This project follows **Clean Architecture** with a feature-first modular structure:

```
lib/
├── core/
│   ├── constants/
│   ├── di/
│   ├── errors/
│   ├── network/
│   ├── router/
│   └── theme/
├── features/
│   ├── breeds/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── remote/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── providers/
│   │       └── widgets/
│   └── splash/
│       └── presentation/
│           └── pages/
└── main.dart
```

Each layer exposes barrel files (`data.dart`, `domain.dart`) to control visibility and keep imports clean.

### Dependency flow

```
Presentation → Domain ← Data
```

- **Domain** defines entities, repository interfaces and use cases. No external dependencies.
- **Data** implements the repository, maps models to entities, and handles API calls via Dio.
- **Presentation** consumes use cases through Riverpod providers.

---

## 🛠️ Tech Stack

| Concern | Library |
|---|---|
| Framework | Flutter 3.x |
| Language | Dart 3.x |
| State Management | Riverpod + riverpod_annotation |
| HTTP Client | Dio |
| Image Caching | cached_network_image |
| Navigation | go_router |
| Code Generation | freezed + json_serializable |
| Environment Variables | envied |
| API | [The Cat API](https://api.thecatapi.com/v1/breeds) |
| API Documentation | [Documentation](https://developers.thecatapi.com/) |

---

## 🤔 Why Riverpod over BLoC?

Both are valid solutions listed in the role requirements. Riverpod was chosen because:

- `AsyncNotifier` handles loading / data / error states out of the box with no boilerplate
- Compile-safe providers with no `BuildContext` dependency
- Equally testable via `ProviderContainer` with overrides
- More readable code structure for a focused, single-feature app

---

## ✅ Features

- [x] Splash screen
- [x] Breed list with cards
- [x] Search breeds by name (local filtering)
- [x] Breed detail screen with fixed image and scrollable info
- [x] Hero animation between list and detail
- [x] Image caching
- [x] Light and dark theme
- [x] Unit tests (use case, repository, notifier)

---

## 🧪 Tests

```
test/
└── features/
    └── breeds/
        ├── domain/
        │   └── usecases/
        │       └── get_breeds_test.dart
        ├── data/
        │   └── repositories/
        │       └── breed_repository_impl_test.dart
        └── presentation/
            └── providers/
                └── breeds_notifier_test.dart
```

Run tests:

```bash
flutter test
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.10.0`
- Dart SDK `>=3.0.0`

### Environment setup

This project uses [envied](https://pub.dev/packages/envied) to handle environment variables securely. The API key is obfuscated at compile time and never exposed in the binary.

1. Create a `.env` file in the root of the project:

```bash
cp .env.example .env
```

2. Add your API key to `.env`:

```
CAT_API_KEY=your_api_key_here
```

### Installation

```bash
# Clone the repository
git clone https://github.com/JuanGiraldo04/catbreeds-flutter.git

# Navigate to project
cd catbreeds

# Install dependencies
flutter pub get

# Run code generation
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

---

## 👤 Author

**Juan José Giraldo Salazar**
[LinkedIn](https://www.linkedin.com/in/juan-jose-giraldo-salazar/)

---

## 📄 License

This project is for technical evaluation purposes.