import 'package:flutter/material.dart';

class PasswordValidatorPage extends StatefulWidget {
  const PasswordValidatorPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordValidatorPageState createState() => _PasswordValidatorPageState();
}

class _PasswordValidatorPageState extends State<PasswordValidatorPage> {
  String _password = '';
  String _passwordStrength = 'weak'; // weak, medium, strong

  // Función para evaluar la seguridad de la contraseña
  void _evaluatePassword(String password) {
    setState(() {
      _password = password;

      if (_password.length < 6) {
        _passwordStrength = 'weak';
      } else if (_password.length >= 6 && _password.length < 8) {
        _passwordStrength = 'medium';
      } else if (_password.length >= 8 && _hasLettersAndNumbers(_password)) {
        _passwordStrength = 'strong';
      } else {
        _passwordStrength = 'weak';
      }
    });
  }

  // Función para verificar si la contraseña tiene letras y números
  bool _hasLettersAndNumbers(String password) {
    final hasLetters = password.contains(RegExp(r'[a-zA-Z]'));
    final hasNumbers = password.contains(RegExp(r'[0-9]'));
    return hasLetters && hasNumbers;
  }

  // Método para obtener la imagen según la seguridad de la contraseña
  String _getImageForPasswordStrength() {
    switch (_passwordStrength) {
      case 'medium':
        return 'assets/images/normal.jpg';
      case 'strong':
        return 'assets/images/fuerte.jpg';
      default:
        return 'assets/images/bajo.jpg';
    }
  }

  // Método para obtener el color según la seguridad de la contraseña
  Color _getColorForPasswordStrength() {
    switch (_passwordStrength) {
      case 'medium':
        return Colors.orange;
      case 'strong':
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validador de Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo de contraseña
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Introduce tu contraseña',
                border: const OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.lock,
                  color: _getColorForPasswordStrength(),
                ),
              ),
              onChanged: _evaluatePassword, // Valida en tiempo real
            ),
            const SizedBox(height: 30),
            
            // Imagen del mapache que cambia según la seguridad de la contraseña
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _getColorForPasswordStrength().withOpacity(0.2),
              ),
              child: Image.asset(_getImageForPasswordStrength()),
            ),
            const SizedBox(height: 20),

            // Mensaje de texto que indica la fortaleza de la contraseña
            Text(
              _passwordStrength == 'weak'
                  ? 'Contraseña débil'
                  : _passwordStrength == 'medium'
                      ? 'Contraseña razonable'
                      : '¡Contraseña fuerte!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _getColorForPasswordStrength(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
