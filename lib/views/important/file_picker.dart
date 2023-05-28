import 'dart:io';
import 'package:firebase_sample/controller/file_pick_controller.dart';
import 'package:firebase_sample/controller/important_controller.dart';
import 'package:firebase_sample/utils/common.dart';
import 'package:firebase_sample/views/important/view_file.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FilePickerWidget extends StatelessWidget {
  final String title;
   FilePickerWidget({super.key, required this.title});

  ImportantController controller = Get.put(ImportantController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => controller.pickImage(),
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: () => controller.pickPdf(),
              child: Text('Pick PDF'),
            ),
            if (controller.pickedFile != null)
              controller.pickedFileType == FileType.image
                  ? Column(
                      children: [
                        SizedBox(
                          height : 350,
                          
                          child: Image.file(controller.pickedFile!)),
                        ElevatedButton(
                          onPressed: () {
                            controller.saveFilePath(controller.pickedFile!.path);
                              Get.to(() => FileViewerWidget());
                             Fluttertoast.showToast(msg: "Saved");

                          },
                          child: Text('Save'),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                           height : 350,
                          child: SfPdfViewer.file(
                            File(controller.pickedFile!.path),
                            initialZoomLevel: 1.0,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async{
                           await controller.saveFilePath(controller.pickedFile!.path);
                             Get.to(() => FileViewerWidget());
                             Fluttertoast.showToast(msg: "Saved");
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
           ElevatedButton(
              onPressed: () {
                Get.to(() => FileViewerWidget());
              },
              child: Text('View File'),
            ),
          ],
        ),
      ),
    );
  }
}
