import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? color;
  const RoundButton({
    super.key,
    this.color = const Color.fromARGB(255, 3, 47, 84),
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600;
    return InkWell(
      onTap: onTap,
      mouseCursor: MouseCursor.defer,
      child: Container(
        height: 7.h,
        // width: isWeb ? 50.w : 84.w,
        width: isWeb
            ? MediaQuery.of(context).size.width * 0.28
            : MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.sp),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
