import 'package:flutter_number_trivia_season_3/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_season_3/core/feature/usecase/params.dart';
import 'package:flutter_number_trivia_season_3/core/feature/usecase/usecase.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/domain/repository/number_trivia_repository.dart';

class GetConcreteNumberTriviaUsecase implements Usecase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTriviaUsecase(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}
