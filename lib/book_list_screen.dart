import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_provider.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('Fetching books...'); 
      Provider.of<BookProvider>(context, listen: false).fetchBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book List'),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          print('Books in provider: ${bookProvider.books}'); 
          if (bookProvider.books.isEmpty) {
            return const Center(
              child: Text(''),
            );
          } else {
            return ListView.builder(
              itemCount: bookProvider.books.length,
              itemBuilder: (context, index) {
                final book = bookProvider.books[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.book,
                          size: 40.0,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                book.description,
                                style: const TextStyle(color: Colors.black54),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Published on: ${book.date}',
                                style: const TextStyle(color: Colors.black54),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Author: ${book.author}',
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.thumb_up),
                              color: Colors.blue,
                              onPressed: () {
                                print(
                                    'Upvoting book at index: $index'); 
                                Provider.of<BookProvider>(context,
                                        listen: false)
                                    .upvoteBook(index);
                              },
                            ),
                            Text(
                              book.votes.toString(),
                              style: const TextStyle(color: Colors.blue),
                            ),
                            IconButton(
                              icon: const Icon(Icons.thumb_down),
                              color: Colors.blue,
                              onPressed: () {
                                print(
                                    'Downvoting book at index: $index'); 
                                Provider.of<BookProvider>(context,
                                        listen: false)
                                    .downvoteBook(index);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
