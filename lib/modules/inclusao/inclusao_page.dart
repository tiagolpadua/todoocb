import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todoocb/core/stores/todo_store.dart';

class InclusaoPage extends StatefulWidget {
  InclusaoPage({super.key});

  @override
  State<InclusaoPage> createState() => _InclusaoPageState();
}

class _InclusaoPageState extends State<InclusaoPage> {
  final todoStore = Modular.get<TodoStore>();

  final _tituloController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _tituloController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Forneça algum texto';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Digite o texto',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Processing Data')),
                    // );
                    todoStore.add(_tituloController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Todo incluído!')),
                    );
                    Modular.to.pop();
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _tituloController.dispose();
    super.dispose();
  }
}
