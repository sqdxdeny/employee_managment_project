import 'dart:io';

import 'package:employee_managment_project/application/profile_watcher/profile_watcher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee_managment_project/application/profile/profile_editor_bloc.dart';
import 'package:employee_managment_project/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

part 'profile_form.dart';


@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileWatcherBloc>();

      return BlocProvider(
        create: (context) => ProfileEditorBloc(bloc),
        child: const ProfileEditorForm(),
      );
  }
}
