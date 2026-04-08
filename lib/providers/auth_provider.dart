import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final _service = AuthService();
  User? _user;
  bool _loading = false;
  String? _error;

  User? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get loading => _loading;
  String? get error => _error;

  AuthProvider() {
    _service.authChanges.listen((u) {
      _user = u;
      notifyListeners();
    });
  }

  Future<void> login(String email, String pass) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _user = await _service.signInWithEmail(email, pass);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> register(String email, String pass) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _user = await _service.registerWithEmail(email, pass);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> googleSignIn() async {
    _loading = true;
    notifyListeners();
    try {
      _user = await _service.signInWithGoogle();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _service.signOut();
    _user = null;
    notifyListeners();
  }
}
