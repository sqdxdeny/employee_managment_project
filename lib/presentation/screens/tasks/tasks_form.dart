part of 'tasks_screen.dart';

class TasksForm extends StatefulWidget {
  const TasksForm({super.key});

  @override
  State<TasksForm> createState() => _TasksFormState();
}

class _TasksFormState extends State<TasksForm> {
  final StreamController<DateTime> _dateStreamController = StreamController<DateTime>.broadcast();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(days: 1), (timer) {
      _dateStreamController.sink.add(DateTime.now());
    });
  }

  // вывод текущей даты
  Widget _dateStream(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: _dateStreamController.stream,
      builder: (context, snapshot) {
        final date = snapshot.data ?? DateTime.now();
        final formattedDate = DateFormat('EEEE, d MMMM').format(date);
        return Text(
          formattedDate,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        );
      },
    );
  }

  // 'Today's task' заголовок
  Widget _todayTask(BuildContext context) {
    return Text(
      LocaleKeys.tasks_screen_main_title.tr(),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // кнопка фильтра
  Widget _filter(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      icon: const Icon(Icons.filter_alt_outlined, color: Color(0xFF282828)),
      label: Text(
        LocaleKeys.tasks_screen_button_filter.tr(),
        style: const TextStyle(color: Color(0xFF282828)),
      ),
      onPressed: () {
        final current = context.read<TasksBloc>().state.filter;
        final next = switch (current) {
          TaskFilter.all => TaskFilter.open,
          TaskFilter.open => TaskFilter.completed,
          TaskFilter.completed => TaskFilter.all,
        };
        context.read<TasksBloc>().add(TasksEvent.setFilter(next));
      },
    );
  }

  // кнопка сортировки
  Widget _sort(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      icon: const Icon(Icons.sort_outlined, color: Color(0xFF282828)),
      label: Text(
        LocaleKeys.tasks_screen_button_sort.tr(),
        style: const TextStyle(color: Color(0xFF282828)),
      ),
      onPressed: () {
        final current = context.read<TasksBloc>().state.sort;
        final newSort = current == TaskSort.byDateAsc ? TaskSort.byDateDesc : TaskSort.byDateAsc;
        context.read<TasksBloc>().add(TasksEvent.setSort(newSort));
      },
    );
  }

  // Окно добавления новой задачи
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
            title: const Text('New Task'),
            content: Column(
              spacing: 20,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: authorController,
                  decoration: const InputDecoration(labelText: 'Author'),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(dialogContext),
              ),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  final task = Task(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text,
                    description: descriptionController.text,
                    author: authorController.text,
                    createdAt: DateTime.now(),
                    isCompleted: false, // ✅ всегда новая — незавершенная
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

  // кнопка добавить задачу
  Widget _buttonNewTask(BuildContext context) {
    return ElevatedButton.icon(
      style: elevatedButtonTheme,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(
        LocaleKeys.tasks_screen_button_task.tr(),
        style: const TextStyle(color: Colors.white),
      ),
      onPressed: () => _showAddTaskDialog(context),
    );
  }

  // Таб бар для переключения задач
  Widget _tabBar(BuildContext context) {
    return const TabBar(
      indicatorColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.black,
      tabs: [
        Tab(text: "All"),
        Tab(text: "Open"),
        Tab(text: "Completed"),
      ],
    );
  }

  // карточки задач
  Widget _card(BuildContext context, List<Task> tasks) {
    return ListView.builder(
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
                  ),
                  onPressed: () {
                    context.read<TasksBloc>().add(TasksEvent.toggleTaskCompletion(task.id));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    context.read<TasksBloc>().add(TasksEvent.deleteTask(task.id));
                  },
                ),
              ],
            ),
            onTap: () => _showTaskDetails(context, task),
          ),
        );
      },
    );
  }

  // детали задачи
  void _showTaskDetails(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(task.title ?? "Без названия"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Описание: ${task.description}"),
                const SizedBox(height: 8),
                Text("Автор: ${task.author}"),
                const SizedBox(height: 8),
                Text("Создано: ${DateFormat('dd.MM.yyyy HH:mm').format(task.createdAt)}"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Закрыть"),
              ),
            ],
          ),
    );
  }

  Widget _tabContext(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          // применяем фильтрацию и сортировку
          final all = applyFilterAndSort(state, TaskFilter.all);
          final open = applyFilterAndSort(state, TaskFilter.open);
          final completed = applyFilterAndSort(state, TaskFilter.completed);

          return TabBarView(
            children: [
              _card(context, all),
              _card(context, open),
              _card(context, completed),
            ],
          );
        },
      ),
    );
  }

  // TabBarView для отображения списка
  Widget _bodyPadding(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: DefaultTabController(
        length: 3,
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _todayTask(context),
            _dateStream(context),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              children: [
                _filter(context),
                _sort(context),
                _buttonNewTask(context),
              ],
            ),
            _tabBar(context),
            _tabContext(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Color(0xFFC0C0C0)),
            onPressed: () {
              context.router.navigate(ProfileRoute());
            },
          ),
        ],
        backgroundColor: Colors.black,
        title: Text(
          LocaleKeys.tasks_screen_title.tr(),
          style: const TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _bodyPadding(context),
    );
  }
}

/// 🔹 вынес отдельную функцию для фильтрации/сортировки
List<Task> applyFilterAndSort(TasksState state, TaskFilter filter) {
  var tasks = List<Task>.from(state.tasks);

  // сортировка
  tasks.sort((a, b) {
    switch (state.sort) {
      case TaskSort.byDateAsc:
        return a.createdAt.compareTo(b.createdAt);
      case TaskSort.byDateDesc:
        return b.createdAt.compareTo(a.createdAt);
    }
  });

  // фильтр
  return switch (filter) {
    TaskFilter.all => tasks,
    TaskFilter.open => tasks.where((t) => !t.isCompleted).toList(),
    TaskFilter.completed => tasks.where((t) => t.isCompleted).toList(),
  };
}
