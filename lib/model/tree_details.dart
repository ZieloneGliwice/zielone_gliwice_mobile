import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'geocoder_info.dart';

class TreeDetails {

  TreeDetails(
      this._treeImageUrl,
      this._leafImageUrl,
      this._barkImageUrl,
      this.species,
      this.description,
      this.perimeter,
      this.state,
      this.stateDescription,
      this.badState,
      this._latLng,
      this._geocoderInfo,
      this._sasToken
      );


  factory TreeDetails.fromJson(Map<String, dynamic> json) {
    final String? location = json['latLong'] as String?;
    final List<String>? locationElements = location?.split(',');
    final double? lat = double.tryParse(locationElements?[0] ?? '');
    final double? lon = double.tryParse(locationElements?[1] ?? '');
    LatLng? treeLocation;

    if (lat != null && lon != null) {
      treeLocation = LatLng(lat, lon);
    }

    GeocoderInfo? geocoderInfo;
    final Map<String, dynamic>? geocoderJson = json['geocoderInfo'] as Map<String, dynamic>?;

    if (geocoderJson != null) {
      geocoderInfo = GeocoderInfo.fromJson(geocoderJson);
    }

    return TreeDetails(
        json['treeImageUrl'] as String?,
        json['leafImageUrl'] as String?,
        json['barkImageUrl'] as String?,
        json['species'] as String?,
        json['description'] as String?,
        json['perimeter'] as int?,
        json['state'] as String?,
        json['stateDescription'] as String?,
        json['badState'] as String?,
        treeLocation,
        geocoderInfo,
        json['sasToken'] as String?
    );
  }

  final String? _treeImageUrl;
  final String? _leafImageUrl;
  final String? _barkImageUrl;
  final String? species;
  final String? description;
  final int? perimeter;
  final String? state;
  final String? stateDescription;
  final String? badState;
  final LatLng? _latLng;
  final GeocoderInfo? _geocoderInfo;
  final String? _sasToken;



  String? get treeImageUrl {
    if (_treeImageUrl != null && _sasToken != null) {
      return '${_treeImageUrl!}?${_sasToken!}';
    }

    return null;
  }

  String? get leafImageUrl {
    if (_leafImageUrl != null && _sasToken != null) {
      return '${_leafImageUrl!}?${_sasToken!}';
    }

    return null;
  }

  String? get barkImageUrl {
    if (_barkImageUrl != null && _sasToken != null) {
      return '${_barkImageUrl!}?${_sasToken!}';
    }

    return null;
  }

  List<String> get photos {
    return <String?>[treeImageUrl, leafImageUrl, barkImageUrl].whereType<String>().toList();
  }

  String? get address {
    final String address = <String?>[_geocoderInfo?.streetName, _geocoderInfo?.streetNumber].join(' ');
    final String town = <String?>[_geocoderInfo?.zipcode, _geocoderInfo?.city].join(' ');

    return <String>[address, town].join(', ');
  }

  LatLng? get location => _latLng ?? _geocoderInfo?.location();
}
