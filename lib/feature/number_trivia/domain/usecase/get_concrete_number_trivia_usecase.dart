import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_season_3/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_season_3/core/feature/usecase/usecase.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetConcreteNumberTriviaUsecase implements Usecase<NumberTrivia, TriviaParams> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTriviaUsecase(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(TriviaParams params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class TriviaParams extends Equatable {
  final int number;

  TriviaParams({
    @required this.number,
  });

  @override
  List<Object> get props => [number];
}
