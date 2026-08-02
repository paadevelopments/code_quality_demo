# Project Architecture - code_quality_demo

This document outlines the architectural design and structural organization of the `code_quality_demo` project.

> **Portable blueprint:** For refactoring other apps (including Sovereign Pay Card/Utility integration), use [`docs/ARCHITECTURE_BLUEPRINT.md`](docs/ARCHITECTURE_BLUEPRINT.md) and [`docs/AGENTS.md`](docs/AGENTS.md).

## Overview
The project follows a **Feature-Driven Layered Architecture**, adhering to the principles outlined in the [Flutter App Architecture Guide](https://docs.flutter.dev/app-architecture/concepts#layered-architecture). It emphasizes strict separation of concerns, modularity, and high code quality.

## Core Architectural Layers

### 1. Data Layer (`data`)
The entry point for data into the application.
- **API**: API client implementations and endpoint definitions.
- **Repositories**: Implementation of data access logic, coordinating between different data sources (network, local storage).
- **Models**: Data Transfer Objects (DTOs), including JSON serialization/deserialization for API requests and responses.
- **Strict Rule**: Data layer models must never leak into the UI layer directly without being mapped or managed by the domain/logic layer.

### 2. Logic Layer (`domain`)
Contains the core business logic and rules.
- **Models/Entities**: Pure business objects that are agnostic of the data source.
- **Extensions**: Business logic extensions for entities.
- **Enums**: Domain-specific enumerations.

### 3. UI Layer (`ui`)
Responsible for rendering the user interface and handling user interactions.
- **Screens**: Full-page widgets representing a specific view.
- **Widgets**: Reusable UI components, both feature-specific and shared.
- **ViewModels**: The state managers for the UI. Every screen and complex widget has its own ViewModel extending `BaseViewModel`.
- **Models**: UI-specific models, such as view state objects or display-specific data structures.
- **Strict Rule**: No API-related request or response models are allowed here.

## Comprehensive Project Structure

### `lib/core/` - Shared Infrastructure
Shared code used across multiple features.

- **`data/`**:
  - `api/`: Base API configuration, path constants, and common interceptors.
  - `repositories/`: Base repository classes and common data access logic.
  - `services/`: Global services like `AppLogger`, `StorageService`, and `Analytics`.
- **`domain/`**:
  - `enums/`: App-wide enumerations.
  - `extensions/`: Global Dart extensions.
  - `models/`: Common business entities and shared state models like `UiState`.
- **`resources/`**:
  - `animations/`: Lottie or Rive animation assets and helpers.
  - `fonts/`: Custom font definitions.
  - `icons/`: Custom icon sets or icon constants.
  - `images/`: Asset path constants for images.
  - `strings/`: App-wide string constants (`AppStrings`) and localization files.
- **`ui/`**:
  - `localization/`: Localization logic and ViewModels.
  - `navigation/`: `AppNavigator`, `AppRouter`, `AppRoutes`, and `NavigatorRequest`.
  - `theme/`: App themes (light/dark) and color palettes.
  - `widgets/`: Shared atomic widgets like `AppText`, `AppButton`, etc.
  - `base_viewmodel.dart`: The foundation for all ViewModels in the app.

### `lib/features/` - Feature Modules
Modularized business features. Each feature folder (e.g., `posts`, `auth`, `splash`) follows the same layered structure:

- **`feature_name/data/`**:
  - `api/`: Feature-specific API endpoints.
  - `models/`: Request and Response DTOs.
  - `repositories/`: Implementation of the feature's data requirements.
- **`feature_name/domain/`**:
  - `models/`: Feature entities.
  - `extensions/`: Business logic for the feature.
- **`feature_name/ui/`**:
  - `screen_name/`: A sub-folder for each screen.
    - `screen.dart`: The View (Widget).
    - `viewmodel.dart`: The ViewModel for the screen.
    - `widgets/`: Private widgets used only by this screen.
  - `widgets/`: Reusable widgets shared across the entire feature.

## State Management & Logic Flow
1.  **UI** (Widget) listens to a **ViewModel**.
2.  **ViewModel** calls a **Repository**.
3.  **Repository** fetches data from an **API Service** or **Local Storage**.
4.  **Repository** maps the **Data Model** (DTO) to a **Domain Model** (Entity) or passes it to the ViewModel.
5.  **ViewModel** updates the `uiState` (a **UI Model**).
6.  **UI** rebuilds automatically via `ValueListenableBuilder` or `ListenableBuilder`.

### State Management Tools
- **Mandatory**: Use ONLY `provider` for dependency injection and state management across the application. Other state management libraries (e.g., Bloc, Riverpod) are strictly prohibited to maintain architectural consistency.

### ViewModel Constraints
- **Context-Free**: ViewModels must **never** use or store `BuildContext`. All UI-related changes must be communicated via `uiState` or `navigationRequest`.
- **Decoupled ViewModels**: A ViewModel must **never** depend on or use another ViewModel. Shared logic should be moved to a shared Repository, Service, or a common base class.
- **State via `uiState`**: All data intended for the UI must be encapsulated within the `uiState` notifier or a dedicated state model.
- **Navigation via `navigationRequest`**: ViewModels trigger navigation by updating the `navigationRequest` notifier, which the View listens to and executes via `AppNavigator`.

## Extensibility & Shared Components
The architecture encourages reusability through inheritance and composition:

- **Shared API Clients**: Feature-specific API clients should extend a base API client (e.g., `BaseApiService`) to inherit common headers, error handling, and interceptors.
- **Shared Repositories**: Common data logic (e.g., user profile, settings) should reside in `lib/core/data/repositories` and can be injected or instantiated in feature-specific ViewModels.
- **Shared ViewModels**: ViewModels that manage global state (e.g., `AuthViewModel`, `ThemeViewModel`) reside in `lib/core/ui` and are accessed by multiple features, typically through a provider or singleton pattern.

## Development Standards
- **Architectural Alignment**: All new logic, features, and components must strictly align with the established layered architecture and logic flow. Deviations are not permitted without architectural review.
- **Code Formatting**: All code must be formatted using `dart format .` before pushing changes to ensure a consistent coding style.
- **Import Style**: All imports must use the full package path (e.g., `import 'package:code_quality_demo/...'`). Relative paths are strictly prohibited to ensure clarity and avoid resolution issues.
- **Single Class per File**: Enforced for all files except `StatefulWidget` + `State` pairs.
- **ViewModel Requirement**: Mandatory for all screens and complex widgets to ensure testability and separation of logic.
- **ViewModel State Models**: Each ViewModel should have its own dedicated UI model class to hold its state data. This prevents the clustering of multiple local variables within the ViewModel.
- **Staged UI handling**: For views with multiple stages or sections, the ViewModel's state model should include an `enum` field to manage and transition between these stages.
- **Logic Organization**: The use of `enums`, `extensions`, and `mixins` must be normalized. They should be placed in their respective `enums/`, `extensions/`, or `mixins/` folders within the appropriate layer to keep methods and functions clean and focused.
- **Simplification**: Always strive for simplicity. Avoid overcomplicating logic and keep implementations straightforward and readable.
- **Resource Discipline**: No hardcoded strings or dimensions; use `AppStrings` and `AppSpacing`.
- **Logging**: Always use `AppLogger` for consistency across environments.
- **Documentation & TODOs**: All complex logic must be accompanied by doc-style comments (`///`) to ensure clarity for cross-team development. Use `TODO` comments to flag incomplete logic or areas requiring future attention.

## Testing
Tests are considered important for maintaining the stability and reliability of the application, although not strictly mandatory for every single minor change. ViewModels and Repositories should be designed with testability in mind (e.g., via dependency injection).

## SOLID Principles Application
The project enforces SOLID principles to ensure long-term maintainability:

1.  **Single Responsibility Principle (SRP)**: A class should have one reason to change.
    *   *Example*: A `Repository` handles data coordination; it does not contain UI logic or direct API implementation details.
2.  **Open/Closed Principle (OCP)**: Software entities should be open for extension but closed for modification.
    *   *Example*: Using `extensions` to add business logic to domain models without altering the model class itself.
3.  **Liskov Substitution Principle (LSP)**: Objects of a superclass should be replaceable with objects of its subclasses without breaking the application.
    *   *Example*: Any class extending `BaseViewModel` must be usable by the `BaseView` or common UI patterns without specialized type checking.
4.  **Interface Segregation Principle (ISP)**: Clients should not be forced to depend on methods they do not use.
    *   *Example*: Defining specific abstract classes for repositories so a ViewModel only sees the methods relevant to its feature.
5.  **Dependency Inversion Principle (DIP)**: Depend on abstractions, not concretions.
    *   *Example*: ViewModels should depend on Repository abstractions/interfaces rather than specific network client implementations.

## Organizational Standards & Dependencies

### Mandatory SDKs & Plugins
To prevent logic duplication and ensure consistency across all organizational applications, the use of the following internal SDKs is mandatory:

- **Sovereign Pay Card SDK**: [https://github.com/Sovereign-Pay-LTD/Plugins_SDK_Card.git](https://github.com/Sovereign-Pay-LTD/Plugins_SDK_Card.git)
- **Sovereign Pay Utility SDK**: [https://github.com/Sovereign-Pay-LTD/Plugins_SDK_Utility.git](https://github.com/Sovereign-Pay-LTD/Plugins_SDK_Utility.git)

Refer to the `README.md` within each respective repository for detailed setup and usage instructions.

### External Dependencies
- **Minimalism**: Avoid adding unnecessary new packages. Before adding a dependency, evaluate if the required functionality can be implemented using existing project utilities or core Flutter APIs.

### Environment Requirements
- **Flutter Version**: All applications must use Flutter version **3.41.5** unless explicitly informed otherwise by the organization. This version consistency is critical for build stability and SDK compatibility.
