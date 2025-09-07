import 'package:auto_route/auto_route.dart';
import 'package:assignment_8/core/Navigation/routes/routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: ZipcodeDetailsRoute.page),
  ];
}
