import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:manabietodo/models/task_model.dart';
import 'package:manabietodo/redux/actions.dart';
import 'package:manabietodo/models/app_state.dart';
import 'package:manabietodo/redux/middleware.dart';
import 'package:manabietodo/redux/reducers.dart';
import 'package:manabietodo/repository/task_repository.dart';
import 'package:manabietodo/ui/screens/home_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(TaskModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(
    appStateReducer,
    initialState: AppState.initState(),
    middleware: appStateMiddleware(hive: KeyValueStorage()),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.white,
            accentColor: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          home: StoreBuilder<AppState>(
                      onInit: (store) => store.dispatch(GetTaskAction()),
                      builder: (BuildContext context, Store<AppState> store) => HomeScreen())
          ),
    );
  }
}
