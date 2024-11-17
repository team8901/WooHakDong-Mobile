import 'package:currency_formatter/currency_formatter.dart';
import 'package:intl/intl.dart';

class GeneralFormat {
  static String formatDateTime(DateTime? date) {
    String dateString = date.toString();
    DateTime dateTime = DateTime.parse(dateString).toLocal();
    int currentYear = DateTime.now().year;
    bool isCurrentYear = dateTime.year == currentYear;
    String dateFormat = isCurrentYear ? 'M월 d일 (E) a h:mm' : 'yyyy년 M월 d일 (E) a h:mm';

    return DateFormat(dateFormat, 'ko_KR').format(dateTime);
  }

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

  static String formatClubGeneration(String clubGeneration) {
    String formattedGeneration = '$clubGeneration기';

    return formattedGeneration;
  }

  static String formatClubDues(int clubDues) {
    String formattedDues = CurrencyFormatter.format(
      clubDues.toString(),
      const CurrencyFormat(
        symbol: '원',
        symbolSide: SymbolSide.right,
        symbolSeparator: '',
        thousandSeparator: ',',
      ),
    );

    return formattedDues;
  }

  static String formatClubRole(String role) {
    switch (role) {
      case 'PRESIDENT':
        return '회장';
      case 'VICEPRESIDENT':
        return '부회장';
      case 'SECRETARY':
        return '총무';
      case 'OFFICER':
        return '임원';
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
