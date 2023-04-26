import 'package:google_maps_flutter/google_maps_flutter.dart';

class TreeDetails {
  TreeDetails(this._treeImageUrl, this._leafImageUrl, this._barkImageUrl, this.latLong, this.address, this.state, this.stateDescription, this._sasToken);

  factory TreeDetails.fromJson(Map<String, dynamic> json) {
    final String? location = json['latLong'] as String?;
    final List<String>? locationElements = location?.split(',');
    final double? lat = double.tryParse(locationElements?[0] ?? '');
    final double? lon = double.tryParse(locationElements?[1] ?? '');
    LatLng? treeLocation;

    if (lat != null && lon != null) {
      treeLocation = LatLng(lat, lon);
    }

    return TreeDetails(
        json['treeImageUrl'] as String?,
        json['leafImageUrl'] as String?,
        json['barkImageUrl'] as String?,
        treeLocation, json['address'] as String?,
        json['state'] as String?,
        json['stateDescription'] as String?,
        json['sasToken'] as String?
    );
  }

  final String? _treeImageUrl;
  final String? _leafImageUrl;
  final String? _barkImageUrl;
  final LatLng? latLong;
  final String? address;
  final String? state;
  final String? stateDescription;
  final String? _sasToken;

  String? treeImageUrl() {
    if (_treeImageUrl != null && _sasToken != null) {
      return '${_treeImageUrl!}?${_sasToken!}';
    }

    return null;
  }

  String? leafImageUrl() {
    if (_leafImageUrl != null && _sasToken != null) {
      return '${_leafImageUrl!}?${_sasToken!}';
    }

    return null;
  }

  String? barkImageUrl() {
    if (_barkImageUrl != null && _sasToken != null) {
      return '${_barkImageUrl!}?${_sasToken!}';
    }

    return null;
  }
}