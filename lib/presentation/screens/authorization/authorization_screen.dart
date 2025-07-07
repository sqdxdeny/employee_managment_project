import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:employee_managment_project/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

@RoutePage()

class AuthorizationScreen extends StatelessWidget {
  const AuthorizationScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.authorization__title.tr()),
      ),
      body: FloatingActionButton(onPressed: () {
        if (context.locale == Locale('en')) {
          context.setLocale(Locale('ru'));
        } else {context.setLocale(Locale('en'));}
      }),
    );
  }
}
