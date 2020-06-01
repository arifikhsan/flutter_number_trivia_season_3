import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/presentation/widget/state/trivia_error_widget.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/presentation/widget/state/trivia_loaded_widget.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/presentation/widget/state/trivia_loading_widget.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/presentation/widget/state/trivia_message_widget.dart';

class TriviaDisplayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
      builder: (context, state) {
        if (state is Empty) {
          return TriviaMessageWidget(
            message: 'Start Searching!',
          );
        } else if (state is Loading) {
          return TriviaLoadingWidget();
        } else if (state is Loaded) {
          return TriviaLoadedWidget(
            numberTrivia: state.trivia,
          );
        } else if (state is Error) {
          return TriviaErrorWidget(
            message: state.message,
          );
        } else {
          return TriviaMessageWidget(
            message: 'What\'s happen?',
          );
        }
      },
    );
  }
}
