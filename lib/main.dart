import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project/redux/app/app_state.dart' as app;
import 'package:project/ui/note_list.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<app.AppState>(
    app.reducer,
    initialState: app.AppState.initialState(),
  );

  runApp(MyApp(
    title: 'Flutter Redux Demo',
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<app.AppState> store;
  final String title;

  const MyApp({
    Key? key,
    required this.store,
    required this.title,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<app.AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        home: NoteList(),
      ),
    );
  }
}
