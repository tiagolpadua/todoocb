import 'package:mobx/mobx.dart';
import 'package:todoocb/core/helpers/dio_helper.dart';
import 'package:todoocb/core/models/todo_model.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStore with _$TodoStore;

abstract class _TodoStore with Store {
  var _dio = DioHelper().dio();

  @observable
  var todos = ObservableList<Todo>.of([]);

  @action
  Future<void> add(String titulo) async {
    var todo = Todo(id: _getNextId(), titulo: titulo);
    await _dio.post("/todos", data: todo.toJson());
    await fetchTodos();
  }

  int _getNextId() {
    if (todos.isEmpty) {
      return 1; // Se a lista estiver vazia, o próximo ID disponível é 1
    }

    // Extrair todos os IDs existentes
    List<int> ids = todos.map((todo) => todo.id).toList();

    // Encontrar o maior ID
    int maxId = ids.reduce((curr, next) => curr > next ? curr : next);

    // Retornar o próximo ID disponível
    return maxId + 1;
  }

  @action
  Future<void> remove(int id) async {
    await _dio.delete("/todos/$id");
    await fetchTodos();
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
