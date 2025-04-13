# flutter_notes_app
<div align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/>
  <img src="https://img.shields.io/badge/Clean_Architecture-16a34a?style=for-the-badge" alt="Clean Architecture"/>
  <img src="https://img.shields.io/badge/BLoC-5a0fc8?style=for-the-badge" alt="BLoC"/>
</div>

## Overview

**Flutter Notes App** is a simple notes app. The application showcases the implementation of **Clean Architecture** principles, with **BLoC pattern** for state management, **GetIt** for dependency injection, and **Hive** for fast, efficient local storage.


## 📊 Technical Architecture

### 🔷 Clean Architecture Implementation

The application follows **Uncle Bob's Clean Architecture** principles to ensure:

```
                  💎 Presentation Layer 💎
                           ↑
                           |
                  💠 Domain Layer 💠
                           ↑
                           |
                  🔹 Data Layer 🔹
```

> **"The code structure is the most important aspect of any software system. It defines how the application will evolve over time."**

#### 📁 Project Structure

```
lib/
├── core/
│   ├── error/
│   ├── router/
│   ├── theme/
│   ├── usecases/
│   └── utils/
└── features/
    └── notes/
        ├── data/
        │   ├── datasources/
        │   ├── models/
        │   └── repositories/
        ├── domain/
        │   ├── entities/
        │   ├── repositories/
        │   └── usecases/
        └── presentation/
            ├── bloc/
            ├── pages/
            └── widgets/
```

