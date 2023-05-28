import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class FilePickController extends GetxController {



  SharedPreferences? preferences;

  PlatformFile? aadharfilePick;
  PlatformFile? drivingfilePick;
  PlatformFile? panfilePick;
  RxString aadharfilename = ''.obs;
  RxString drivingfilename = ''.obs;
  RxString panfilename = ''.obs;
  RxString aadharfilepath = ''.obs;
  RxString drivingfilepath = ''.obs;
  RxString panfilepath = ''.obs;


@override
  void onInit() {

   initSharedPreferences(); 
    super.onInit();

  }



 Future<void> initSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    
      aadharfilepath.value = preferences!.getString("aadharfilename")!;
   
  }


  aadharfilepicker() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
       allowedExtensions: ['pdf'],

    );

    if (result == null) return;

    aadharfilePick = result.files.first;
    aadharfilename.value = aadharfilePick!.name.toString();
    aadharfilepath.value = aadharfilePick!.path.toString();

    print("name: ${aadharfilePick!.name}");
    print("bytes: ${aadharfilePick!.size}");
    print('path: ${aadharfilePick!.path}');
    print('path: ${aadharfilepath.value}');
    final newFile = await saveFile(aadharfilePick!);
    print(" From name: ${aadharfilePick!.path}");
    print(" To name: ${newFile.path}");
    if (preferences != null) {
      await preferences!.setString("aadharfilename", newFile.path);
    }
  }

  panfilepicker() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return;

    panfilePick = result.files.first;
    panfilename.value = panfilePick!.name.toString();
    panfilepath.value = panfilePick!.path.toString();

    print("name: ${panfilePick!.name}");
    print("bytes: ${panfilePick!.size}");
    print('path: ${panfilePick!.path}');
    final newFile = await saveFile(panfilePick!);
    print(" From name: ${panfilePick!.path}");
    print(" To name: ${newFile.path}");
  }


  drivingfilepicker() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return;
    // if (drivingfilePick!.extension != "pdf") {}
    drivingfilePick = result.files.first;
    drivingfilename.value = drivingfilePick!.name.toString();
    drivingfilepath.value = drivingfilePick!.path.toString();

    print("name: ${drivingfilePick!.name}");
    print("bytes: ${drivingfilePick!.size}");
    print('path: ${drivingfilePick!.path}');
    final newFile = await saveFile(drivingfilePick!);
    print(" From name: ${drivingfilePick!.path}");
    print(" To name: ${newFile.path}");
  }


  Future<File> saveFile(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    return File(file.path!).copy(newFile.path);
  }


 toster(title) {
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }


}
