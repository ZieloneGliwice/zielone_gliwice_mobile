import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PhotosService {
  final String _photoFormat = '.png';
  final String _directory = 'photos';

  Future<String> storePhotoFile(XFile? xFile, String fileName) async {
    final Uint8List? bytes = await xFile?.readAsBytes();

    final String photosDirectory = await _photosDirectory();

    final String imagePath = '$photosDirectory$fileName$_photoFormat';
    final File imgFile = await File(imagePath).create(recursive: true);
    final File savedFile = await imgFile.writeAsBytes(bytes!, flush: true);
    return savedFile.path;
  }

  Future<String> storePhoto(String fileName, Image? image) async {
    final ByteData? data =
    await image?.toByteData(format: ImageByteFormat.png);
    final Uint8List? bytes = data?.buffer.asUint8List();

    final String photosDirectory = await _photosDirectory();

    final String imagePath = '$photosDirectory$fileName$_photoFormat';
    final File imgFile = await File(imagePath).create(recursive: true);
    final File savedFile = await imgFile.writeAsBytes(bytes!, flush: true);
    return savedFile.path;
  }

  Future<void> clearCachedPhotos() async {
    final String photosDirectoryPath = await _photosDirectory();
    final Directory photosDirectory = Directory(photosDirectoryPath);

    if (photosDirectory.existsSync()) {
      await photosDirectory.delete(recursive: true);
    }
  }

  Future<String> _photosDirectory() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    return '${appDocumentsDir.path}/$_directory/';
  }
}
