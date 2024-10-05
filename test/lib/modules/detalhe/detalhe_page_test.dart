import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todoocb/core/models/todo_model.dart';

@GenerateNiceMocks([MockSpec<TodoStore>()])
import 'package:todoocb/core/stores/todo_store.dart';

import 'package:todoocb/modules/app_module.dart';
import 'package:todoocb/modules/detalhe/detalhe_page.dart';
import 'detalhe_page_test.mocks.dart';

void main() {
  group('DetalhePage', () {
    late MockTodoStore mockTodoStore;

    setUp(() {
      mockTodoStore = MockTodoStore();
      Modular.bindModule(AppModule());
      Modular.replaceInstance<TodoStore>(mockTodoStore);
    });

    testWidgets('renders DetalhePage correctly', (WidgetTester tester) async {
      final todo = Todo(
        id: 1,
        titulo: 'Test Todo',
      );

      var todos = mobx.ObservableList<Todo>.of([todo]);
      when(mockTodoStore.todos).thenReturn(todos);

      await tester.pumpWidget(
        MaterialApp(
          home: DetalhePage(
            id: 1,
          ),
        ),
      );

      expect(find.text('Detalhe'), findsOneWidget);
      expect(find.text('Título:'), findsOneWidget);
      expect(find.text('Test Todo'), findsOneWidget);
      expect(find.text('Voltar'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('calls remove method when "Sim" button is pressed',
        (WidgetTester tester) async {
      final todo = Todo(
        id: 1,
        titulo: 'Test Todo',
      );

      var todos = mobx.ObservableList<Todo>.of([todo]);

      when(mockTodoStore.todos).thenReturn(todos);

      await tester.pumpWidget(
        MaterialApp(
          home: DetalhePage(
            id: 1,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('Excluir Todo'), findsOneWidget);
      expect(find.text('Tem certeza que deseja excluir este todo?'),
          findsOneWidget);

      await tester.tap(find.text('Sim'));
      await tester.pumpAndSettle();

      verify(mockTodoStore.remove(todo.id)).called(1);
    });

    testWidgets('calls pop method when "Não" button is pressed',
        (WidgetTester tester) async {
      final todo = Todo(
        id: 1,
        titulo: 'Test Todo',
      );

      var todos = mobx.ObservableList<Todo>.of([todo]);
      when(mockTodoStore.todos).thenReturn(todos);

      await tester.pumpWidget(
        MaterialApp(
          home: DetalhePage(
            id: 1,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('Excluir Todo'), findsOneWidget);
      expect(find.text('Tem certeza que deseja excluir este todo?'),
          findsOneWidget);

      await tester.tap(find.text('Não'));
      await tester.pumpAndSettle();

      verifyNever(mockTodoStore.remove(todo.id));
    });
  });
}
