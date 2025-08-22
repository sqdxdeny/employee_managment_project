part of 'authorization_screen.dart';

class AuthorizationForm extends StatelessWidget {
  const AuthorizationForm({super.key});

  Widget _loginBar(BuildContext context) {
    /// ПОЛЕ С ЛОГИНОМ
    return TextFormField(
      decoration: InputDecoration(
        labelText: LocaleKeys.authorization__login_.tr(),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        final bloc = context.read<AuthorizationBloc>();
        bloc.add(AuthorizationEvent.updateLogin(value));
      },
    );
  }

  Widget _passwordBar(BuildContext context) {
    /// ПОЛЕ С ПАРОЛЕМ
    return TextFormField(
      decoration: InputDecoration(
        labelText: LocaleKeys.authorization__password_.tr(),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        final bloc = context.read<AuthorizationBloc>();
        bloc.add(AuthorizationEvent.updatePassword(value));
      },
    );
  }

  /// КНОПКА ПРОДОЛЖИТь
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
          onPressed: () {
            final bloc = context.read<AuthorizationBloc>();
            final enableNavigate = state.enableNavigate;
            if (enableNavigate) {
              context.router.navigate(HomeRoute());
              bloc.add(AuthorizationEvent.authorize());
            } else {
              final sm = ScaffoldMessenger.of(context);
              final SnackBar text = SnackBar(content: Text ('Login or pasword isn\'t valid'));
              sm.showSnackBar(text);
            }
          },
          child: Text(LocaleKeys.continue_.tr()),
        );
      },
    );
  }

  //LOGIN AND PASSWORD // BODY //
  Widget _bodyPadding(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(75),
      child: Column(
        spacing: 20,
        children: [
          _loginBar(context),
          _passwordBar(context),
          _buttonContinue(),
        ],
      ),
    );
  }

  Widget _languageButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.language_outlined),
      // backgroundColor: Color(0xFF8B9BA1),
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
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: _languageButton(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(context),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF12345E), Color(0xFFE5897B), Color(0xFF12345E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: _bodyPadding(context),
      ),
    );
  }
}
