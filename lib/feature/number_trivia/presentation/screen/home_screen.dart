import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/presentation/widget/trivia_control_widget.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/presentation/widget/trivia_display_widget.dart';
import 'package:flutter_number_trivia_season_3/injection/injection.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: buildBody(),
      ),
    );
  }

  BlocProvider buildBody() {
    return BlocProvider<NumberTriviaBloc>(
      create: (_) => locator<NumberTriviaBloc>(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TriviaDisplayWidget(),
            TriviaControlWidget(),
          ],
        ),
      ),
    );
  }
}
