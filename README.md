# Flutter Riverpod Architecture 🚀

A reusable and scalable Flutter project architecture built with **Riverpod** for state management and dependency injection, **Dio** for REST API integration, **WebSockets** for real-time communication, **SharedPreferences** for local storage, and **Connectivity Plus** for network connectivity monitoring.

This project provides a flexible foundation for building maintainable, testable, and production-ready Flutter applications.

## ✨ Features

- **Riverpod** — Reactive state management and dependency injection.
- **Dio** — REST API integration, interceptors, and request/response handling.
- **WebSockets** — Real-time, bidirectional communication.
- **SharedPreferences** — Local key-value storage.
- **Connectivity Plus** — Network connectivity monitoring.
- **Reusable Services** — Shared network, storage, and socket services.
- **Scalable Architecture** — Feature-based organization for easier maintenance.
- **Separation of Concerns** — Keeps UI, business logic, and data access separate.

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform development |
| Riverpod | State management and dependency injection |
| Dio | REST API communication |
| WebSockets | Real-time data communication |
| SharedPreferences | Local key-value storage |
| Connectivity Plus | Network connectivity monitoring |

## 📦 Dependencies

Add the following packages to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter

  flutter_riverpod: ^2.6.1
  dio: ^5.8.0+1
  web_socket_channel: ^3.0.3
  shared_preferences: ^2.5.3
  connectivity_plus: ^6.1.4
```

These are example version constraints. Check [pub.dev](https://pub.dev/) for current compatible versions. If your project uses Riverpod 3, adjust the package versions and APIs accordingly.

Install dependencies:

```bash
flutter pub get
```

## 📁 Suggested Project Structure

```text
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   │   ├── dio_client.dart
│   │   └── connectivity_service.dart
│   ├── storage/
│   │   └── local_storage.dart
│   └── websocket/
│       └── socket_service.dart
├── features/
│   └── home/
│       ├── providers/
│       ├── models/
│       ├── repositories/
│       ├── services/
│       └── screens/
├── shared/
│   ├── widgets/
│   └── utils/
└── main.dart
```

*Note: This is a suggested structure. Adapt it to your actual project.*

## ⚙️ Getting Started

### 1. Clone the repository

```bash
git clone <your-repository-url>
```

### 2. Navigate to the project

```bash
cd <your-project-folder>
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run the application

```bash
flutter run
```

## 🧩 Architecture Overview

### 1. Riverpod — State Management

Riverpod manages application state, exposes dependencies, and separates UI components from business logic.

- Use `Provider` to expose services and repositories.
- Use `FutureProvider` for asynchronous operations.
- Use `StreamProvider` for stream-based data.
- Use `NotifierProvider` or `AsyncNotifierProvider` for interactive and asynchronous state management.
- Use `ConsumerWidget` or `Consumer` to access providers from the UI.

### 2. Dio — API Integration

Dio provides a centralized HTTP client for communicating with REST APIs.

- Configure base URLs, headers, and timeouts.
- Add interceptors for logging and authentication.
- Handle API errors consistently.
- Parse JSON responses into Dart models.
- Keep API requests inside dedicated data sources or repositories.

### 3. WebSockets — Real-Time Communication

WebSockets enable real-time, bidirectional communication between the app and a server.

- Listen to incoming events.
- Send messages to the server.
- Manage connection and disconnection states.
- Handle reconnection strategies when needed.
- Dispose of stream subscriptions and socket connections appropriately.

### 4. SharedPreferences — Local Storage

SharedPreferences stores simple key-value data locally.

Typical use cases include:

- Theme preferences.
- Onboarding completion.
- Language settings.
- Non-sensitive application preferences.

Avoid storing passwords, authentication secrets, or large structured datasets in SharedPreferences.

### 5. Connectivity Plus — Network Monitoring

Connectivity Plus helps detect changes in network connectivity, such as Wi-Fi or mobile data.

- Monitor connectivity changes.
- Display offline indicators.
- Trigger appropriate synchronization attempts.
- Handle network failures gracefully.

**Important:** A connected network does not guarantee internet access. API requests should still handle timeouts and connection failures.

## 🎯 Project Goals

- Keep UI code separate from business logic.
- Centralize API and socket services.
- Make dependencies easy to replace and test.
- Manage asynchronous state consistently.
- Build reusable features and components.
- Support scalable Flutter application development.

## 🧪 Testing

Run tests with:

```bash
flutter test
```

Riverpod providers can be overridden in tests to inject mock repositories and services, making business logic easier to test independently.

## 🚀 Future Improvements

- Authentication and token refresh.
- Centralized API error handling.
- Offline caching and synchronization.
- Automatic retry strategies.
- Socket reconnection management.
- Unit and widget testing.
- Environment-based configuration.
- CI/CD using GitHub Actions.

## 🤝 Contributing

Contributions, suggestions, and improvements are welcome.

1. Fork the repository.
2. Create a feature branch.
3. Commit your changes.
4. Open a pull request.

## 📄 License

Add a license, such as the MIT License, to define how others may use and distribute this project.

---

