import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project/redux/app/app_state.dart' as app;

class NoteList extends StatelessWidget {
  NoteList({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      floatingActionButton: StoreConnector<app.AppState, VoidCallback>(
        converter: (store) => () => store.dispatch(app.AddItemToList('New Item')),
        builder: (context, callback) {
          return FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Alert Dialog"),
                    content: Column(
                      children: [
                        TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Title',
                          ),
                        ),
                        StoreConnector<app.AppState, VoidCallback>(
                          converter: (store) => () => store.dispatch(app.AddItemToList(_controller.text)),
                          builder: (context, callback) {
                            return MaterialButton(
                              onPressed: () {
                                callback();
                                _controller.clear();
                                Navigator.pop(context);
                              },
                              child: const Text('Add'),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );

              //callback();

              // state.dispatch(app.AddItemToList('New Item'));
            },
            child: const Icon(Icons.add),
          );
        },
      ),
      body: StoreConnector<app.AppState, app.AppState>(
        converter: (store) => store.state,
        builder: (context, state) => ListView.builder(
          itemCount: state.list.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(state.list[index]),
            leading: const Icon(Icons.note),
            trailing: StoreConnector<app.AppState, VoidCallback>(
              converter: (store) => () => store.dispatch(app.RemoveItemToList(index)),
              builder: (context, callback) {
                return IconButton(
                    onPressed: () {
                      callback();
                    },
                    icon: const Icon(Icons.delete));
              },
            ),
          ),
        ),
      ),
    );
  }
}
