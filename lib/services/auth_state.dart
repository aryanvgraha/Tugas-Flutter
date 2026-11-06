import 'package:flutter/foundation.dart';

/// State login sederhana (tanpa backend) yang dibagikan ke seluruh aplikasi.
class AuthState extends ChangeNotifier {
  AuthState._();
  static final AuthState instance = AuthState._();

  String _name = 'Mahasiswa Unigal';
  String _email = '';

  String get name => _name;
  String get email => _email;

  void login({required String email, String? name}) {
    _email = email;
    if (name != null && name.trim().isNotEmpty) {
      _name = name.trim();
    } else if (_name == 'Mahasiswa Unigal' || _name.isEmpty) {
      final local = email.split('@').first;
      if (local.isNotEmpty) {
        _name = local[0].toUpperCase() + local.substring(1);
      }
    }
    notifyListeners();
  }

  void logout() {
    _name = 'Mahasiswa Unigal';
    _email = '';
    notifyListeners();
  }
}
