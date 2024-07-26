import 'package:mobx/mobx.dart';
import 'package:todoocb/core/models/todo_model.dart';

// Include generated file
part 'todo_store.g.dart';

// This is the class used by rest of your codebase
class TodoStore = _TodoStore with _$TodoStore;

// The store-class
abstract class _TodoStore with Store {
  var _nextId = 3;

  @observable
  var todos = <Todo>[
    Todo(id: 1, titulo: 'Estudar MobX'),
    Todo(id: 2, titulo: 'Estudar Flutter'),
  ];

  @action
  void add(String titulo) {
    todos.add(Todo(id: _nextId, titulo: titulo));
    _nextId++;
  }

  @action
  void remove(int id) {
    todos.removeWhere((todo) => todo.id == id);
  }
}
