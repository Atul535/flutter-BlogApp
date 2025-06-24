import 'package:blogapp/core/utils/constants/image_strings.dart';
import 'package:blogapp/core/utils/constants/text_strings.dart';
import 'package:blogapp/src/controllers/login_controllers.dart';
import 'package:blogapp/src/views/screens/auth_screens/form_widget/login_form_widget.dart';
import 'package:blogapp/src/views/screens/auth_screens/signup_screen.dart';
import 'package:blogapp/src/views/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginControllers controllers = Get.put(LoginControllers());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        final bool isWeb = constraints.maxWidth > 600;
        return Center(
          child: Container(
            width: isWeb ? 500 : double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: isWeb ? 32.0 : 16.0,
              vertical: isWeb ? 32.0 : 16.0,
            ),
            decoration: isWeb
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white))
                : null,
            child: Obx(
              () => SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: isWeb ? 25.h : 30.h,
                      child: Image.asset(ImageStrings.loginImg),
                    ),
                    LoginFormWidget(
                      formKey: _formKey,
                      emailController: controllers.email,
                      passwordController: controllers.password,
                    ),
                    SizedBox(
                      height: isWeb ? 1.h : 2.h,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        RoundButton(
                          title: TextStrings.title1,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await controllers.LoginUser(
                                  controllers.email.text.trim(),
                                  controllers.password.text.trim());
                              controllers.saveData();
                            } else {
                              controllers.email.clear();
                              controllers.password.clear();
                            }
                          },
                        ),
                        if (controllers.isLoading.value)
                          Positioned(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: isWeb ? 1.h : 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            TextStrings.register1,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 3, 35, 62),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Get.off(() => SignupScreen()),
                            child: Text(
                              TextStrings.registration,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.sp),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                controllers.signInWithGoogle();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 3, 47, 84),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.sp))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageStrings.googleLogo,
                                    height: isWeb ? 18.sp : 23.sp,
                                    width: isWeb ? 18.sp : 23.sp,
                                  ),
                                  SizedBox(
                                    width: 15.sp,
                                  ),
                                  Text(
                                    TextStrings.google,
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                          if (controllers.isGoogleLoading.value)
                            Positioned(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
