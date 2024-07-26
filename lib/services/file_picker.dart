import 'package:file_picker/file_picker.dart';

Future<List<PlatformFile>?> pickFiles() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png', "jpeg", 'mp4'],
    allowMultiple: true,
  );

  if (result != null) {
    return result.files;
  } else {
    return null;
  }
}

Future<PlatformFile?> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png', "jpeg", 'mp4'],
    allowMultiple: false,
  );

  if (result != null) {
    return result.files.first;
  } else {
    return null;
  }
}
