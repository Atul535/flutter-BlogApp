import 'dart:io';

import 'package:blogapp/core/utils/constants/image_strings.dart';
import 'package:blogapp/src/controllers/image_picker_controller.dart';
import 'package:blogapp/src/controllers/login_controllers.dart';
import 'package:blogapp/src/views/widgets/custom_textfield.dart';
import 'package:blogapp/src/views/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sizer/sizer.dart';

class ProfileDataWidget extends StatelessWidget {
  const ProfileDataWidget({
    super.key,
    required this.imageControllers,
    required this.controllers,
  });

  final ImagePickerController imageControllers;
  final LoginControllers controllers;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWeb = MediaQuery.of(context).size.width > 600;
        return Obx(
          () => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: isWeb ? 5.w : 20.w,
                      backgroundImage: imageControllers
                              .imagePath1.value.isNotEmpty
                          ? isWeb
                              ? NetworkImage(imageControllers.imagePath1.value)
                              : FileImage(
                                  File(imageControllers.imagePath1.value))
                          : AssetImage(ImageStrings.profile),
                    ),
                    Positioned(
                      bottom: 0.h,
                      right: 1.w,
                      child: InkWell(
                        onTap: () {
                          imageControllers.getProfile();
                        },
                        child: Container(
                          height: isWeb ? 6.h : 5.h,
                          width: isWeb ? 3.w : 11.w,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 3, 47, 84),
                              borderRadius: BorderRadius.circular(40.sp)),
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                            size: isWeb ? 3.h : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomTextfield(
                  prefixIcon: Icons.email,
                  hintText: controllers.email.text,
                  hintStyle: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextfield(
                  prefixIcon: Icons.password,
                  hintText: controllers.password.text,
                  hintStyle: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  width: 40.w,
                  child: Obx(
                    () => Stack(
                      alignment: Alignment.center,
                      children: [
                        RoundButton(
                            title: "Logout",
                            onTap: () {
                              controllers.email.clear();
                              controllers.password.clear();
                              controllers.Logout();
                            }),
                        if (controllers.isLoading.value)
                          Positioned(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
