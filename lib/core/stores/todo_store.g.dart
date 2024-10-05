// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TodoStore on _TodoStore, Store {
  late final _$todosAtom = Atom(name: '_TodoStore.todos', context: context);

  @override
  ObservableList<Todo> get todos {
    _$todosAtom.reportRead();
    return super.todos;
  }

  @override
  set todos(ObservableList<Todo> value) {
    _$todosAtom.reportWrite(value, super.todos, () {
      super.todos = value;
    });
  }

  late final _$addAsyncAction = AsyncAction('_TodoStore.add', context: context);

  @override
  Future<void> add(String newTodo) {
    return _$addAsyncAction.run(() => super.add(newTodo));
  }

  late final _$removeAsyncAction =
      AsyncAction('_TodoStore.remove', context: context);

  @override
  Future<void> remove(int id) {
    return _$removeAsyncAction.run(() => super.remove(id));
  }

  late final _$fetchTodosAsyncAction =
      AsyncAction('_TodoStore.fetchTodos', context: context);

  @override
  Future<void> fetchTodos() {
    return _$fetchTodosAsyncAction.run(() => super.fetchTodos());
  }

  @override
  String toString() {
    return '''
todos: ${todos}
    ''';
  }
}
