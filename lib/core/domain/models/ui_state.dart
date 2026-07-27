import 'package:code_quality_demo/core/domain/enums/ui_state_type.dart';

/// Represents the current state of a UI operation.
class UiState {
  /// The type of the state.
  final UiStateType type;

  /// An optional message.
  final String? message;

  /// Optional data.
  final dynamic data;

  /// Creates a UI state.
  UiState(this.type, {this.message, this.data});

  /// Creates an idle state.
  factory UiState.idle() => UiState(UiStateType.idle);

  /// Creates a loading state.
  factory UiState.loading() => UiState(UiStateType.loading);

  /// Creates a success state.
  factory UiState.success([dynamic data]) =>
      UiState(UiStateType.success, data: data);

  /// Creates an error state.
  factory UiState.error(String message) =>
      UiState(UiStateType.error, message: message);

  /// Whether the state is loading.
  bool get isLoading => type == UiStateType.loading;

  /// Whether the state is success.
  bool get isSuccess => type == UiStateType.success;

  /// Whether the state is error.
  bool get isError => type == UiStateType.error;
}
