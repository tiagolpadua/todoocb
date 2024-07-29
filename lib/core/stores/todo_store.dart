import 'package:mobx/mobx.dart';
import 'package:todoocb/core/helpers/dio_helper.dart';
import 'package:todoocb/core/models/todo_model.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStore with _$TodoStore;

abstract class _TodoStore with Store {
  var _dio = DioHelper().dio();

  var _nextId = 3;

  @observable
  var todos = ObservableList<Todo>.of([
    Todo(id: 1, titulo: 'Estudar MobX AAA'),
    Todo(id: 2, titulo: 'Estudar Flutter AAA'),
  ]);

  @action
  void add(String titulo) {
    todos.add(Todo(id: _nextId, titulo: titulo));
    _nextId++;
    print("todos: $todos");
  }

  @action
  void remove(int id) {
    todos.removeWhere((todo) => todo.id == id);
  }

  @action
  Todo getById(int id) {
    return todos.firstWhere((todo) => todo.id == id);
  }

  @action
  Future<void> fetchTodos() async {
    final response = await _dio.get('/todos');
    todos.clear();
    var todosAPI = (response.data as List).map((json) => Todo.fromJson(json));
    todos.addAll(todosAPI);
  }
}
