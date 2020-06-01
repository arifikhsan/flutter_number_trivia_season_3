import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/presentation/widget/middleware/blue_board_widget.dart';

class TriviaLoadedWidget extends StatelessWidget {
  final NumberTrivia numberTrivia;

  const TriviaLoadedWidget({Key key, this.numberTrivia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlueBoardWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${numberTrivia.number}',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '${numberTrivia.text}',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
