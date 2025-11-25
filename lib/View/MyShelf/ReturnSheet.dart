import 'dart:async';
import 'package:flutter/material.dart';
import '../../Models/Responses/ReturnResponse.dart';
import '../../Utils/MyColors.dart';

void returnedSheet(BuildContext context, ReturnData data) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: MyColors.whiteColor,
    enableDrag: false,
    isDismissible: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return _ReturnSheetContent(data: data);
    },
  );
}

class _ReturnSheetContent extends StatefulWidget {
  final ReturnData data;
  const _ReturnSheetContent({required this.data});

  @override
  _ReturnSheetContentState createState() => _ReturnSheetContentState();
}

class _ReturnSheetContentState extends State<_ReturnSheetContent> {
  int totalSeconds = 3 * 60 * 60; // 3 ساعات
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (totalSeconds == 0) {
        t.cancel();
        Navigator.pop(context);
      } else {
        setState(() {
          totalSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    int h = seconds ~/ 3600;
    int m = (seconds % 3600) ~/ 60;
    int s = seconds % 60;
    return "${h.toString().padLeft(2, '0')} : ${m.toString().padLeft(2, '0')} : ${s.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 20),

          // QR container
          Container(
            padding: EdgeInsets.all(14),
            width: double.infinity,
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: MyColors.primaryColor),
            ),
            child: Image.network(widget.data.qrCodeReturn!, height: 200),
          ),

          SizedBox(height: 20),

          // info + timer
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: MyColors.dividerColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline),
                SizedBox(width: 10),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Please show this QR to the librarian to continue borrowing this book.",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Text(
                        formatTime(totalSeconds),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: MyColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Cancel button
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(color: MyColors.outColor),
              ),
            ),
            child: Text("Cancel",
                style: TextStyle(color: MyColors.blackColor)),
          ),
        ],
      ),
    );
  }
}
