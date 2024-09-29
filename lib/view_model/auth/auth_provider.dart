import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../service/google/google_sign_in_service.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthState {
  final bool isAuthenticated;

  AuthState({required this.isAuthenticated});

  AuthState copyWith({bool? isAuthenticated}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState(isAuthenticated: false)) {
    _checkAuthStatus();
  }

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> _checkAuthStatus() async {
    final accessToken = await _secureStorage.read(key: 'accessToken');
    if (accessToken != null) {
      state = state.copyWith(isAuthenticated: true);
    }
  }

  Future<void> signIn() async {
    await GoogleSignInService().signInWithGoogle();
    state = state.copyWith(isAuthenticated: true);
  }

  Future<void> signOut() async {
    await GoogleSignInService().signOutGoogle();
    state = state.copyWith(isAuthenticated: false);
  }
}
