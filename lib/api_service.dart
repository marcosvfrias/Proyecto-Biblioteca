import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // agregar un libro
  Future<void> addBook(String title, String description, String publicationDate,
      String author) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/books'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'description': description,
          'publication_date': publicationDate,
          'author': author,
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add book: ${response.body}');
      }
    } catch (error) {
      print('Error al agregar libro: $error');
      rethrow;
    }
  }

  // obtener todos los libros
  Future<List<dynamic>> getBooks() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/books'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load books: ${response.body}');
      }
    } catch (error) {
      print('Error al obtener libros: $error');
      rethrow;
    }
  }

  // actualizar un libro
  Future<void> updateBook(int id, String title, String description,
      String publicationDate, String author) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/books/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'description': description,
          'publication_date': publicationDate,
          'author': author,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update book: ${response.body}');
      }
    } catch (error) {
      print('Error al actualizar libro: $error');
      rethrow;
    }
  }

  // borrar un libro
  Future<void> deleteBook(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/books/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete book: ${response.body}');
      }
    } catch (error) {
      print('Error al borrar libro: $error');
      rethrow;
    }
  }
}
