import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:employee_managment_project/application/tasks/tasks_bloc.dart';
import 'package:employee_managment_project/domain/tasks/task.dart';
import 'package:employee_managment_project/generated/locale_keys.g.dart';
import 'package:employee_managment_project/themes/elevated_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../routes/router.dart';

part 'tasks_form.dart';

@RoutePage()
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TasksForm();
  }
}
