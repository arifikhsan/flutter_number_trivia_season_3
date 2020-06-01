import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_season_3/core/feature/presentation/number_trivia_app.dart';
import 'package:flutter_number_trivia_season_3/injection/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(NumberTriviaApp());
}
