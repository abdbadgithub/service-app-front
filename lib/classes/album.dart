class Album {
  final int id;
  final String email;
  final String name;

  const Album({
    required this.id,
    required this.email,
    required this.name,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'id': int id,
      'email': String email,
      'name': String name,
      } =>
          Album(
            id: id,
            email: email,
            name: name,
          ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}