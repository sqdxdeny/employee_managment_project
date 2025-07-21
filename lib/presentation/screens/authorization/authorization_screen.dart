import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:employee_managment_project/application/authorization//authorization_bloc.dart';
import 'package:employee_managment_project/generated/locale_keys.g.dart';
import 'package:employee_managment_project/presentation/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authorization_form.dart';

@RoutePage()
class AuthorizationScreen extends StatelessWidget {
  const AuthorizationScreen({super.key});

  @override
  Widget build (BuildContext context) {
    return BlocProvider(create: (context) => AuthorizationBloc(AuthorizationState()),
    child: const AuthorizationForm(),
    );
  }
}


