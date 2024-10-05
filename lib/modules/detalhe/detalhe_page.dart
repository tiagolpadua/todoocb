import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todoocb/core/stores/todo_store.dart';
import 'package:todoocb/modules/detalhe/card_todo.dart';

class DetalhePage extends StatelessWidget {
  DetalhePage({
    super.key,
    required this.id,
  });

  final int id;

  final todoStore = Modular.get<TodoStore>();

  @override
  Widget build(BuildContext context) {
    var todo = todoStore.todos.firstWhere((todo) => todo.id == id);
    return Scaffold(
      appBar: AppBar(title: Text('Detalhe')),
      body: Center(
        child: Column(
          children: [
            CardTodo(todo: todo),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Modular.to.pop(),
                  child: Text('Voltar'),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Excluir Todo'),
                          content:
                              Text('Tem certeza que deseja excluir este todo?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                todoStore.remove(todo.id);
                                Modular.to.popUntil(
                                    (route) => route.settings.name == '/');
                              },
                              child: Text('Sim'),
                            ),
                            TextButton(
                              onPressed: () {
                                Modular.to.pop();
                              },
                              child: Text('Não'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
