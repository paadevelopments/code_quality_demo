# AI Agent Guidelines for code_quality_demo

This document provides instructions for AI agents working on the `code_quality_demo` project. Adhering to these guidelines ensures consistency, code quality, and maintainability.

> **Portable agent rules:** Templates live under [`docs/`](docs/) in this repo. On a host project, place them at the **project root** as `AGENTS.md` and `ARCHITECTURE_BLUEPRINT.md`.

## 1. General Principles
- **Project Familiarization**: Before performing any task, familiarize yourself with the project's specifications, including file/folder structure, lint rules, architecture, code quality standards, and logic organization.
- **Maintain Consistency**: Follow existing patterns for file structure, naming, and logic organization.
- **Architectural Alignment**: Ensure all new logic, features, and components strictly align with the layered architecture and logic flow described in `ARCHITECTURE.md`.
- **Respect Lint Rules**: The `analysis_options.yaml` file is very strict. Always run `flutter analyze` or equivalent to ensure compliance.
- **SOLID Principles**: Adhere to SOLID principles in all code design and implementation.
- **Single Responsibility**: Each class should have a single responsibility and reside in its own file.
- **StatefulWidgets Exception**: A `StatefulWidget` and its private `State` class should be in the same file.

## 2. Code Quality & Style
- **Lints**: Pay close attention to lints defined in `analysis_options.yaml`.
  - Prefer `const` constructors where possible.
  - **Full-Path Imports**: Use full package paths for all imports. Relative paths are strictly prohibited.
  - Avoid hardcoded strings in UI (use `AppStrings` or localization).
  - Use `AppText` instead of `Text` for consistent styling.
  - Follow naming conventions (camelCase for variables/functions, PascalCase for classes).
- **Documentation**: All public APIs (classes, methods, fields) must have doc comments (`///`). Use these and `TODO` comments where necessary to ensure clarity for cross-team development.

## 3. Architecture & Patterns
- **Feature-Based Structure**: Organize code by features (e.g., `lib/features/posts`).
- **Layered Architecture**: Follow the [Flutter Layered Architecture](https://docs.flutter.dev/app-architecture/concepts#layered-architecture).
  - **Data Layer (`data`)**: Data sources, API services, repositories, and Data Transfer Objects (DTOs/Request/Response models).
  - **Logic Layer (`domain`)**: Business logic, entities, and use cases.
  - **UI Layer (`ui`)**: Widgets, Screens, ViewModels, and UI-specific state models.
- **ViewModels**: Every screen and every complex widget **must** have its own dedicated ViewModel extending `BaseViewModel` for state management.
- **ViewModel Constraints**: 
  - Never use `BuildContext` in ViewModels.
  - Never allow a ViewModel to depend on or use another ViewModel.
- **Model Discipline**:
  - Keep models in their respective layers.
  - **Strict Rule**: No API-related request or response models are allowed in the `ui` folder.
  - Data models stay in `data/models`, Domain entities in `domain/models`, and UI models in `ui/models`.
- **State Management**: Use `ValueNotifier` within ViewModels and `ValueListenableBuilder` or `ListenableBuilder` in Views. **Mandatory**: Use ONLY `provider` for dependency injection and cross-component state management.
- **Navigation**: Use `AppNavigator` for all navigation actions. Navigation requests should be initiated from the ViewModel via `navigationRequest`.

## 4. File Organization
- **lib/core**: Shared components, services, and utilities.
  - `lib/core/data`: Common data sources, repositories, services (e.g., `AppLogger`).
  - `lib/core/domain`: Common entities, state classes, enums, extensions.
  - `lib/core/resources`: Strings, assets, themes, animations.
  - `lib/core/ui`: Shared widgets (e.g., `AppText`), navigation logic, base ViewModel.
- **lib/features**: Feature-specific logic following the same layered structure.

## 5. Development Workflow
- Before submitting changes, ensure no analysis errors or warnings.
- If adding new assets, update `pubspec.yaml` and any relevant resource classes.
- Use `AppLogger` for logging instead of `print`.

## 6. Behavioral & Workflow Guidelines
- **Avoid Over-engineering**: Do only what has been asked.
- **Logic Integrity**: Do not break any existing or working logic unless absolutely necessary for the task.
- **Clarity Over Assumption**: Ask for clarity whenever a need arises. Do not assume or hallucinate information.
- **Relevant Analysis**: Do not overly or unnecessarily analyze unless it is directly relevant to achieving the requested goal.
- **Mandatory Verification**: Always run `dart format` and `dart analyze` after every submission. Fix all reported issues immediately.
- **Custom Analysis**: Only perform custom analysis or deep-dives when specifically asked to do so.
- **Version Control**:
  - Use short, simple, but precise commit messages.
  - Run git operations (commit, push, etc.) ONLY when explicitly asked to.
