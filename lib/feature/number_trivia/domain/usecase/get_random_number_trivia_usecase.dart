import 'package:flutter_number_trivia_season_3/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_season_3/core/feature/usecase/no_params.dart';
import 'package:flutter_number_trivia_season_3/core/feature/usecase/usecase.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRandomNumberTriviaUsecase implements Usecase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTriviaUsecase(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
