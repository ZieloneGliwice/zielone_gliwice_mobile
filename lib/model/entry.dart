class Entry {
  Entry({this.userName, this.points});

  factory Entry.fromJson(dynamic json) {
    return Entry(
      userName: json['userName'] as String?,
      points: json['points'] as int?,
    );
  }

  final String? userName;
  final int? points;
}
