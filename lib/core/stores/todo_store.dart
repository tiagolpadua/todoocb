import 'package:mobx/mobx.dart';
import 'package:todoocb/core/helpers/dio_helper.dart';
import 'package:todoocb/core/models/todo_model.dart';

// import 'package:dio/dio.dart';

part 'todo_store.g.dart';

// final dio = Dio();

// final options = BaseOptions(
//   baseUrl: 'http://10.0.2.2:3000',
//   connectTimeout: Duration(seconds: 5),
//   receiveTimeout: Duration(seconds: 3),
// );
// final dio = Dio(options);

class TodoStore = _TodoStore with _$TodoStore;

abstract class _TodoStore with Store {
  var _dio = DioHelper().dio();

  @observable
  var todos = ObservableList<Todo>.of([]);
  // var todos = ObservableList<Todo>.of([
  //   Todo(id: 1, titulo: 'Estudar MobX'),
  //   Todo(id: 2, titulo: 'Estudar Flutter')
  // ]);

  @action
  Future<void> add(String newTodo) async {
    var id = _getNextId();
    var todo = Todo(id: id, titulo: newTodo);
    await _dio.post("/todos", data: todo.toJson());
    await fetchTodos();
  }

  @action
  Future<void> remove(int id) async {
    await _dio.delete("/todos/$id");
    await fetchTodos();
    // todos.removeWhere((todo) => todo.id == id);
  }

  // @action
  // void addRandom() {
  //   add(WordPair.random().toString());
  // }

  @action
  Future<void> fetchTodos() async {
    // final response = await dio.get('http://localhost:3000/todos');
    final response = await _dio.get('/todos');
    // print("response $response");

    // responseData.forEach((json) => print(json));
    var todoList =
        (response.data as List).map((json) => Todo.fromJson(json)).toList();
    // print("todoList $todoList");
    todos.clear();
    todos.addAll(todoList);
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
}
