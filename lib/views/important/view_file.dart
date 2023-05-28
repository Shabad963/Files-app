import 'dart:io';
import 'package:firebase_sample/controller/important_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';




class FileViewerWidget extends StatefulWidget {

       const FileViewerWidget({super.key});
  @override
  State<FileViewerWidget> createState() => _FileViewerWidgetState();
}

class _FileViewerWidgetState extends State<FileViewerWidget> {


  ImportantController controller= Get.find();

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    controller.preferences = await SharedPreferences.getInstance();
    setState(() {
      controller.filePath = controller.preferences!.getString(controller.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Viewer'),
      ),
      body: Center(
        child: controller.filePath != null
            ? controller.buildFileWidget()
            : Text('No file path saved.'),
      ),
    );
  }

}