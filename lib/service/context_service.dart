part of services;

class ContextService {
  ContextService._();
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  /// note that this context will not be used to open dialogs or any navigation work
  static BuildContext get context => scaffoldKey.currentContext!;
}
