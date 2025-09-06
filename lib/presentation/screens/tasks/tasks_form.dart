part of 'tasks_screen.dart';

class TasksForm extends StatefulWidget {
  const TasksForm({super.key});

  @override
  State<TasksForm> createState() => _TasksFormState();
}

class _TasksFormState extends State<TasksForm> {
  final StreamController<DateTime> _dateStreamController =
      StreamController<DateTime>.broadcast();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(days: 1), (timer) {
      _dateStreamController.sink.add(DateTime.now());
    });
  }

  Widget _dateStream(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: _dateStreamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final formattedDate = DateFormat(
            'EEEE, d MMMM',
          ).format(snapshot.data!);
          return Text(
            formattedDate,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          );
        } else {
          final initialDate = DateFormat('EEEE, d MMMM').format(DateTime.now());
          return Text(
            initialDate,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          );
        }
      },
    );
  }

  Widget _todayTask(BuildContext context) {
    return Text(
      LocaleKeys.tasks_screen_main_title.tr(),
      style: TextStyle(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _filter(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      icon: Icon(Icons.filter_alt_outlined, color: Color(0xFF282828)),
      label: Text(
        LocaleKeys.tasks_screen_button_filter.tr(),
        style: TextStyle(color: Color(0xFF282828)),
      ),
      onPressed: () {},
    );
  }

  Widget _sort(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      icon: Icon(Icons.sort_outlined, color: Color(0xFF282828)),
      label: Text(
        LocaleKeys.tasks_screen_button_sort.tr(),
        style: TextStyle(color: Color(0xFF282828)),
      ),
      onPressed: () {},
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final authorController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<TasksBloc>(),
          child: AlertDialog(
            title: Text('New Task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: authorController,
                  decoration: InputDecoration(labelText: 'Author'),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(dialogContext),
              ),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  final task = Task(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text,
                    description: descriptionController.text,
                    author: authorController.text,
                    createdAt: DateTime.now(),
                  );
                  context.read<TasksBloc>().add(TasksEvent.addTask(task));
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buttonNewTask(BuildContext context) {
    return ElevatedButton.icon(
      style: elevatedButtonTheme,
      icon: Icon(Icons.add, color: Colors.white),
      label: Text(
        LocaleKeys.tasks_screen_button_task.tr(),
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        _showAddTaskDialog(context);
      },
    );
  }

  Widget _tabBar(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.black,
      tabs: [
        Tab(text: LocaleKeys.tasks_screen_button_all.tr()),
        Tab(text: LocaleKeys.tasks_screen_button_open.tr()),
        Tab(text: LocaleKeys.tasks_screen_button_completed.tr()),
      ],
    );
  }

  void _showTaskDetails(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(task.title ?? 'Без названия'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Descripton: ${task.description}'),
              SizedBox(height: 8),
              Text('Author: ${task.author}'),
              SizedBox(height: 8),
              Text(
                'Pubplished at: ${DateFormat('dd.MM.yyyy HH:mm').format(task.createdAt)} ',
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Widget _card() {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.tasks.isEmpty) {
          return const Text('No tasks yet');
        }
        return ListView.builder(
          itemCount: state.tasks.length,
          itemBuilder: (context, index) {
            final task = state.tasks[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(task.title ?? 'No title'),
                subtitle: Text(task.description),
                trailing: Text(
                  '${task.createdAt.hour}:${task.createdAt.minute}',
                ),
                onTap: () => _showTaskDetails(context, task),
              ),
            );
          },
        );
      },
    );
  }

  Widget _tabContext(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          _card(),
          Center(child: Text('Open Tasks')),
          Center(child: Text('Completed Tasks')),
        ],
      ),
    );
  }

  Widget _bodyPadding(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6),
            _todayTask(context),
            SizedBox(height: 6),
            _dateStream(context),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _filter(context),
                _sort(context),
                _buttonNewTask(context),
              ],
            ),
            SizedBox(height: 12),
            _tabBar(context),
            _tabContext(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => TasksBloc()..add(const TasksEvent.loadTasks()),
        child: Builder(
          builder:
              (blocContext) => Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () {
                        context.router.navigate(ProfileRoute());
                      },
                    ),
                  ],
                  backgroundColor: Colors.black,
                  title: Text(
                    LocaleKeys.tasks_screen_title.tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: _bodyPadding(blocContext),
              ),
        ),
      ),
    );
  }
}
