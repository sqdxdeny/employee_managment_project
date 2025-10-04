part of 'profile_screen.dart';

class ProfileEditorForm extends StatefulWidget {
  const ProfileEditorForm({super.key});

  @override
  State<ProfileEditorForm> createState() => _ProfileEditorFormState();
}

class _ProfileEditorFormState extends State<ProfileEditorForm> {
  Widget get _body {
    return ListView(
      children: [
        SizedBox(height: 20),
        Padding(padding: const EdgeInsets.all(12.0), child: _imagePicker),
        Padding(padding: const EdgeInsets.all(12.0), child: _loginChanger),
        Padding(padding: const EdgeInsets.all(12.0), child: _passwordChanger),
      ],
    );
  }

  Widget get _loginChanger {
    return BlocBuilder<ProfileEditorBloc, ProfileEditorState>(
      buildWhen: (p, c) => p.login != c.login,
      builder: (context, state) {
        return Center(
          child: TextFormField(
            initialValue: state.login,
            decoration: InputDecoration(
              labelText: LocaleKeys.authorization__login_.tr(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              final bloc = context.read<ProfileEditorBloc>();
              bloc.add(ProfileEditorEvent.changeLogin(value));
            },
          ),
        );
      },
    );
  }

  Widget get _passwordChanger {
    return BlocBuilder<ProfileEditorBloc, ProfileEditorState>(
      buildWhen: (p, c) => p.password != c.password,
      builder: (context, state) {
        return Center(
          child: TextFormField(
            initialValue: state.password,
            decoration: InputDecoration(
              labelText: LocaleKeys.authorization__password_.tr(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              final bloc = context.read<ProfileEditorBloc>();
              bloc.add(ProfileEditorEvent.changePassword(value));
            },
          ),
        );
      },
    );
  }

  Widget _circleAvatar(BuildContext context) {
    return BlocBuilder<ProfileEditorBloc, ProfileEditorState>(
      builder: (context, state) {
        return CircleAvatar(
          backgroundColor: Colors.black,
          radius: 60,
          backgroundImage:
              state.image != null ? FileImage(File(state.image!)) : null,
          child:
              state.image == null
                  ? Icon(Icons.person, size: 60, color: Color(0xFFC0C0C0))
                  : null,
        );
      },
    );
  }

  Widget get _imagePicker {
    return BlocBuilder<ProfileEditorBloc, ProfileEditorState>(
      buildWhen: (p, c) => p.image != c.image,
      builder: (context, state) {
        return Center(
          child: GestureDetector(
            onTap: () async {
              final pickedFile = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (pickedFile != null && context.mounted) {
                context.read<ProfileEditorBloc>().add(
                  ProfileEditorEvent.changeImage(pickedFile.path),
                );
              }
            },
            child: _circleAvatar(context),
          ),
        );
      },
    );
  }

  Widget get _floatingActionButton {
    return BlocSelector<ProfileEditorBloc, ProfileEditorState, bool>(
      selector: (state) => state.enableSave,
      builder: (context, enableSave) {
        return FloatingActionButton.extended(
          onPressed:
              enableSave
                  ? () {
                    final bloc = context.read<ProfileEditorBloc>();
                    bloc.add(ProfileEditorEvent.save());
                  }
                  : null,
          label: Text(LocaleKeys.profile_screen_button_save.tr()),
          icon: Icon(Icons.save_outlined, color: Color(0xFFC0C0C0)),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 8,
        );
      },
    );
  }

  List<Widget> _actions(BuildContext context) {
    return [_signOut(context)];
  }

  Widget _signOut(BuildContext context) {
    return IconButton(
      onPressed: () {
        final bloc = context.read<ProfileWatcherBloc>();
        bloc.add(ProfileWatcherEvent.signOut());
        context.router.replaceAll([AuthorizationRoute()]);
      },
      icon: Icon(Icons.exit_to_app_outlined, color: Color(0xFFC0C0C0),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.profile_screen_title.tr(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF000000),
        actions: _actions(context),
      ),
      floatingActionButton: _floatingActionButton,
      body: _body,
    );
  }
}
