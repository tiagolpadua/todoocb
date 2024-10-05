import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoocb/core/models/todo_model.dart';
import 'package:todoocb/modules/detalhe/card_todo.dart';

void main() {
  testWidgets('CardTodo displays the correct title',
      (WidgetTester tester) async {
    // Create a Todo instance for testing
    final todo = Todo(
      id: 1,
      titulo: 'Test Todo',
    );

    // Build the CardTodo widget with the test Todo
    await tester.pumpWidget(
      MaterialApp(
        home: CardTodo(
          todo: todo,
        ),
      ),
    );

    // debugDumpApp();

    // Verify that the title is displayed correctly
    expect(find.text('Título:'), findsOneWidget);
    expect(find.text('Test Todo'), findsOneWidget);
  });
}
