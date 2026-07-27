import 'package:code_quality_demo/core/domain/models/ui_state.dart';
import 'package:code_quality_demo/core/ui/navigation/navigator_request.dart';
import 'package:flutter/material.dart';

/// Base class for all ViewModels, handling state and navigation requests.
abstract class BaseViewModel extends ChangeNotifier {
  /// The current state of the UI.
  final ValueNotifier<UiState> uiState = ValueNotifier<UiState>(UiState.idle());

  /// The current navigation request.
  final ValueNotifier<NavigatorRequest?> navigationRequest =
      ValueNotifier<NavigatorRequest?>(null);

  bool _isDisposed = false;

  /// Refreshes the listeners.
  void refresh() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  /// Sets the state to idle.
  void setIdle() {
    if (!_isDisposed) {
      uiState.value = UiState.idle();
    }
  }

  /// Sets the state to loading.
  void setLoading() {
    if (!_isDisposed) {
      uiState.value = UiState.loading();
    }
  }

  /// Sets the state to success.
  void setSuccess([dynamic data]) {
    if (!_isDisposed) {
      uiState.value = UiState.success(data);
    }
  }

  /// Sets the state to error.
  void setError(String message) {
    if (!_isDisposed) {
      uiState.value = UiState.error(message);
    }
  }

  /// Navigates to a route.
  void navigateTo(String routeName, {Object? arguments}) {
    if (!_isDisposed) {
      navigationRequest.value =
          NavigatorRequest.push(routeName, arguments: arguments);
    }
  }

  /// Pops the current route.
  void pop({Object? result}) {
    if (!_isDisposed) {
      navigationRequest.value = NavigatorRequest.pop(arguments: result);
    }
  }

  /// Navigates home.
  void goHome(String homeRoute) {
    if (!_isDisposed) {
      navigationRequest.value = NavigatorRequest.goHome(homeRoute);
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    uiState.dispose();
    navigationRequest.dispose();
    super.dispose();
  }
}
