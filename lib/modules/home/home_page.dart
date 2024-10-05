import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todoocb/core/stores/todo_store.dart';

// var todoStore = TodoStore();

class HomePage extends StatefulWidget {
  HomePage() {}

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoStore = Modular.get<TodoStore>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    setState(() => isLoading = true);
    Future.delayed(Duration(seconds: 2), () async {
      await todoStore.fetchTodos();
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de TODOs')),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Observer(
                builder: (_) => Column(
                      children: todoStore.todos
                          .map((todo) => ElevatedButton(
                                onPressed: () =>
                                    Modular.to.pushNamed('/detalhe/${todo.id}'),
                                child: Text(todo.titulo),
                              ))
                          .toList(),
                    )),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => todoStore.addRandom(),
      //   tooltip: 'Add',
      //   child: const Icon(Icons.add),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Modular.to.pushNamed('/inclusao'),
        // onPressed: () => todoStore.list(),
        tooltip: 'Incluir',
        child: const Icon(Icons.add),
      ),
    );
  }
}
