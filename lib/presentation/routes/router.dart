import 'package:auto_route/auto_route.dart';
import 'package:employee_managment_project/presentation/screens/authorization/authorization_screen.dart';

export 'package:auto_route/auto_route.dart';

part 'router.gr.dart';


@AutoRouterConfig()
class AppRouter extends RootStackRouter {


  AppRouter();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [

  ];
}