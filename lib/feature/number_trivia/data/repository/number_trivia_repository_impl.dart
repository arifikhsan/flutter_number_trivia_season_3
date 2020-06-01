import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_season_3/core/exception/cache_exception.dart';
import 'package:flutter_number_trivia_season_3/core/exception/server_exception.dart';
import 'package:flutter_number_trivia_season_3/core/failure/cache_failure.dart';
import 'package:flutter_number_trivia_season_3/core/failure/server_failure.dart';
import 'package:flutter_number_trivia_season_3/core/network/network_info.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/data/datasource/number_trivia_remote_datasource.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_number_trivia_season_3/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:injectable/injectable.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

@Injectable(as: NumberTriviaRepository)
class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDatasource remoteDatasource;
  final NumberTriviaLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDatasource,
    @required this.localDatasource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    return await getConcreteOrRandom(() {
      return remoteDatasource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await getConcreteOrRandom(() {
      return remoteDatasource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> getConcreteOrRandom(
    _ConcreteOrRandomChooser concreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await concreteOrRandom();
        await localDatasource.cacheNumberTrivia(remoteTrivia);
        return right(remoteTrivia);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDatasource.getLastNumberTrivia();
        return right(localTrivia);
      } on CacheException {
        return left(CacheFailure());
      }
    }
  }
}
