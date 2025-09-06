part of 'home_screen.dart';

class HomeForm extends StatelessWidget {
  const HomeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF000000),
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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_alert_rounded, color: Color(0xFFC0C0C0)),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person, color: Color(0xFFC0C0C0)),
          ),
        ],
      ),
      body: Column(children: [Text('Test')]),
    );
  }

  //   void _onItemTapped(int index) {
  //     setState(() {
  //       _selectedIndex;
  //     });
  //     context.router.replaceAll([MainRoutes.values[index].route]);
  //   }
  //
  // }
  //
  // enum MainRoutes { home, tasks, requests, profile }
  //
  // extension MainRoutesString on MainRoutes {
  //   String get label {
  //     switch (this) {
  //       case MainRoutes.home:
  //         return 'Home';
  //       case MainRoutes.tasks:
  //         return 'Tasks';
  //       case MainRoutes.requests:
  //         return 'Requests';
  //       case MainRoutes.profile:
  //         return 'Profile';
  //     }
  //   }
  //
  //   IconData get icon {
  //     switch (this) {
  //       case MainRoutes.home : return Icons.home;
  //       case MainRoutes.tasks : return Icons.list;
  //       case MainRoutes.requests : return Icons.send;
  //       case MainRoutes.profile : return Icons.person;
  //     }
  //   }
  //
  //   PageRouteInfo get route {
  //     switch (this) {
  //       case MainRoutes.home : return HomeRoute();
  //       case MainRoutes.tasks : return TasksRoute();
  //       case MainRoutes.requests : return HomeRoute();
  //       case MainRoutes.profile : return ProfileRoute();
  //
  //     }
  //   }
  //
}
