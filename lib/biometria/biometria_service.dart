// lib/widgets/biometric_auth.dart
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuth extends StatefulWidget {
  @override
  _BiometricAuthState createState() => _BiometricAuthState();
}

class _BiometricAuthState extends State<BiometricAuth> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isBiometricSupported = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricSupport();
  }

  Future<void> _checkBiometricSupport() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    setState(() {
      _isBiometricSupported = canCheckBiometrics;
    });
  }

  Future<void> _authenticateBiometrics() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Autentique-se para continuar',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (authenticated) {
        // Login bem-sucedido
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isBiometricSupported
        ? Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: _authenticateBiometrics,
              child: Text('Login via Biometria'),
            ),
          )
        : Container();
  }
}
