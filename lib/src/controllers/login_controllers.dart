import 'package:blogapp/src/views/screens/auth_screens/login_screen.dart';
import 'package:blogapp/src/views/screens/main_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginControllers extends GetxController {
  static LoginControllers get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;
  var isGoogleLoading = false.obs;

  Future<void> LoginUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await Future.delayed(Duration(seconds: 2));
      Get.offAll(() => HomeScreen());
      Get.snackbar(
        "Success",
        "Logged In Successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.only(bottom: 5.h),
      );
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? "An error occurred";
      Get.snackbar(
        "Login Failed",
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

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      isGoogleLoading.value = true;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // User canceled the sign-in

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final pref = await SharedPreferences.getInstance();
      await pref.setString('google', credential.idToken!);
      await pref.setBool('isLoggedIn', true);

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      Future.delayed(Duration(seconds: 2));

      Get.offAll(() => HomeScreen());

      Get.snackbar(
        "Success",
        "Logged In Successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.only(bottom: 5.h),
      );

      return userCredential;
    } catch (e) {
      // Handle errors
      print('Error signing in with Google: $e');
      Get.snackbar(
        "Login Failed",
        "An error occurred while signing in with Google.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.only(bottom: 5.h),
      );
      return null;
    } finally {
      isGoogleLoading.value = false;
    }
  }

  Future<void> Logout() async {
    try {
      isLoading.value = true;
      await _auth.signOut();
      await GoogleSignIn().signOut();
      final pref = await SharedPreferences.getInstance();
      await pref.setBool('isLoggedIn', false);
      await Future.delayed(Duration(seconds: 1));

      Get.offAll(() => LoginScreen());

      Get.snackbar(
        "Logout Successful", // Title
        "You have been logged out successfully.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(10),
        borderRadius: 8,
        icon: Icon(Icons.check_circle, color: Colors.white),
      );
    } catch (e) {
      print("Logout Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveData() async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString("email", email.text.trim());
    await pref.setString("password", password.text.trim());
    await pref.setBool('isLoggedIn', true);

    bool isLoggedIn = pref.getBool("isLoggedIn") ?? false;
    print("Is Logged In: $isLoggedIn");
  }

  @override
  void onInit() {
    super.onInit();
    loadingData();
  }

  Future<void> loadingData() async {
    var pref = await SharedPreferences.getInstance();
    String savedEmail = (pref.getString("email") ?? "");
    String savedPassword = (pref.getString("password") ?? "");

    email.text = savedEmail;
    password.text = savedPassword;

    print("Saved Email: $savedEmail");
    print("Saved Password: $savedPassword");
  }

  Future<bool> checkLogin() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool('isLoggedIn') ?? false;
  }
}
