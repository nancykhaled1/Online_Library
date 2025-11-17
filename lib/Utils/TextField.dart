import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'MyColors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isobscure;
  Widget? suffixIcon;
  void Function()? suffixIconFunction;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  TextInputType keyboardType;
  String? Function(String?) validator;
  bool isPassword;
  bool readonly;

   CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
     this.prefixIcon,
    this.isobscure = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.validator,
    this.isPassword = false,
     this.suffixIcon,
     this.suffixIconFunction,
     this.readonly = false,

   });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: MyColors.blackColor),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          readOnly: readonly,
          controller: controller,
          obscureText: isobscure,
          validator: validator,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: MyColors.greyColor),
            prefixIcon: Icon(prefixIcon, color: MyColors.blackColor),
            filled: true,
            fillColor: Colors.white,
            suffixIcon:
            suffixIcon != null
                ? InkWell(onTap: suffixIconFunction, child: suffixIcon)
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFA90714)), // لون الخطأ
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      ],
    );
  }
}
