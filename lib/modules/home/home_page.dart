import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todoocb/core/stores/todo_store.dart';

// var todoStore = TodoStore();

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoStore = Modular.get<TodoStore>();

  bool isLoading = false;

  @override
  void initState() {
    print(">>>> initState");
    super.initState();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    setState(() => isLoading = true);
    await todoStore.fetchTodos();
    Future.delayed(Duration(seconds: 2), () {
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TODO OCB')),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Observer(
                builder: (context) => Column(
                  children: todoStore.todos
                      .map(
                        (todo) => ElevatedButton(
                          onPressed: () =>
                              Modular.to.pushNamed('/detalhe/${todo.id}').then(
                                    (_) => todoStore.fetchTodos(),
                                  ),
                          child: Text(todo.titulo),
                        ),
                      )
                      .toList(),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Modular.to.pushNamed('/inclusao'),
        // onPressed: () => todoStore.fetchTodos(),
        child: Icon(Icons.add),
      ),
    );
  }
}
