/// Encapsulates a navigation command sent from a ViewModel.
class NavigatorRequest {
  /// The name of the route to navigate to.
  final String? routeName;

  /// Optional arguments for the navigation.
  final Object? arguments;

  /// Whether the navigation is a pop operation.
  final bool isPop;

  /// Whether the navigation is a pushNamedAndRemoveUntil operation.
  final bool isAndRemoveUntil;

  /// Creates a push request.
  NavigatorRequest.push(this.routeName, {this.arguments})
      : isPop = false,
        isAndRemoveUntil = false;

  /// Creates a pop request.
  NavigatorRequest.pop({this.arguments})
      : routeName = null,
        isPop = true,
        isAndRemoveUntil = false;

  /// Creates a goHome request.
  NavigatorRequest.goHome(this.routeName)
      : arguments = null,
        isPop = false,
        isAndRemoveUntil = true;
}
