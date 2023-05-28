import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/config/size.dart';
import 'package:firebase_sample/controller/file_pick_controller.dart';
import 'package:firebase_sample/controller/other_controller.dart';
import 'package:firebase_sample/utils/common.dart';
import 'package:firebase_sample/views/important/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class OtherFilesController extends GetxController {
  TextEditingController folderNameController = TextEditingController();

  List<FileSystemEntity> folderContents = [];
  String userName = FirebaseAuth.instance.currentUser!.email!;

  @override
  void onInit() {
    log(userName);
    super.onInit();
   
    loadFolderContents();
  }

  Future<void> loadFolderContents() async {
   await createOtherFolder();
    log("hhhhhhhhhhhhhh");
    final directory = await getApplicationDocumentsDirectory();
    final folderPath =
        '${directory.path}/$userName'; // Replace 'my_folder' with your folder name

    folderContents = Directory(folderPath).listSync();
    Get.forceAppUpdate();
  }

  Future<void> createNewFolder() async {
    log("ssssssss");

    final directory = await getApplicationDocumentsDirectory();
    final folderPath =
        '${directory.path}/$userName'; // Replace 'my_folder' with your folder name
    final newFolderName =
        folderNameController.text; // Replace 'NewFolder' with the desired name

    final newFolderPath = '$folderPath/$newFolderName';
    final newFolder = await Directory(newFolderPath).create();

    log("ttttttttttttttttt");

    folderContents = Directory(folderPath).listSync();

    log("dddddddddddddd");
        Get.forceAppUpdate();

  }

  Future<void> createOtherFolder() async {
    log("ssssssss");

    final directory = await getApplicationDocumentsDirectory();
    final folderPath =
        '${directory.path}'; // Replace 'my_folder' with your folder name
    final newFolderName =
        "$userName"; // Replace 'NewFolder' with the desired name

    final newFolderPath = '$folderPath/$newFolderName';
    final newFolder = await Directory(newFolderPath).create();
        Get.forceAppUpdate();

  }

  
  Future<void> deleteFolder(String path) async {
    log("ssssssss");
 Directory folder = Directory(path);
  if (await folder.exists()) {
    // Delete the folder and its contents recursively.
    await folder.delete(recursive: true);
    print('Folder deleted successfully.');
  } else {
    print('Folder does not exist.');
  }

    log("ttttttttttttttttt");
    final directory = await getApplicationDocumentsDirectory();
    final folderPath =
        '${directory.path}/$userName'; // 

    folderContents = Directory(folderPath).listSync();

    log("dddddddddddddd");
        Get.forceAppUpdate();

  }

}
