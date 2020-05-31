import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_season_3/core/constant/number_trivia_constant.dart';
import 'package:flutter_number_trivia_season_3/core/exception/cache_exception.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDatasource {
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
  Future<NumberTriviaModel> getLastNumberTrivia();
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDatasource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) async {
    return await sharedPreferences.setString(
      CACHE_NUMBER_TRIVIA,
      jsonEncode(triviaToCache.toJson()),
    );
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHE_NUMBER_TRIVIA);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
