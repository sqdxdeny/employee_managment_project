part of 'navigation_bar_screen.dart';

class NavigationBarForm extends StatelessWidget {
  const NavigationBarForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        TasksRoute(),
        RequestsRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder:
          (_, tabsRouter) => BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            selectedItemColor: const Color(0xFF7C0000),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
              BottomNavigationBarItem(
                icon: Icon(Icons.send),
                label: 'Requests',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
    );
  }
}
