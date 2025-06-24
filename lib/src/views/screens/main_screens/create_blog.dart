import 'package:blogapp/src/controllers/blog_controller.dart';
import 'package:blogapp/src/controllers/image_picker_controller.dart';
import 'package:blogapp/src/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'main_screen_widgets/create_blog_widget.dart';

class CreateBlog extends StatelessWidget {
  CreateBlog({super.key});

  final ImagePickerController imageController =
      Get.put(ImagePickerController());
  final BlogController blogController = Get.find();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 3, 47, 84),
          toolbarHeight: MediaQuery.of(context).size.width > 600 ? 10.h : 35.sp,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: Center(
            child: Text(
              "Blog App",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
                padding: MediaQuery.of(context).size.width > 600
                    ? EdgeInsets.only(right: 15.sp)
                    : null,
                onPressed: () async {
                  BlogModel newBlog = BlogModel(
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                    category: categoryController.text.trim(),
                    tags: tagsController.text.trim(),
                    imageUrl: imageController.imagePath.value,
                  );
                  await blogController.addBlog(newBlog);
                  blogController.fetchFromFirestore();
                  Get.back();
                },
                icon: Icon(
                  Icons.upload,
                  color: Colors.white,
                ))
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWeb = MediaQuery.of(context).size.width > 600;
            return isWeb
                ? Center(
                    child: Container(
                      width: isWeb ? 35.w : null,
                      height: isWeb ? 85.h : null,
                      decoration: isWeb
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.white))
                          : null,
                      child: CreateBlogWidget(
                        imageController: imageController,
                        titleController: titleController,
                        tagsController: tagsController,
                        categoryController: categoryController,
                        descriptionController: descriptionController,
                      ),
                    ),
                  )
                : CreateBlogWidget(
                    imageController: imageController,
                    titleController: titleController,
                    tagsController: tagsController,
                    categoryController: categoryController,
                    descriptionController: descriptionController,
                  );
          },
        ),
      ),
    );
  }
}
