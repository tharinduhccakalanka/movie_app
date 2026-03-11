import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: Colors.grey[900],
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
