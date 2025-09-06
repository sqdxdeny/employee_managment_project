import 'package:auto_route/auto_route.dart';
import 'package:employee_managment_project/presentation/screens/authorization/authorization_screen.dart';
import 'package:employee_managment_project/presentation/screens/tasks/tasks_screen.dart';

import '../screens/home/home_screen.dart';
import '../screens/navigationBar/navigation_bar_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/requests/requests_screen.dart';

export 'package:auto_route/auto_route.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    /// Экран авторизации
    AutoRoute(page: AuthorizationRoute.page, initial: true),
    AutoRoute(
      page: NavigationBarRoute.page,
      path: '/NavigationBar',
      children: [
        AutoRoute(page: HomeRoute.page, path: 'Home', initial: true),
        AutoRoute(page: TasksRoute.page, path: 'tasks'),
        AutoRoute(page: RequestsRoute.page, path: 'requests'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
      ],
    ),
  ];
}
