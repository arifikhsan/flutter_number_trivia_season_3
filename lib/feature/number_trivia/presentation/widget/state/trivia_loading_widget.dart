import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/presentation/widget/middleware/blue_board_widget.dart';

class TriviaLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlueBoardWidget(
      child: CircularProgressIndicator(),
    );
  }
}
