import '../core.dart';

class RouteNavigator {
  static final RouteNavigator _instance = RouteNavigator._internal();
  RouteNavigator._internal();

  factory RouteNavigator() => _instance;

  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();

  static final BuildContext context = navigationKey.currentState!.context;

  static Future<dynamic> navigate(Widget page, {arguments}) async =>
      navigationKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => page,
          settings: RouteSettings(arguments: arguments),
        ),
      );

  static Future<dynamic> replace(Widget page, {arguments}) async =>
      navigationKey.currentState!.pushReplacement(
        MaterialPageRoute(
          builder: (_) => page,
          settings: RouteSettings(arguments: arguments),
        ),
      );

  static Future<dynamic> replaceAll(Widget page, {arguments}) async =>
      navigationKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => page,
          settings: RouteSettings(arguments: arguments),
        ),
        ((route) => false),
      );

  static bool canPop() => navigationKey.currentState!.canPop();

  static void back({dynamic data}) {
    navigationKey.currentState!.pop(data);
  }
}
