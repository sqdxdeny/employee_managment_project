part of 'home_screen.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({super.key});

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Home'),
    Text('Index 1: Tasks'),
    Text('Index 2: Requests'),
    Text('Index 3: Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6507FF), Color(0xFF9008D2), Color(0xFF6507FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          LocaleKeys.home_screen_title.tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: null,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add_alert_rounded),
          ),
        ],
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: 'Requests'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF6507FF),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex;
    });
  }
}
