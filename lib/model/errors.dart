import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZGError {

  factory ZGError.from(String? identifier) {
    switch (identifier) {
      case ZGError.unauthorizedError: return UnauthorizedError();
      case ZGError.connectionError: return ConnectionError();
      case ZGError.cameraDeniedError: return CameraDeniedError();
      default: return CommonError();
    }
  }

  ZGError._(this.title, this.message, this.icon, this.identifier);
  static const String unauthorizedError = 'unauthorized';
  static const String connectionError = 'connectionError';
  static const String commonError = 'commonError';
  static const String cameraDeniedError = 'cameraDeniedError';

  final String title;
  final String message;
  final IconData icon;
  final String identifier;
}

class UnauthorizedError extends ZGError {
  UnauthorizedError() : super._('error'.tr, 'session_expired'.tr, Icons.wifi_off, ZGError.unauthorizedError);
}

class ConnectionError extends ZGError {
  ConnectionError() : super._('error'.tr, 'no_internet_connection'.tr, Icons.wifi_off, ZGError.connectionError);
}

class CommonError extends ZGError {
  CommonError() : super._('error'.tr, 'something_went_wrong'.tr, Icons.warning, ZGError.commonError);
}

class CameraDeniedError extends ZGError {
  CameraDeniedError() : super._('error'.tr, 'camera_denied'.tr, Icons.camera_alt, ZGError.commonError);
}
