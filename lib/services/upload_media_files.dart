import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<List<String>> uploadFiles(List<PlatformFile> files) async {
  List<String> downloadUrls = [];

  for (PlatformFile file in files) {
    File fileToUpload = File(file.path!);
    String fileName = file.name;

    try {
      Reference storageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = storageRef.putFile(fileToUpload);
      TaskSnapshot taskSnapshot = await uploadTask;

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    } catch (e) {
      print('Error uploading file: $fileName - $e');
    }
  }

  return downloadUrls;
}
