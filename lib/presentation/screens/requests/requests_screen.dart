import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:employee_managment_project/application/requests/requests_bloc.dart';
import 'package:employee_managment_project/domain/requets/request.dart';
import 'package:employee_managment_project/generated/locale_keys.g.dart';
import 'package:employee_managment_project/presentation/routes/router.dart';
import 'package:employee_managment_project/presentation/screens/requests/styles/type_style.dart';
import 'package:employee_managment_project/presentation/screens/widgets/account_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'requests_form.dart';

@RoutePage()
class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const RequestsForm();
  }
}
