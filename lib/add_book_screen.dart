import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_provider.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  bool _isLoading = false;

  Future<void> addBook() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final date = _dateController.text;
    final author = _authorController.text;

    if (title.isNotEmpty &&
        description.isNotEmpty &&
        date.isNotEmpty &&
        author.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
        await Provider.of<BookProvider>(context, listen: false).addBook(
          title,
          description,
          date,
          author,
          1,
        );
        Navigator.pop(context);
      } catch (e) {
        if (kDebugMode) {
          print('Error al agregar el libro: $e');
        }
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
              Color.fromARGB(255, 25, 210, 74),
              Color.fromARGB(255, 161, 13, 13),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: const Text(
                  'Agregar Libro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(_titleController, 'Título', 'Por favor ingrese el título'),
              const SizedBox(height: 20),
              _buildTextField(_descriptionController, 'Descripción', 'Por favor ingrese la descripción'),
              const SizedBox(height: 20),
              _buildTextField(_dateController, 'Fecha de Publicación', 'Por favor ingrese la fecha de publicación'),
              const SizedBox(height: 20),
              _buildTextField(_authorController, 'Autor', 'Por favor ingrese el autor'),
              const SizedBox(height: 30),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: addBook,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 129, 234, 135),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                      ),
                      child: const Text('Guardar'),
                    ),
            ],
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
        labelStyle: TextStyle(
          color: Colors.black.withOpacity(0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
    );
  }
}
