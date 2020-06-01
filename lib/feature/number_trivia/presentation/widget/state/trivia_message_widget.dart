import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/presentation/widget/middleware/blue_board_widget.dart';

class TriviaMessageWidget extends StatelessWidget {
  final String message;

  const TriviaMessageWidget({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlueBoardWidget(
      child: Text(
        message,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
