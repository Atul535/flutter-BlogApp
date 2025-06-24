import 'dart:io';

import 'package:blogapp/src/controllers/image_picker_controller.dart';
import 'package:blogapp/src/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sizer/sizer.dart';

class CreateBlogWidget extends StatelessWidget {
  const CreateBlogWidget({
    super.key,
    required this.imageController,
    required this.titleController,
    required this.tagsController,
    required this.categoryController,
    required this.descriptionController,
  });

  final ImagePickerController imageController;
  final TextEditingController titleController;
  final TextEditingController tagsController;
  final TextEditingController categoryController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Padding(
            padding: MediaQuery.of(context).size.width > 600
                ? EdgeInsets.all(12.sp)
                : EdgeInsets.all(0.0),
            child: Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                InkWell(
                  onTap: () {
                    imageController.getImage();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height:
                        MediaQuery.of(context).size.width > 600 ? 25.h : 23.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(imageController.imagePath.value)),
                        opacity: 0.8,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15.sp),
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                    ),
                    child: Icon(
                      Icons.add_a_photo,
                      color: const Color.fromARGB(255, 3, 47, 84),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width > 600 ? 4.h : 3.h,
                ),
                CustomTextfield(
                  controller: titleController,
                  hintText: 'Title',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  prefixIcon: Icons.title_rounded,
                  isColored: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width > 600 ? 4.h : 3.h,
                ),
                CustomTextfield(
                  controller: tagsController,
                  hintText: 'Tags',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  prefixIcon: Icons.tag_sharp,
                  isColored: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width > 600 ? 4.h : 3.h,
                ),
                CustomTextfield(
                  controller: categoryController,
                  hintText: 'Category',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  prefixIcon: Icons.category_rounded,
                  isColored: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width > 600 ? 4.h : 3.h,
                ),
                CustomTextfield(
                  controller: descriptionController,
                  hintText: 'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon: Icons.description,
                  isColored: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
