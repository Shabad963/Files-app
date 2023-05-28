
import 'package:firebase_sample/config/size.dart';
import 'package:firebase_sample/controller/important_controller.dart';
import 'package:firebase_sample/views/important/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';




  AppBar appBarWidget({required String title}) {
    return AppBar(
      leading: IconButton(
          icon:
              Icon(Icons.arrow_back_ios, size: 12.0.sp, color: Colors.black),
          onPressed: () {
            Get.back();
          }),
      backgroundColor: Colors.white,
      toolbarHeight: 7.0.hp,
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 10.5.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      elevation: 3.0,
    );
  }



class FolderWidget extends StatelessWidget {
  const FolderWidget({
    super.key,
    required this.title,
     required this.action, this.isMain = true, this.delete,
  });

  final String title;
  final VoidCallback action;
    final VoidCallback? delete;

  final bool? isMain;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: SizedBox(
        height: 12.0.hp,
        child: Material(
          elevation: 1.5,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 227, 255, 255),
              borderRadius: BorderRadius.circular(8)),
            child: Expanded(
              child: Row(
                children: [
                  Text(title),
                isMain == false ?  IconButton(onPressed: delete!, icon: Icon(Icons.delete)): SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
