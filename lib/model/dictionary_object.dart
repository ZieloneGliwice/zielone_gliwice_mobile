class DictionaryObject {
  DictionaryObject({
    required this.id,
    required this.name
  });

  factory DictionaryObject.fromJson(dynamic json) {
    return DictionaryObject(
        id: json['id'] as String?,
      name: json['name'] as String?

    );
  }

  final String? id;
  final String? name;
}
