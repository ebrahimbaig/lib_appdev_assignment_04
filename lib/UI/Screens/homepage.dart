import 'package:flutter/material.dart';
import 'package:lib_appdev_assignment/Providers/bookprovider.dart';
import 'package:lib_appdev_assignment/UI/Widgets/bookcard.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<BooksProvider>().fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    final booklist = context.watch<BooksProvider>().books;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: context.watch<BooksProvider>().isBooksFetching
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                  itemCount: booklist.length,
                  itemBuilder: (context, index) {
                    return bookCard(
                      bookName: booklist[index].bookName,
                      authors: booklist[index].authors,
                      bookImageURL: booklist[index].bookImageURL,
                      isFav: booklist[index].isfavorite,
                    );
                  }),
            ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}