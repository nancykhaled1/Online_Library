import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAvatar extends StatelessWidget {
  final String? backendImageUrl; // الصورة من الباك
  final String? googleImageUrl;  // صورة جوجل
  final double radius;

  const ProfileAvatar({
    Key? key,
    this.backendImageUrl,
    this.googleImageUrl,
    this.radius = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تحديد الصورة النهائية
    String? finalImageUrl = backendImageUrl ?? googleImageUrl;

    return CircleAvatar(
      radius: radius.r,
      backgroundColor: Colors.white,
      child: ClipOval(
        child: (finalImageUrl != null && finalImageUrl.startsWith("http"))
            ? Image.network(
          finalImageUrl,
          key: UniqueKey(),
          fit: BoxFit.cover,
          width: 100.w,
          height: 100.h,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          errorBuilder: (context, error, stackTrace) =>
              Image.asset(
                'assets/images/personalImage.png',
                fit: BoxFit.cover,
                width: 100.w,
                height: 100.h,
              ),
        )
            : Image.asset(
          'assets/images/personalImage.png',
          fit: BoxFit.cover,
          width: 100.w,
          height: 100.h,
        ),
      ),
    );
  }
}
