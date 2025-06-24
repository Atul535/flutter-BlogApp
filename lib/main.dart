import 'package:blogapp/firebase_options.dart';
import 'package:blogapp/src/controllers/login_controllers.dart';
import 'package:blogapp/src/views/screens/auth_screens/login_screen.dart';
import 'package:blogapp/src/views/screens/main_screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final LoginControllers controllers = Get.put(LoginControllers());
  bool loginCheck = await controllers.checkLogin();
  runApp(MyApp(isLoggedIn: loginCheck));
}

class MyApp extends StatelessWidget {
  final bool? isLoggedIn;
  const MyApp({super.key, this.isLoggedIn});

  // final _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 26, 108, 149),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: (isLoggedIn ?? false) ? HomeScreen() : LoginScreen(),
      );
    });
  }
}
