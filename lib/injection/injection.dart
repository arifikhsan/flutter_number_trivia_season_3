import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_number_trivia_season_3/core/network/network_info.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/data/datasource/number_trivia_remote_datasource.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/data/repository/number_trivia_repository_impl.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/domain/usecase/get_concrete_number_trivia_usecase.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/domain/usecase/get_random_number_trivia_usecase.dart';
import 'package:flutter_number_trivia_season_3/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_number_trivia_season_3/util/input_converter.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  //* Features
  locator.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: locator(),
      getRandomNumberTrivia: locator(),
      inputConverter: locator(),
    ),
  );

  //* Usecases
  locator.registerLazySingleton(
    () => GetConcreteNumberTriviaUsecase(locator()),
  );
  locator.registerLazySingleton(
    () => GetRandomNumberTriviaUsecase(locator()),
  );

  //* Repository
  locator.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDatasource: locator(),
      localDatasource: locator(),
      networkInfo: locator(),
    ),
  );

  //* Data sources
  locator.registerLazySingleton<NumberTriviaRemoteDatasource>(
    () => NumberTriviaRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<NumberTriviaLocalDatasource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: locator()),
  );

  //* Core
  locator.registerLazySingleton(() => InputConverter());
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(locator()),
  );

  //* External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
