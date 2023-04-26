class User {

  const User({
    required this.id
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
        id: json?['userId'] as String
    );
  }
  final String? id;
}
