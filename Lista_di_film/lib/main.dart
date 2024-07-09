

import 'package:flutter/material.dart';
import 'package:lista_di_film/detailpage.dart';
import 'class_movie.dart';
import 'listof_film.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'SCEGLI UN FILM'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> filteredfimls = MovieList;
  TextEditingController searchController = TextEditingController();

  void _onMovieTap(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(movie: movie)),
    );
  }

  void _filterFilm(String query) {
    setState(() {
      filteredfimls = MovieList.where((movie) =>
          movie.titolo.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: ("Search"),
              prefixIcon: Icon(Icons.search)
            ),
            onChanged: _filterFilm,
          ),
          Expanded(
            child: ListView(
                children: [
                  for(var Movie in filteredfimls)
              InkWell(
                onTap:()=>  _onMovieTap(Movie),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 60,
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.orange, borderRadius: BorderRadius.circular(8)),
                  child: Text(
                  Movie.titolo
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
