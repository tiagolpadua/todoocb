import 'package:flutter/material.dart';
import 'package:todoocb/core/models/todo_model.dart';

class CardTodo extends StatelessWidget {
  const CardTodo({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Título:"),
        Text(todo.titulo),
      ],
    );
  }
}
