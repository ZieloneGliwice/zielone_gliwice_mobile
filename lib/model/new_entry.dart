import 'package:dio/dio.dart';

class NewEntry {
  NewEntry({
    this.userName,
    this.points,
  });

  factory NewEntry.fromJson(Map<String, dynamic> json) {
    return NewEntry(
      userName: json['userName'] as String?,
      points: json['points'] as int?,
    );
  }

  String? userName;
  int? points;

  Future<FormData> toFormData() async {
    final FormData formData = FormData.fromMap(<String, dynamic>{
      'userName': userName,
      'points': points,
    });

    return formData;
  }
}
