import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class TriviaControlWidget extends StatefulWidget {
  @override
  _TriviaControlWidgetState createState() => _TriviaControlWidgetState();
}

class _TriviaControlWidgetState extends State<TriviaControlWidget> {
  TextEditingController textEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Form(
        key: formKey,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: textEditingController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  return value.isEmpty ? 'Please enter some number' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter a number...',
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            RaisedButton.icon(
              onPressed: () {
                formKey.currentState.validate();
                BlocProvider.of<NumberTriviaBloc>(context).add(
                  GetTriviaForConcreteNumber(textEditingController.text),
                );
                // if (formKey.currentState.validate()) {
                //   print(textEditingController.text);
                // }
              },
              icon: Icon(Icons.send),
              label: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
