# AI Agent Guidelines

Operational rules for AI agents working on Flutter apps that follow the organization’s Feature-Driven Layered Architecture.

**Architecture source of truth:** [`docs/ARCHITECTURE_BLUEPRINT.md`](ARCHITECTURE_BLUEPRINT.md)

Before changing structure, layers, state management, navigation, or Sovereign Pay integration, read the blueprint. Prefer the blueprint over demo-project shortcuts when they conflict.

Replace `<app_package>` in any import examples with the host app’s pubspec `name`.

---

## 1. General Principles

- **Familiarize first:** Review the blueprint, existing folder structure, `analysis_options.yaml`, and current patterns before editing.
- **Stay consistent:** Match existing naming, file layout, and logic organization when they already align with the blueprint; otherwise refactor toward the blueprint.
- **Architectural alignment:** All new logic must follow the layered architecture and logic flow in the blueprint (UI → ViewModel → Repository → Data/SDK → Domain mapping → UI state).
- **Respect lints:** The analyzer config is strict. Run `dart analyze` / `flutter analyze` and fix issues.
- **SOLID:** Apply SOLID as described in the blueprint.
- **Single responsibility:** One public class per file. Exception: a `StatefulWidget` and its private `State` class may share a file.

---

## 2. Code Quality & Style

- Prefer `const` constructors where possible.
- **Full package imports only** (`package:<app_package>/...`). Relative imports are prohibited.
- No hardcoded user-facing strings in UI — use `AppStrings` / localization.
- Use `AppText` instead of raw `Text` for consistent styling.
- Use spacing/theme tokens (`AppSpacing` or equivalent); avoid magic dimensions.
- Naming: `camelCase` for members, `PascalCase` for types, `snake_case` for files/folders.
- Document all public APIs with `///`. Use `TODO` for incomplete work.
- Log with `AppLogger` only — never `print` in feature/app code.

---

## 3. Architecture & Patterns (summary)

Full detail lives in the blueprint. Agents must enforce:

| Area | Rule |
|------|------|
| Structure | Feature modules under `lib/features/<feature>/{data,domain,ui}`; shared code under `lib/core` |
| Data | API clients, DTOs, repositories, local storage, Sovereign Pay facades |
| Domain | Entities, enums, extensions, mixins; no UI, no DTOs, no raw SDK types |
| UI | Screens, widgets, ViewModels, UI state models; no API DTOs |
| ViewModels | Every screen and complex widget has a dedicated ViewModel extending `BaseViewModel` |
| ViewModel constraints | No `BuildContext`; no ViewModel depending on another ViewModel |
| Models | DTOs in `data/models`, entities in `domain/models`, UI models in `ui/.../models` |
| State | `ValueNotifier` in ViewModels; `ValueListenableBuilder` / `ListenableBuilder` in Views |
| DI | **Only** `provider` — no Bloc, Riverpod, GetX, etc. |
| Navigation | ViewModel sets `navigationRequest`; View executes via `AppNavigator` |

### Sovereign Pay (mandatory for payment apps)
- Both Card and Utility SDKs are **runtime** `dependencies`.
- Run `dart run sovereign_pay_card` and `dart run sovereign_pay_utility` after `flutter pub get`.
- Wrap SDKs in `core/data/services` and feature repositories; map to domain entities.
- SDK APIs that need `BuildContext` are invoked from the UI layer, not from ViewModels.
- See blueprint §11 for placement, init, and context bridging.

### Environment
- Enforce Flutter **3.41.5**. Do not require FVM; any toolchain is fine if that version is active.
- Optional packages (`http`, `flutter_secure_storage`, etc.) only when needed — see blueprint §3.

---

## 4. File Organization (quick map)

```
lib/core/data|domain|resources|ui
lib/features/<feature>/data|domain|ui/<screen>/{screen,viewmodel,models,widgets}
```

---

## 5. Development Workflow

1. Implement only what was asked; avoid over-engineering.
2. Do not break working behavior unless required for the task.
3. Ask for clarity when requirements are ambiguous — do not invent facts.
4. Limit analysis/exploration to what the task needs.
5. After every submission: `dart format .` and `dart analyze` (or `flutter analyze`); fix all issues.
6. Deep custom analysis only when explicitly requested.
7. If adding assets, update `pubspec.yaml` and resource constant classes.
8. **Version control:** short, precise commit messages; run git commit/push/etc. **only** when explicitly asked.

---

## 6. Refactoring Reminder

When asked to align an app with this architecture, follow the ordered playbook in **§12** of [`ARCHITECTURE_BLUEPRINT.md`](ARCHITECTURE_BLUEPRINT.md), then confirm the definition of done in that section.
