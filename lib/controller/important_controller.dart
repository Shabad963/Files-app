import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ImportantController extends GetxController {
  SharedPreferences? preferences;
  File? pickedFile;
  FileType pickedFileType = FileType.custom;
  String? filePath;

  String name = "";
    TextEditingController editingController = TextEditingController();



  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      pickedFile = File(pickedImage.path);
      pickedFileType = FileType.image;

      Get.forceAppUpdate();
    }
  }

  Future<void> pickPdf() async {
    final pickedPdf = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pickedPdf != null) {
      pickedFile = File(pickedPdf.files.single.path!);
      pickedFileType = FileType.custom;

      Get.forceAppUpdate();
    }
  }

  Future<void> saveFilePath(String path) async {
    if (preferences != null) {
      await preferences!.setString(name, path);
    }
  }

  Widget buildFileWidget() {
    if (filePath!.endsWith('.pdf')) {
      return Container(
        height: 500,
        width: 250,
        child: SfPdfViewer.file(
          File(filePath!),
          initialZoomLevel: 1.0,
        ),
      );
    } else {
      return Image.file(
        File(filePath!),
        fit: BoxFit.contain,
      );
    }
  }
}
