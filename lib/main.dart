import 'package:easy_localization/easy_localization.dart';
import 'package:employee_managment_project/presentation/app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      startLocale: const Locale('en'),
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: App(),
    ),
  );
}
