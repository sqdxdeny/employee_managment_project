import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee_managment_project/application/profile/profile_bloc.dart';

part 'profile_form.dart';


@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {

      return BlocProvider(
        create: (context) => ProfileBloc(ProfileState()),
        child: const ProfileForm(),
      );
  }
}
