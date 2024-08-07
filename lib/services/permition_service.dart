import 'package:permission_handler/permission_handler.dart';

class UserPermission {
  static Future<void> requestPermission() async {
    var status = await Permission.storage.status;
    var statusMenage = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    if (!statusMenage.isGranted) {
      await Permission.manageExternalStorage.request();
    }

    if (status.isGranted) {
      print("Storage permission granted");
      // Proceed with accessing storage
    } else {
      print("Storage permission denied");
      // Handle the denied permission
    }
  }
}
