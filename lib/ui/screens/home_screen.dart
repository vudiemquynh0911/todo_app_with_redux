import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:manabietodo/models/app_state.dart';
import 'package:manabietodo/models/task_model.dart';
import 'package:manabietodo/redux/actions.dart';
import 'package:manabietodo/ui/dialogs/add_new_dialog.dart';
import 'package:manabietodo/ui/screens/task_page.dart';
import 'package:redux/redux.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  var _pageController = PageController(keepPage: true);
  _ViewModel _viewmodel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Todo List", style: TextStyle(color: Colors.blue)),
          actions: <Widget>[
            Container(
                margin: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.blue, size: 30),
                  onPressed: _onAddNewTask,
                ))
          ]),
      body: StoreConnector<AppState, _ViewModel>(
          converter: (Store<AppState> store) => _ViewModel.create(store),
          builder: (BuildContext context, _ViewModel viewModel) {
            _viewmodel = viewModel;
            List<TaskModel> taskList = List.from(viewModel.tasks);
            var _pages = [
              TaskPage(taskList, _onTaskTap, TaskPageFrom.all),
              TaskPage(
                  getPendingTasks(taskList), _onTaskTap, TaskPageFrom.pending),
              TaskPage(
                  getCompleteTasks(taskList), _onTaskTap, TaskPageFrom.complete)
            ];
            return PageView(
              children: _pages,
              onPageChanged: (page) {
                setState(() {
                  _selectedPage = page;
                });
              },
              controller: _pageController,
            );
          }),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                title: Text('All Tasks', key: Key('all-task'))),
            BottomNavigationBarItem(
                icon: Icon(Icons.watch_later),
                title: Text('Todo', key: Key('todo'))),
            BottomNavigationBarItem(
                icon: Icon(Icons.done_all),
                title: Text("Done Tasks", key: Key('done-task'))),
          ],
          currentIndex: _selectedPage,
          onTap: (page) => _onPageChanged(page)),
    );
  }

  _onPageChanged(int page) {
    setState(() {
      _selectedPage = page;
    });
    _pageController.jumpToPage(_selectedPage);
  }

  _onAddNewTask() async {
    TaskModel newTask = await showAddNewDialog(context);
    if (newTask == null) return;
    _viewmodel.onAddTask(newTask);
  }

  _onTaskTap(int taskId) {
    _viewmodel.onTapTask(taskId);
  }
}

class _ViewModel {
  final List<TaskModel> tasks;
  final Function(TaskModel) onAddTask;
  final Function(int) onTapTask;

  _ViewModel({this.tasks, this.onAddTask, this.onTapTask});

  factory _ViewModel.create(Store<AppState> store) {
    _onAddTask(TaskModel task) {
      store.dispatch(AddTaskAction(task));
    }

    _onTapTask(int taskId) {
      store.dispatch(TapTaskAction(taskId));
    }

    return _ViewModel(
      tasks: store.state.tasks,
      onAddTask: _onAddTask,
      onTapTask: _onTapTask,
    );
  }
}
