import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user/user_model.dart';

final userInfoProvider = FutureProvider<UserModel>((ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userName = prefs.getString('userName');
  String? userEmail = prefs.getString('userEmail');

  return UserModel(name: userName, email: userEmail);
});
