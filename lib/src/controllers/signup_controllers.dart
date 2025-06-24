import 'package:blogapp/src/views/screens/auth_screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignupControllers extends GetxController {
  static SignupControllers get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs; // Add loading state

  Future<void> registerUser(String email, String password, String name) async {
    try {
      isLoading.value = true; // Start loading

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar(
        "Success",
        "User Created Successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.only(bottom: 5.h),
      );

      await Future.delayed(Duration(seconds: 2));

      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? "An error occurred";
      this.email.clear();
      this.password.clear();
      this.name.clear();
      Get.snackbar(
        "Signup Failed",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.only(bottom: 5.h),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
