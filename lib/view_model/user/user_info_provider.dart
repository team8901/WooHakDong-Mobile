import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/user/user_model.dart';

final userInfoProvider = FutureProvider<UserModel>((ref) async {
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  final userName = await secureStorage.read(key: 'userName');
  final userEmail = await secureStorage.read(key: 'userEmail');

  if (userName == null || userEmail == null) {
    throw Exception('Secure Storage에 사용자 정보가 없습니다.');
  }

  return UserModel(userName: userName, userEmail: userEmail);
});
