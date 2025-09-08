import 'package:flutter/material.dart';
import 'package:runtime_permission/permission.dart';
class CameraPage extends StatelessWidget {
  const CameraPage({super.key});
  Future<void> _openCamera(BuildContext context) async {
    bool granted = await PermissionUtils.requestCameraPermission(context);
    if (granted) {
      // ✅ Open camera directly
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Opening Camera...")),
      );
      // TODO: Add your camera picker code here
    }
  }
  Future<void> _openGallery(BuildContext context) async {
    bool granted = await PermissionUtils.requestGalleryPermission(context);
    if (granted) {
      // ✅ Open gallery directly
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Opening Gallery...")),
      );
      // TODO: Add your image picker code here
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Camera & Gallery Permission")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Open Camera"),
              onPressed: () => _openCamera(context),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Open Gallery"),
              onPressed: () => _openGallery(context),
            ),
            Text("Runtime Permission")
          ],
        ),
      ),
    );
  }
}
