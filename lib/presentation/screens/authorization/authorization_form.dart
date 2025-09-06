part of 'authorization_screen.dart';

class AuthorizationForm extends StatelessWidget {
  const AuthorizationForm({super.key});

  Widget _logo(BuildContext context) {
    return Center(
      child: Container(
        child: Image.asset('assets/logo/sqd_logo.png', width: 350, height: 350),
      ),
    );
  }

  /// LOGIN BAR

  Widget _loginBar(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: LocaleKeys.authorization__login_.tr(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: (value) {
        final bloc = context.read<AuthorizationBloc>();
        bloc.add(AuthorizationEvent.updateLogin(value));
      },
    );
  }

  /// PASSWORD BAR

  Widget _passwordBar(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: LocaleKeys.authorization__password_.tr(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: (value) {
        final bloc = context.read<AuthorizationBloc>();
        bloc.add(AuthorizationEvent.updatePassword(value));
      },
    );
  }

  /// BUTTON CONTINUE

  Widget _buttonContinue() {
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
      buildWhen:
          (p, c) =>
              p.enableAuth != c.enableAuth ||
              p.enableNavigate != c.enableNavigate,
      builder: (context, state) {
        if (!state.enableAuth) {
          return const SizedBox();
        }

        return ElevatedButton(
          style: elevatedButtonTheme,
          onPressed: () {
            final bloc = context.read<AuthorizationBloc>();
            final enableNavigate = state.enableNavigate;
            if (enableNavigate) {
              context.router.replace(HomeRoute());
              bloc.add(AuthorizationEvent.authorize());
            } else {
              final sm = ScaffoldMessenger.of(context);
              final SnackBar text = SnackBar(
                content: Text('Login or pasword isn\'t valid'),
              );
              sm.showSnackBar(text);
            }
          },
          child: Text(
            LocaleKeys.continue__sign_in.tr(),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        );
      },
    );
  }

  //LOGIN AND PASSWORD // BODY //
  Widget _bodyPadding(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 75, horizontal: 25),
      child: Column(
        spacing: 20,
        children: [
          _logo(context),
          _loginBar(context),
          _passwordBar(context),
          _buttonContinue(),
        ],
      ),
    );
  }

  Widget _languageButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.language_outlined, color: Color(0xFFC0C0C0)),
      onPressed: () {
        if (context.locale == Locale('en')) {
          context.setLocale(Locale('ru'));
        } else {
          context.setLocale(Locale('en'));
        }
      },
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        LocaleKeys.authorization__title.tr(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Color(0xFF000000),
      centerTitle: true,
      leading: _languageButton(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: _appBar(context),
      body: _bodyPadding(context),
    );
  }
}
