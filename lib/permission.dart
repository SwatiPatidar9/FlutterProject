import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
class PermissionUtils {
  /// ✅ Request Camera Permission
  static Future<bool> requestCameraPermission(BuildContext context) async {
    PermissionStatus status = await Permission.camera.status;
    if (status.isGranted) {
      // Already granted
      return true;
    }
    if (status.isDenied) {
      // Ask the user with system dialog
      PermissionStatus newStatus = await Permission.camera.request();
      return newStatus.isGranted;
    }
    if (status.isPermanentlyDenied) {
      // Show dialog to open settings
      _showSettingsDialog(context, "Camera");
      return false;
    }
    return false;
  }
  /// ✅ Request Gallery (Photos/Storage) Permission
  static Future<bool> requestGalleryPermission(BuildContext context) async {
    Permission permission = Permission.photos; // iOS
    if (Theme.of(context).platform == TargetPlatform.android) {
      permission = Permission.storage; // Android
    }
    PermissionStatus status = await permission.status;
    if (status.isGranted) {
      return true;
    }
    if (status.isDenied) {
      PermissionStatus newStatus = await permission.request();
      return newStatus.isGranted;
    }
    if (status.isPermanentlyDenied) {
      _showSettingsDialog(context, "Gallery/Photos");
      return false;
    }
    return false;
  }
  /// ✅ Show dialog when permission permanently denied
  static Future<void> _showSettingsDialog(BuildContext context, String type) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("$type Permission Required"),
        content: Text("Please enable $type permission in settings to continue."),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text("Open Settings"),
            onPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
