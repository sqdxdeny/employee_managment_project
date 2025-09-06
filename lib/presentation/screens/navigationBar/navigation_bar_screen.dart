import 'package:employee_managment_project/presentation/routes/router.dart';
import 'package:flutter/material.dart';

part 'navigation_bar_form.dart';

@RoutePage()
class NavigationBarScreen extends StatelessWidget {
  const NavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBarForm();
  }
}
