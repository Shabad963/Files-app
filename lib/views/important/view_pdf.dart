
// import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:firebase_sample/config/size.dart';
import 'package:firebase_sample/config/colors.dart';

import 'package:firebase_sample/controller/file_pick_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPdf extends StatelessWidget {

   ViewPdf({super.key});

  FilePickController controller = Get.find();

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
                height: 500,
                width: 250,
                child: SfPdfViewer.file(
                     File(controller.aadharfilepath.value), initialZoomLevel: 1.0,),
              )
         
        ],
      ),
    ));
  }
}