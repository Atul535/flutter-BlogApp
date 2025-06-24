import 'dart:io';

import 'package:blogapp/src/controllers/blog_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sizer/sizer.dart';

class BlogListWidget extends StatelessWidget {
  BlogListWidget({
    super.key,
    required this.blogController,
  });

  final BlogController blogController;
  final firestore = FirebaseFirestore.instance.collection("Blogs").snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error : ${snapshot.error}"),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No blogs found!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
          );
        }
        return LayoutBuilder(builder: (context, constraints) {
          final bool isWeb = MediaQuery.of(context).size.width > 600;
          return Obx(
            () => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isWeb ? 2 : 1,
                mainAxisSpacing: 2.h,
                childAspectRatio: isWeb ? 2.5 : 2,
              ),
              itemCount: blogController.blogs.length,
              itemBuilder: (context, index) {
                final blog = blogController.blogs[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: isWeb ? 5.w : 5.w, vertical: 1.h),
                  child: Container(
                    height: isWeb
                        ? MediaQuery.of(context).size.height * 0.4
                        : MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: isWeb
                            ? NetworkImage(blog.imageUrl)
                            : FileImage(File(blog.imageUrl)),
                        opacity: 0.8,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15.sp),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isWeb ? 5.w : 10.w, vertical: 5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title: ${blog.title}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 17.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Tags: ${blog.tags}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Category: ${blog.category}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Description: ${blog.description}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
      },
    );
  }
}
