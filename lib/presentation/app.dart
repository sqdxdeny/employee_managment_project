import 'package:easy_localization/easy_localization.dart';
import 'package:employee_managment_project/application/profile_watcher/profile_watcher_bloc.dart';
import 'package:employee_managment_project/presentation/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  static final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = ThemeMode.system;

    return BlocProvider<ProfileWatcherBloc>(
      create: (_) => ProfileWatcherBloc(),
     child: MaterialApp.router(
      ///
      /// Navigation
      ///
      routerDelegate: AutoRouterDelegate(_appRouter),
      routeInformationParser: _appRouter.defaultRouteParser(),

      builder: (context, child) {
        if (child == null) return const SizedBox();
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },

      ///
      ///Theme
      ///
      themeMode: themeMode,

      ///
      /// Localization
      ///
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
     )
    );
  }
}
