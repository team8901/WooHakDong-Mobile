import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

class GeneralFunctions {
  static Future<bool?> generalToastMessage(String msg) async {
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

  static String formatPhoneNumber(String memberPhoneNumber) {
    final formattedPhoneNumber = memberPhoneNumber.replaceFirstMapped(
      RegExp(r'^(\d{3})(\d{4})(\d{4})$'),
      (Match m) => '${m[1]}-${m[2]}-${m[3]}',
    );
    return formattedPhoneNumber;
  }

  static String getGenderDisplay(String? gender) {
    if (gender == 'MAN') {
      return '남성';
    } else {
      return '여성';
    }
  }

  static String getRoleDisplayName(String role) {
    switch (role) {
      case 'PRESIDENT':
        return '회장';
      case 'OFFICER':
        return '임원진';
      case 'MEMBER':
        return '회원';
      default:
        return '회원';
    }
  }

  static String getAssignedTermDisplay(String term) {
    final date = DateTime.tryParse(term);

    if (date == null) return term;

    final year = date.year;
    final month = date.month;

    if (month >= 1 && month <= 6) {
      return '$year년 1학기';
    } else if (month >= 7 && month <= 12) {
      return '$year년 2학기';
    }

    return term;
  }

  static String translateItemCategory(String itemCategory) {
    switch (itemCategory) {
      case 'DIGITAL':
        return '디지털';
      case 'SPORT':
        return '스포츠';
      case 'BOOK':
        return '도서';
      case 'CLOTHES':
        return '의류';
      case 'STATIONERY':
        return '문구류';
      case 'ETC':
        return '기타';
      default:
        return '전체';
    }
  }
}
