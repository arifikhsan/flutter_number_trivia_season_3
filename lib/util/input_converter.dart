import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_season_3/core/failure/failure.dart';
import 'package:flutter_number_trivia_season_3/core/failure/invalid_input_failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String string) {
    try {
      final integer = int.parse(string);
      return right(integer);
    } on FormatException {
      return left(InvalidInputFailure());
    }
  }
}
