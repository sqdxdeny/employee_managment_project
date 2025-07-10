part of 'authorization_screen.dart';

class AuthorizationForm extends StatelessWidget {
  const AuthorizationForm({super.key});

  Widget _loginBar(BuildContext context) { /// ПОЛЕ С ЛОГИНОМ
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

  Widget _passwordBar(BuildContext context) { /// ПОЛЕ С ПАРОЛЕМ
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

  Widget _buttonContinue() { /// КНОПКА ПРОДОЛЖИТь
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
      buildWhen: (p, c) => p.login != c.login || p.password != c.password,

      builder: (context, state) {
        if ((state.login?.isEmpty ?? true) ||
            (state.password?.isEmpty ?? true)) {
          return const SizedBox();
        } else {
          return ElevatedButton(
            onPressed: () {
              context.router.navigate(HomeRoute());
            },
            child: Text(LocaleKeys.continue_.tr()),
          );
        }
      },
    );
  }

  Widget _bodyPadding(BuildContext context) { /// Тело
    /// Поле логина и пароля
    return Padding(
      padding: const EdgeInsets.all(16.0),
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

  PreferredSizeWidget _appBarBottom(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(110),
      child: Container(
        height: 110,
        child: Center(
          child: Text(
            LocaleKeys.authorization__title.tr(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6507FF), Color(0xFF9008D2), Color(0xFF6507FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      leading: _languageButton(context),
      bottom: _appBarBottom(context),
    );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _bodyPadding(context),
    );
  }
}
