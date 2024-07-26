import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetalhePage extends StatelessWidget {
  const DetalhePage({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhe')),
      body: Center(
        child: Column(
          children: [
            Text("Detalhando id: $id"),
            ElevatedButton(
              onPressed: () => Modular.to.pop(),
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
