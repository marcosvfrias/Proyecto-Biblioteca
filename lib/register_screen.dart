import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final lastName = _lastNameController.text;
      final email = _emailController.text;
      final gender = _genderController.text;
      final username = _usernameController.text;
      final password = _passwordController.text;

      setState(() {
        _isLoading = true;
      });

      try {
        final response = await http.post(
          Uri.parse('http://localhost:3000/api/register'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'name': name,
            'lastName': lastName,
            'email': email,
            'gender': gender,
            'username': username,
            'password': password,
          }),
        );

        if (response.statusCode == 201) {
          Navigator.pop(context);
        }
      } catch (e) {
        // Manejo básico de excepciones. Considera agregar una forma de informar al usuario si es necesario.
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
      appBar: AppBar(
        title: const Text('Registrar'),
        backgroundColor:
            const Color.fromARGB(255, 25, 210, 74), // Color del AppBar
      ),
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
                      Icons.person_add,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(
                      _nameController, 'Nombre', 'Por favor ingrese su nombre'),
                  const SizedBox(height: 20),
                  _buildTextField(_lastNameController, 'Apellido',
                      'Por favor ingrese su apellido'),
                  const SizedBox(height: 20),
                  _buildTextField(_emailController, 'Correo electrónico',
                      'Por favor ingrese su correo electrónico'),
                  const SizedBox(height: 20),
                  _buildTextField(_genderController, 'Género',
                      'Por favor ingrese su género'),
                  const SizedBox(height: 20),
                  _buildTextField(_usernameController, 'Nombre de usuario',
                      'Por favor ingrese su nombre de usuario'),
                  const SizedBox(height: 20),
                  _buildPasswordField(_passwordController, 'Contraseña',
                      'Por favor ingrese su contraseña'),
                  const SizedBox(height: 30),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 129, 234, 135), // Color del botón
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                          ),
                          child: const Text('Registrar'),
                        ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '¿Ya tienes una cuenta? Inicia sesión',
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
