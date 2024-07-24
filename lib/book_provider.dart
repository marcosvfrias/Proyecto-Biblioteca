import 'package:flutter/material.dart';
import 'api_service.dart';

class Book {
  final String title;
  final String description;
  final String date;
  final String author;
  int votes;

  Book(this.title, this.description, this.date, this.author, {this.votes = 0});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      json['title'] ?? 'No title',
      json['description'] ?? 'No description',
      json['publication_date'] ?? 'No date',
      json['author'] ?? 'No author',
      votes: json['votes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'publication_date': date,
      'author': author,
      'votes': votes,
    };
  }
}

class BookProvider with ChangeNotifier {
  final ApiService apiService = ApiService(baseUrl: 'http://localhost:3000');
  final List<Book> _books = [];

  List<Book> get books => _books;

  Future<void> fetchBooks() async {
    try {
      final List<dynamic> bookList = await apiService.getBooks();
      print('Books fetched: $bookList');
      _books.clear();
      _books.addAll(bookList.map((json) {
        print('Book JSON: $json');
        return Book.fromJson(json);
      }).toList());
      print('Books added to list: $_books');
      notifyListeners();
    } catch (error) {
      print('Error al cargar los libros: $error');
      throw Exception('Failed to load books: $error');
    }
  }

  Future<void> addBook(String title, String description, String publicationDate,
      String author, int userId) async {
    try {
      await apiService.addBook(
        title,
        description,
        publicationDate,
        author,
      );
      await fetchBooks();
    } catch (e) {
      print('Exception al agregar libro: $e');
    }
  }

  void upvoteBook(int index) {
    _books[index].votes++;
    notifyListeners();
  }

  void downvoteBook(int index) {
    _books[index].votes--;
    notifyListeners();
  }
}
 