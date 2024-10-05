class Todo {
  final int id;
  final String titulo;

  Todo({required this.id, required this.titulo});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: int.parse(json['id']),
      titulo: json['titulo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'titulo': titulo,
    };
  }

  @override
  String toString() {
    return 'Todo{id: $id, titulo: $titulo}';
  }
}
