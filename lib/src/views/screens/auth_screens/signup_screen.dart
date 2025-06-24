import 'package:blogapp/core/utils/constants/image_strings.dart';
import 'package:blogapp/core/utils/constants/text_strings.dart';
import 'package:blogapp/src/controllers/signup_controllers.dart';
import 'package:blogapp/src/views/screens/auth_screens/form_widget/signup_form_widget.dart';
import 'package:blogapp/src/views/screens/auth_screens/login_screen.dart';
import 'package:blogapp/src/views/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sizer/sizer.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final SignupControllers controllers = Get.put(SignupControllers());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWeb = constraints.maxWidth > 600;
          return Center(
            child: Container(
              width: isWeb ? 500 : double.infinity,
              decoration: isWeb
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white))
                  : null,
              padding: EdgeInsets.symmetric(
                horizontal: isWeb ? 32.0 : 16.0,
                vertical: isWeb ? 32.0 : 16.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: isWeb ? 25.h : 30.h,
                      child: Image.asset(ImageStrings.signupImg),
                    ),
                    SignupFormWidget(
                      formKey: _formKey,
                      emailController: controllers.email,
                      passwordController: controllers.password,
                      nameController: controllers.name,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(() => Stack(
                          alignment: Alignment.center,
                          children: [
                            RoundButton(
                              title: TextStrings.title2,
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  controllers.registerUser(
                                    controllers.email.text.trim(),
                                    controllers.password.text.trim(),
                                    controllers.name.text.trim(),
                                  );
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
                        )),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            TextStrings.register2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 3, 35, 62),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Get.to(() => LoginScreen()),
                            child: Text(
                              TextStrings.title1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
