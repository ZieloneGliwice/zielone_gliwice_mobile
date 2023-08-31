
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/collections.dart';

class NewTree {

    NewTree(
        {
          this.tree,
          this.leaf,
          this.bark,
          this.species,
          this.description,
          this.perimeter,
          this.state,
          this.stateDescription,
          this.latLon,
          this.badState
        });

  factory NewTree.fromJson(Map<String, dynamic> json) {
    final String? location = json['lat-long'] as String?;
    final List<String>? locationElements = location?.split(',');
    final double? lat = double.tryParse(locationElements?.get(0) ?? '')  ;
    final double? lon = double.tryParse(locationElements?.get(1) ?? '');
    LatLng? treeLocation;

    if (lat != null && lon != null) {
      treeLocation = LatLng(lat, lon);
    }

    return NewTree(
      tree: json['tree'] as String?,
      leaf: json['leaf'] as String?,
      bark: json['bark'] as String?,
      species: json['species'] as String?,
      description: json['description'] as String?,
      perimeter: json['perimeter'] as int?,
      state: json['state'] as String?,
      stateDescription: json['state-description'] as String?,
      latLon: treeLocation,
      badState: json['bad-state'] as String?
    );
  }

    String? tree;
    String? leaf;
    String? bark;
    String? species;
    String? description;
    int? perimeter;
    String? state;
    String? stateDescription;
    LatLng? latLon;
    String? badState;
    int? timestamp;

    Future<FormData> toFormData() async {

      final String location = '${latLon?.latitude ?? -500},${latLon?.longitude ?? -500}';

      final FormData formData = FormData.fromMap(<String, dynamic>{
        'species': species,
        'description': description,
        'perimeter': perimeter,
        'state': state,
        if (stateDescription != null) 'state-description': stateDescription,
        'lat-long': location,
        if (badState != null) 'bad-state': badState,
      });

      final MultipartFile? treeFile = await multipartFile(tree, 'tree');

      if (treeFile != null) {
        formData.files.add(MapEntry('tree', treeFile));
      }

      final MultipartFile? leafFile = await multipartFile(leaf, 'leaf');

      if (leafFile != null) {
        formData.files.add(MapEntry('leaf', leafFile));
      }

      final MultipartFile? barkFile = await multipartFile(bark, 'bark');

      if (barkFile != null) {
        formData.files.add(MapEntry('bark', barkFile));
      }

      return formData;
    }

    Future<MultipartFile?> multipartFile(String? filePath, String name) async {
      if (filePath != null && filePath.isNotEmpty) {
        final File file = File(filePath);
        return MultipartFile.fromBytes(file.readAsBytesSync(), filename: name);
      } else {
        return null;
      }
    }
}
