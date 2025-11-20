import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildImage(String? url) {
  if (url == null || url.isEmpty || !url.startsWith("http")) {
    return Image.asset(
      "assets/images/book.png",
     // fit: BoxFit.cover,
      height: 200.h,
    );
  }

  return Stack(
    children: [
      const Center(
        child: CircularProgressIndicator(),
      ),
      Positioned.fill(
        child: FadeInImage(
          placeholder: AssetImage("assets/images/book.png"), // صورة شفافة
          height: 180.h,
          image: NetworkImage(url),
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset("assets/images/book.png", height: 180.h,);

          },
        ),
      ),
    ],
  );
}
