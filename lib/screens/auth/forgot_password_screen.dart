import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() => _State();
}

class _State extends State<ForgotPasswordScreen> {
  final _emailCtrl = TextEditingController();
  final _service = AuthService();
  String? _msg;
  bool _isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Восстановление пароля')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                TextField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                if (_msg != null)
                  Text(
                    _msg!,
                    style: TextStyle(
                      color: _isError ? Colors.red : Colors.green,
                    ),
                  ),

                const SizedBox(height: 8),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),

                  onPressed: () async {
                    try {
                      await _service.resetPassword(_emailCtrl.text);
                      setState(() {
                        _msg = 'Письмо отправлено! Проверь почту.';
                        _isError = false;
                      });
                    } catch (e) {
                      setState(() {
                        _msg = 'Ошибка: ${e.toString()}';
                        _isError = true;
                      });
                    }
                  },

                  child: const Text('Отправить письмо'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
