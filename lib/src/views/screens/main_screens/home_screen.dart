import 'package:blogapp/core/utils/constants/image_strings.dart';
import 'package:blogapp/src/controllers/blog_controller.dart';
import 'package:blogapp/src/controllers/login_controllers.dart';
import 'package:blogapp/src/views/screens/main_screens/create_blog.dart';
import 'package:blogapp/src/views/screens/main_screens/main_screen_widgets/blog_list_widget.dart';
import 'package:blogapp/src/views/screens/main_screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final LoginControllers controllers = Get.put(LoginControllers());
  final BlogController blogController = Get.put(BlogController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 3, 47, 84),
          toolbarHeight: MediaQuery.of(context).size.width > 600 ? 10.h : 35.sp,
          leading: Padding(
            padding: EdgeInsets.only(left: 10.sp),
            child: Image.asset(
              ImageStrings.logo,
              height: 20.sp,
              width: 20.sp,
            ),
          ),
          title: Center(
            child: Text(
              'Blog App',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.sp),
              child: InkWell(
                onTap: () => Get.to(() => Profile()),
                child: Image.asset(
                  ImageStrings.profile,
                  height:
                      MediaQuery.of(context).size.width > 600 ? 22.sp : 27.sp,
                  width:
                      MediaQuery.of(context).size.width > 600 ? 22.sp : 27.sp,
                ),
              ),
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWeb = MediaQuery.of(context).size.width > 600;
            return Column(
              children: [
                Expanded(
                  child: BlogListWidget(blogController: blogController),
                ),
                Container(
                  height: isWeb ? 10.h : 8.h,
                  width: 100.w,
                  color: const Color.fromARGB(255, 3, 47, 84),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => CreateBlog());
                    },
                    child: Padding(
                      padding: EdgeInsets.all(isWeb ? 6.sp : 8.sp),
                      child: CircleAvatar(
                        radius: isWeb ? 8.sp : 15.sp,
                        child: Icon(
                          Icons.add_circle_outlined,
                          color: const Color.fromARGB(255, 3, 47, 84),
                          size: isWeb ? 24.sp : 32.sp,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
