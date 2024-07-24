import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_book_screen.dart';
import 'book_list_screen.dart';
import 'book_provider.dart';
import 'login_screen.dart';
import 'register_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Biblioteca',
        theme: ThemeData(
          primarySwatch: Colors
              .green, 
          appBarTheme: AppBarTheme(
            color: const Color.fromARGB(255, 25, 210, 74), 
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(
                  255, 129, 234, 135), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, 
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
              color: Colors.black
                  .withOpacity(0.5), 
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0), 
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.black, width: 1.0), 
              borderRadius: BorderRadius.circular(30.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.black, width: 1.0), 
              borderRadius: BorderRadius.circular(30.0),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            floatingLabelBehavior:
                FloatingLabelBehavior.never, 
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/add_book': (context) => const AddBookScreen(),
          '/book_list': (context) => const BookListScreen(),
          '/register': (context) =>
              const RegisterScreen(), 
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BiblioLearn'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Bienvenido a BiblioLearn!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_book');
              },
              child: const Text('Add Book'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/book_list');
              },
              child: const Text('View Books'),
            ),
          ],
        ),
      ),
    );
  }
}
