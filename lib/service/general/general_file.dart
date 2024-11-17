import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class GeneralFile {
  static Future<void> requestStorageToExcel(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
    }
  }
}
