import 'dart:ui';

import 'package:currency_formatter/currency_formatter.dart';
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

  /// 회원 정보 관련 함수
  static String formatMemberPhoneNumber(String memberPhoneNumber) {
    final formattedPhoneNumber = memberPhoneNumber.replaceFirstMapped(
      RegExp(r'^(\d{3})(\d{4})(\d{4})$'),
      (Match m) => '${m[1]}-${m[2]}-${m[3]}',
    );
    return formattedPhoneNumber;
  }

  static String formatMemberGender(String? gender) {
    if (gender == 'MAN') {
      return '남성';
    } else {
      return '여성';
    }
  }

  /// 동아리 정보 관련 함수
  static String formatClubGeneration(String clubGeneration) {
    String formattedGeneration = '$clubGeneration 기';

    return formattedGeneration;
  }

  static String formatClubDues(int clubDues) {
    String formattedDues = CurrencyFormatter.format(
      clubDues.toString(),
      const CurrencyFormat(
        symbol: '원',
        symbolSide: SymbolSide.right,
        decimalSeparator: ',',
      ),
    );

    return formattedDues;
  }

  static String formatClubRole(String role) {
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

  static String formatClubAssignedTerm(String term) {
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

  /// 물품 정보 관련 함수
  static String formatItemCategory(String itemCategory) {
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
