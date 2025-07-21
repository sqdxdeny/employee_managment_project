import 'package:auto_route/auto_route.dart';
import 'package:employee_managment_project/presentation/screens/authorization/authorization_screen.dart';

import '../screens/home/home_screen.dart';

export 'package:auto_route/auto_route.dart';
import 'package:employee_managment_project/generated/locale_keys.g.dart';

import '../screens/profile/profile_screen.dart';
part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    CustomRoute(page: AuthorizationRoute.page, path: '/'),
    CustomRoute(page: HomeRoute.page, path: '/home'),
    CustomRoute(page: ProfileRoute.page, path: '/profile')
  ];
}
