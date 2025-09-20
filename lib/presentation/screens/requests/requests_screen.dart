import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:employee_managment_project/generated/locale_keys.g.dart';
import 'package:employee_managment_project/presentation/routes/router.dart';
import 'package:flutter/material.dart';

part 'requests_form.dart';

@RoutePage()
class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RequestsForm();
  }
}
