import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_season_3/core/exception/server_exception.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:http/http.dart' show Client;
import 'package:injectable/injectable.dart';

abstract class NumberTriviaRemoteDatasource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

@Injectable(as: NumberTriviaRemoteDatasource)
class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDatasource {
  final Client client;

  NumberTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return _getConcreteOrRandom('http://numbersapi.com/$number');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return _getConcreteOrRandom('http://numbersapi.com/random');
  }

  Future<NumberTriviaModel> _getConcreteOrRandom(String url) async {
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return Future.value(
        NumberTriviaModel.fromJson(jsonDecode(response.body)),
      );
    } else {
      throw ServerException();
    }
  }
}
