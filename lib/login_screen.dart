import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final response = await http.post(
          Uri.parse(
              'http://localhost:3000/api/login'), 
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'username': username,
            'password': password,
          }),
        );

        if (response.statusCode == 200) {
          
          Navigator.pushReplacementNamed(context, '/home');
        } else if (response.statusCode == 401) {
          
          setState(() {
            _errorMessage =
                'Nombre de usuario o contraseña incorrectos. Por favor, regístrate.';
          });
        } else {
          
          setState(() {
            _errorMessage =
                'Error al iniciar sesión. Inténtalo de nuevo más tarde.';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Error de red. Inténtalo de nuevo más tarde.';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.lock,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(_usernameController, 'Nombre de usuario',
                      'Por favor ingrese su nombre de usuario'),
                  const SizedBox(height: 20),
                  _buildPasswordField(_passwordController, 'Contraseña',
                      'Por favor ingrese su contraseña'),
                  const SizedBox(height: 30),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 129, 234, 135), 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                          ),
                          child: const Text('Iniciar sesión'),
                        ),
                  const SizedBox(height: 20),
                  _errorMessage != null
                      ? Text(
                          _errorMessage!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      '¿No tienes una cuenta? Regístrate',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String errorText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(
      TextEditingController controller, String label, String errorText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
    );
  }
}
