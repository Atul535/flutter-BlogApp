import 'package:blogapp/src/controllers/image_picker_controller.dart';
import 'package:blogapp/src/controllers/login_controllers.dart';
import 'package:blogapp/src/views/screens/main_screens/main_screen_widgets/profile_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final LoginControllers controllers = Get.put(LoginControllers());
  final ImagePickerController imageControllers =
      Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 3, 47, 84),
          toolbarHeight: MediaQuery.of(context).size.width > 600 ? 10.h : 35.sp,
          leading: Padding(
              padding: EdgeInsets.only(left: 10.sp),
              child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ))),
          title: Center(
            child: Text(
              'User Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          final bool isWeb = MediaQuery.of(context).size.width > 600;
          return Center(
            child: Container(
              width: isWeb ? 400 : double.infinity,
              height: isWeb ? 80.h : null,
              padding: EdgeInsets.symmetric(
                horizontal: isWeb ? 40.0 : 16.0,
                vertical: isWeb ? 36.0 : 16.0,
              ),
              decoration: isWeb
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white))
                  : null,
              child: ProfileDataWidget(
                imageControllers: imageControllers,
                controllers: controllers,
              ),
            ),
          );
        }),
      ),
    );
  }
}
