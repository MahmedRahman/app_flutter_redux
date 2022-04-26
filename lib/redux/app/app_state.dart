import 'package:flutter/material.dart';

@immutable
class AppState {
  final List<String> list;

  const AppState(this.list);

  static initialState() {
    return const AppState([]);
  }
}

class Actions {}

class AddItemToList extends Actions {
  final String item;
  AddItemToList(this.item);
}

class RemoveItemToList extends Actions {
  final int index;
  RemoveItemToList(this.index);
}
// enum Actions { Add }

AppState reducer(AppState previousState, action) {
  final newList = previousState.list;
  if (action is AddItemToList) {
    newList.add(action.item);
    return AppState(newList);
  } else if (action is RemoveItemToList) {
    newList.removeAt(action.index);
    return AppState(newList);
  }

  return previousState;
}
