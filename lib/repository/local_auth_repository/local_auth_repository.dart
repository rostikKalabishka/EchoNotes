import 'dart:developer';

import 'package:local_auth/local_auth.dart';
import 'package:note_app/repository/local_auth_repository/abstract_local_auth_repository.dart';

class LocalAuthRepository implements AbstractLocalAuthRepository {
  final LocalAuthentication auth;

  LocalAuthRepository({required this.auth});

  Future<bool> _canAuthenticate() async {
    return await auth.canCheckBiometrics &&
        (await auth.getAvailableBiometrics()).contains(BiometricType.face);
  }

  @override
  Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) return false;

      return await auth.authenticate(
        // authMessages: [],
        localizedReason: 'Use Face ID to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      log('$e');
      return false;
    }
  }
}
