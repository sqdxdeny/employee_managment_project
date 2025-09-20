import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:employee_managment_project/application/tasks/tasks_bloc.dart';
import 'package:employee_managment_project/domain/tasks/task.dart';
import 'package:employee_managment_project/generated/locale_keys.g.dart';
import 'package:employee_managment_project/presentation/routes/router.dart';
import 'package:employee_managment_project/presentation/screens/tasks/widgets/new_task_dialog.dart';
import 'package:employee_managment_project/presentation/screens/tasks/widgets/task_details_dialog.dart';
import 'package:employee_managment_project/themes/elevated_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tasks_form.dart';

@RoutePage()
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TasksBloc(),
      child: const TasksForm(),
    );
  }
}
