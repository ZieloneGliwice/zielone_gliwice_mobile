import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeocoderInfo {
  GeocoderInfo(
      this._latitude,
      this._longitude,
      this.city,
      this.zipcode,
      this.streetName,
      this.streetNumber,
      );

  factory GeocoderInfo.fromJson(Map<String, dynamic> json) {
    return GeocoderInfo(
        json['latitude'] as double?,
        json['longitude'] as double?,
        json['city'] as String?,
        json['zipcode'] as String?,
        json['streetName'] as String?,
        json['streetNumber'] as String?,
    );
  }

  final double? _latitude;
  final double? _longitude;
  final String? city;
  final String? zipcode;
  final String? streetName;
  final String? streetNumber;

  LatLng? location() {
    if (_latitude != null && _longitude != null) {
      return LatLng(_latitude!, _longitude!);
    }

    return null;
  }
}
