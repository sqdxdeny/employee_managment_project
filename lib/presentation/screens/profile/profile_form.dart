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
        Padding(padding: const EdgeInsets.all(8.0), child: _imagePicker),
        Padding(padding: const EdgeInsets.all(8.0), child: _loginChanger),
        Padding(padding: const EdgeInsets.all(8.0), child: _passwordChanger),
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
            decoration: InputDecoration(labelText: LocaleKeys.authorization__login_.tr(), border: OutlineInputBorder()),
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
              border: OutlineInputBorder(),
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

  Widget get _imagePicker {
    return BlocBuilder<ProfileEditorBloc, ProfileEditorState>(
      buildWhen: (p, c) => p.image != c.image,
      builder: (context, state) {
        return Center(
          child: GestureDetector(
            onTap: () async {
              final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null && context.mounted) {
                context.read<ProfileEditorBloc>().add(ProfileEditorEvent.changeImage(pickedFile.path));
              }
            },
            child: CircleAvatar(
              radius: 60,
              backgroundImage: state.image != null ? FileImage(File(state.image!)) : null,
              child: state.image == null ? Icon(Icons.person, size: 60) : null,
            ),
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
          label: Text('Save'),
          icon: Icon(Icons.save_outlined),
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
      icon: Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF12345E), Color(0xFFE5897B), Color(0xFF12345E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: _actions(context),
      ),
      floatingActionButton: _floatingActionButton,
      body: _body,
    );
  }
}