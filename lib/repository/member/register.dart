import 'package:dio/dio.dart';
import 'package:woohakdong/service/logger/logger.dart';

import '../../model/member/member_model.dart';
import '../../service/dio/dio_service.dart';

class Register {
  final Dio _dio = DioService().dio;

  Future<void> woohakdongRegister(Member member) async {
    try {
      final response = await _dio.post(
        '/member/info',
        data: {
          'memberName': member.memberName,
          'memberPhoneNumber': member.memberPhoneNumber,
          'memberEmail': member.memberEmail,
          'memberMajor': member.memberMajor,
          'memberStudentNumber': member.memberStudentNumber,
          'memberGender': member.memberGender,
        },
      );

      if (response.statusCode == 200) {
        logger.i('우학동 회원가입 성공');
      } else {
        logger.e('서버 에러', error: response.data);
      }
    } catch (e) {
      logger.e('우학동 회원가입 실패', error: e);
    }
  }
}
