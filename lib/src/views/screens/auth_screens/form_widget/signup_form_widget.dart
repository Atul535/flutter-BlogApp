import 'package:blogapp/src/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SignupFormWidget extends StatelessWidget {
  const SignupFormWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(22.sp),
        // padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
        child: Column(
          children: [
            CustomTextfield(
              controller: nameController,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'Enter your full name',
              labelText: 'Full name',
              validationText: 'Full name is required',
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icons.person,
            ),
            SizedBox(
              height: 3.h,
            ),
            CustomTextfield(
              controller: emailController,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'Enter your email',
              labelText: 'Email',
              validationText: 'Email is required',
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icons.email,
            ),
            SizedBox(
              height: 3.h,
            ),
            CustomTextfield(
              controller: passwordController,
              isObscure: true,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'Enter your password',
              labelText: 'password',
              validationText: 'Password is required',
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icons.lock,
            ),
          ],
        ),
      ),
    );
  }
}
