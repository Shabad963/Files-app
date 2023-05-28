// import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/config/size.dart';
import 'package:firebase_sample/config/colors.dart';

import 'package:firebase_sample/controller/file_pick_controller.dart';
import 'package:firebase_sample/controller/important_controller.dart';
import 'package:firebase_sample/utils/common.dart';
import 'package:firebase_sample/views/important/file_picker.dart';
import 'package:firebase_sample/views/important/view_pdf.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ImportantFiles extends StatelessWidget {
   ImportantFiles({
    super.key,
  });

  ImportantController controller = Get.find();

      String userName = FirebaseAuth.instance.currentUser!.email!;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TextContent4_CL,
      appBar: appBarWidget(title: "Important Files"),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FolderWidget(
                title: 'Aadhar Card',
                action: () {
                  controller.name = '$userName aadhar';
                  Get.to(() => FilePickerWidget(title: 'Aadhar Card',));
                },
              ),
              SizedBox(height: 3.0.hp),
              FolderWidget(
                title: 'Driving license',
                action: () {
                  controller.name = '$userName license';
                  Get.to(() => FilePickerWidget(title: 'Driving license',));
                },
              ),
              SizedBox(height: 3.0.hp),
              FolderWidget(
                title: 'Pan card',
                action: () {
                  controller.name = '$userName pan';
                  Get.to(() => FilePickerWidget(title: 'Pan card',));
                },
              ),
            ]),
      ),
    );
  }
}