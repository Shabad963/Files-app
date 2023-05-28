import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/config/size.dart';
import 'package:firebase_sample/controller/file_pick_controller.dart';
import 'package:firebase_sample/controller/important_controller.dart';
import 'package:firebase_sample/controller/other_controller.dart';
import 'package:firebase_sample/utils/common.dart';
import 'package:firebase_sample/views/important/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class OtherFiles extends StatefulWidget {
  @override
  _OtherFilesState createState() => _OtherFilesState();
}

class _OtherFilesState extends State<OtherFiles> {
  OtherFilesController controller = Get.find();
  ImportantController importantController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: 'Other files'),
        body: Column(
          children: [
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: importantController.editingController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                    labelStyle: TextStyle(color: Color(0xFF424242))),
              ),
            ),
            Expanded(
              child: ListView.separated(
                  itemCount: controller.folderContents.length,
                  itemBuilder: (context, index) {
                    final item = controller.folderContents[index];
            
                    if (importantController.editingController.text.isEmpty) {
                      return FolderWidget(
                        title:
                            item.path.substring(54 + controller.userName.length),
                        action: () {
                          importantController.name =
                              '${controller.userName + item.path.substring(54 + controller.userName.length)}';
                          Get.to(() => FilePickerWidget(
                                title: item.path
                                    .substring(54 + controller.userName.length),
                              ));
                        },
                        isMain: false,
                        delete: () => controller.deleteFolder(item.path),
                      );
                    } else if (item.path
                            .substring(54 + controller.userName.length)!
                            .toLowerCase()
                            .contains(
                                importantController.editingController.text) ||
                        item.path
                            .substring(54 + controller.userName.length)!
                            .toLowerCase()
                            .contains(
                                importantController.editingController.text)) {
                      return FolderWidget(
                        title:
                            item.path.substring(54 + controller.userName.length),
                        action: () {
                          importantController.name =
                              '${controller.userName + item.path.substring(54 + controller.userName.length)}';
                          Get.to(() => FilePickerWidget(
                                title: item.path
                                    .substring(54 + controller.userName.length),
                              ));
                        },
                      );
                    } else {
                      return Container(child: Text("No files"));
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 3.0.hp);
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Enter folder name'),
                  content: TextField(
                    controller: controller.folderNameController,
                    decoration: InputDecoration(hintText: 'name'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        String enteredText =
                            controller.folderNameController.text;
                        // Do something with the entered text
                        print('Entered text: $enteredText');
                        controller.createNewFolder();
                        Navigator.of(context).pop();
                        controller.folderNameController.clear();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ));
  }
}
