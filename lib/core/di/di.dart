import 'package:assignment_8/core/network/dio_client.dart';
import 'package:assignment_8/data/data_sources/remote_data_sources.dart/zip_code_data_source.dart';
import 'package:assignment_8/data/respository_impl/zip_code_repository_impl.dart';
import 'package:assignment_8/domain/repository/zipcode_repository.dart';

import 'package:assignment_8/domain/usecase/get_data_usecase.dart';
import 'package:assignment_8/presentation/features/zip_details/bloc/zip_bloc.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

class Di {
  Future<void> init() async {
    di.registerLazySingleton<DioClient>(() => DioClient());
    di.registerLazySingleton<ZipBloc>(() => ZipBloc(di()));
    di.registerLazySingleton(() => ZipCodeDataSource());

    di.registerLazySingleton<ZipcodeRepository>(
      () => ZipCodeRepositoryImpl(zipCodeDataSource: di()),
    );
    di.registerLazySingleton<GetDataUsecase>(
      () => GetDataUsecase(zipcodeRepository: di()),
    );
  }
}
