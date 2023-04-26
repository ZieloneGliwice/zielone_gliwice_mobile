import 'package:intl/intl.dart';

class MyTree {

  MyTree(
    this._sasToken,
      this._treeThumbnailUrl,{
    this.id,

    this.timestamp,
    this.lat,
    this.lon,
    this.species,
  });

  factory MyTree.fromJson(dynamic json, String? token) {

    final String? latLong = json['latLong'] as String?;
    final List<String>? latLongElements = latLong?.split(',');
    String? lat;
    String? lon;

    if (latLongElements != null && latLongElements.length == 2) {
      lat = latLongElements[0];
      lon = latLongElements[1];
    }

    return MyTree(
        token,
        json['treeThumbnailUrl'] as String?,
        id: json['id'] as String?,
        timestamp: json['_ts'] as int?,
        lat: lat,
        lon: lon,
        species: json['species'] as String?);
  }

  final String? id;
  final String? _treeThumbnailUrl;
  final int? timestamp;
  final String? lat;
  final String? lon;
  final String? species;
  final String? _sasToken;

  String formattedTimeStamp() {
    if (timestamp != null) {
      final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000);
      return DateFormat('dd.MM.yyyy, HH:mm').format(date);
    } else {
      return '-';
    }
  }

  String? treeThumbnailUrl() {
    if (_treeThumbnailUrl != null && _sasToken != null) {
      return '${_treeThumbnailUrl!}?${_sasToken!}';
    }

    return null;
  }
}
