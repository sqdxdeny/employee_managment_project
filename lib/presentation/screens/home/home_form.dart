part of 'home_screen.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({super.key});

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  int touchedIndex = -1;

  bool isNumeric(String input) {
    final numericRegex = RegExp(r'^\d+$');
    return numericRegex.hasMatch(input);
  }

  Widget _helloUser(BuildContext context) {
    return BlocSelector<ProfileWatcherBloc, ProfileWatcherState, String?>(
      selector: (state) => state.profile.login,
      builder: (context, login) {
        final safeLogin = login ?? ''; //
        if (safeLogin.isEmpty || isNumeric(safeLogin)) {
          return Text(
            LocaleKeys.home_screen_greeting_noname.tr(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        return Text(
          '${LocaleKeys.home_screen_greeting.tr()} $login',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }

  Widget _pieChart(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, tasksState) {
        return BlocBuilder<RequestsBloc, RequestsState>(
          builder: (context, requestState) {
            final totalTasks = tasksState.tasks.length;
            final completedTasks = tasksState.tasks.where((t) => t.isCompleted).length;
            final pending = totalTasks - completedTasks;
            final totalRequests = requestState.requests.length;
            if (totalTasks == 0 && totalRequests == 0) {
              return Center(
                child: Text(
                  LocaleKeys.home_screen_no_data.tr(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              );
            }
            return PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 60,
                sections: [
                  PieChartSectionData(
                    color: CircularColors.tasksColorCompleted,
                    // Зеленый — завершённые
                    value: completedTasks.toDouble(),
                    title: '$completedTasks',
                    radius: 50,
                    borderSide: BorderSide(color: Colors.black54, width: 1.5),
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    color: CircularColors.tasksColorNotCompleted,
                    // Оранжевый — незавершённые
                    value: pending.toDouble(),
                    title: '$pending',
                    radius: 50,
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                    titleStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    color: CircularColors.requestsColor,
                    // Синий — реквесты
                    value: totalRequests.toDouble(),
                    title: '$totalRequests',
                    radius: 50,
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                    titleStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _pieChartInfoSquares(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Indicator(
          color: CircularColors.requestsColor,
          text: LocaleKeys.home_screen_requests.tr(),
          isSquare: true,
        ),
        Indicator(
          color: CircularColors.tasksColorNotCompleted,
          text: LocaleKeys.home_screen_tasks_in_progress.tr(),
          isSquare: true,
        ),
        Indicator(
          color: CircularColors.tasksColorCompleted,
          text: LocaleKeys.home_screen_tasks_in_progress.tr(),
          isSquare: true,
        ),
      ],
    );
  }

  Widget _listViewTasks(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        final tasks = state.tasks;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(task.title ?? "Без названия"),
                subtitle: Text(task.description),
                onTap: () {
                  context.router.push(TasksRoute());
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget get _textTasks {
    return Center(
      child: Text(
        LocaleKeys.home_screen_tasks.tr(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget get _textRequests {
    return Center(
      child: Text(
        LocaleKeys.home_screen_requests.tr(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _listViewRequests(BuildContext context) {
    return BlocBuilder<RequestsBloc, RequestsState>(
      builder: (context, state) {
        final requests = state.requests;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(request.title),
                subtitle: Text(request.description),
                onTap: () {
                  context.router.push(RequestsRoute());
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _bodyPadding(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _helloUser(context),
          SizedBox(
            height: 280,
            child: _pieChart(context),
          ),
          _pieChartInfoSquares(context),
          SizedBox(
            height: 10,
          ),
          _textTasks,
          Divider(color: CircularColors.tasksColorNotCompleted,),
          _listViewTasks(context),
          _textRequests,
          Divider(color: CircularColors.requestsColor,),
          _listViewRequests(context),
        ],
      ),
    );
  }

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
            onPressed: () {
              context.router.navigate(ProfileRoute());
            },
            icon: Icon(Icons.person, color: Color(0xFFC0C0C0)),
          ),
        ],
      ),
      body: _bodyPadding(context),
    );
  }
}
