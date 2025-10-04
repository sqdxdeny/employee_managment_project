import 'package:easy_localization/easy_localization.dart';
import 'package:employee_managment_project/application/profile_watcher/profile_watcher_bloc.dart';
import 'package:employee_managment_project/application/requests/requests_bloc.dart';
import 'package:employee_managment_project/application/tasks/tasks_bloc.dart';
import 'package:employee_managment_project/domain/tasks/task.dart';
import 'package:employee_managment_project/generated/locale_keys.g.dart';
import 'package:employee_managment_project/infrastructure/tasks/tasks_repository.dart';
import 'package:employee_managment_project/presentation/routes/router.dart';
import 'package:employee_managment_project/presentation/screens/home/circular_chart_colors.dart';
import 'package:employee_managment_project/presentation/screens/home/widgets/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_form.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeForm();
  }
}
