import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

class GeneralFunctions {
  static Future<bool?> generalToastMessage(String msg) async {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      gravity: ToastGravity.CENTER,
      fontSize: 14,
      fontAsset: 'assets/fonts/pretendard/Pretendard-SemiBold.otf',
      backgroundColor: const Color(0xFFE7E7E7),
      textColor: const Color(0xFF202020),
    );
  }
}
