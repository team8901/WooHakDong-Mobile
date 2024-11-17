import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GeneralFunctions {
  static Future<bool?> toastMessage(String msg) async {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      fontSize: 14,
      fontAsset: 'assets/fonts/pretendard/Pretendard-SemiBold.otf',
      backgroundColor: const Color(0xFF6C6E75).withOpacity(0.8),
      textColor: const Color(0xFFFCFCFC),
    );
  }

  static void clipboardCopy(String content, String toastMsg) async {
    await Clipboard.setData(ClipboardData(text: content));
    await toastMessage(toastMsg);
  }
}
