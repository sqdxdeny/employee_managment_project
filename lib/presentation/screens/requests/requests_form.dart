part of 'requests_screen.dart';

class RequestsForm extends StatelessWidget {
  const RequestsForm({super.key});

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF000000),
      title: Text(
        LocaleKeys.requests_screen_title.tr(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _bodyPadding(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Column(children: [Center(child: Text('Requests_screen >XD'))]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(context), body: _bodyPadding(context));
  }
}
