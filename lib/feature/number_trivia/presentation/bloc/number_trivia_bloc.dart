import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_season_3/core/failure/cache_failure.dart';
import 'package:flutter_number_trivia_season_3/core/failure/failure.dart';
import 'package:flutter_number_trivia_season_3/core/failure/server_failure.dart';
import 'package:flutter_number_trivia_season_3/core/feature/usecase/no_params.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/domain/usecase/get_concrete_number_trivia_usecase.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/domain/usecase/get_random_number_trivia_usecase.dart';
import 'package:flutter_number_trivia_season_3/util/input_converter.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTriviaUsecase getConcreteNumberTrivia;
  final GetRandomNumberTriviaUsecase getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    this.getConcreteNumberTrivia,
    this.getRandomNumberTrivia,
    this.inputConverter,
  })  : assert(getConcreteNumberTrivia != null),
        assert(getRandomNumberTrivia != null),
        assert(inputConverter != null);

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      yield* _mapGetTriviaForConcreteNumberToState(event);
    } else if (event is GetTriviaForRandomNumber) {
      yield* _mapGetTriviaForRandomNumberToState();
    } else if (event is ResetTrivia) {
      yield* _mapResetTriviaToState();
    }
  }

  Stream<NumberTriviaState> _mapGetTriviaForConcreteNumberToState(
    GetTriviaForConcreteNumber event,
  ) async* {
    final inputEither =
        inputConverter.stringToUnsignedInteger(event.numberString);

    yield* inputEither.fold(
      (failure) async* {
        yield Error(message: 'Invalid input');
      },
      (integer) async* {
        yield Loading();
        final failureOrTrivia =
            await getConcreteNumberTrivia(TriviaParams(number: integer));
        yield* _eitherLoadedOrErrorState(failureOrTrivia);
      },
    );
  }

  Stream<NumberTriviaState> _mapGetTriviaForRandomNumberToState() async* {
    yield Loading();
    final failureOrTrivia = await getRandomNumberTrivia(NoParams());
    yield* _eitherLoadedOrErrorState(failureOrTrivia);
  }

  Stream<NumberTriviaState> _mapResetTriviaToState() async* {
    yield Empty();
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> failureOrTrivia,
  ) async* {
    yield* failureOrTrivia.fold(
      (failure) async* {
        yield Error(message: _mapFailureToMessage(failure));
      },
      (trivia) async* {
        yield Loaded(trivia: trivia);
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
        break;
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Failure';
    }
  }
}
