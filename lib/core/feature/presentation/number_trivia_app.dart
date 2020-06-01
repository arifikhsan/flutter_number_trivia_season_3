import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/presentation/screen/home_screen.dart';

class NumberTriviaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
