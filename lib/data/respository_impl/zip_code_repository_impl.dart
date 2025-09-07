import 'package:assignment_8/data/data_sources/remote_data_sources.dart/zip_code_data_source.dart';
import 'package:assignment_8/domain/entity/zipcode_entity.dart';
import 'package:assignment_8/domain/repository/zipcode_repository.dart';

class ZipCodeRepositoryImpl extends ZipcodeRepository {
  final ZipCodeDataSource zipCodeDataSource;

  ZipCodeRepositoryImpl({required this.zipCodeDataSource});
  @override
  Future<ZipcodeEntity> getData(String country, String zipCode) {
    return zipCodeDataSource.getData(country, zipCode);
  }
}
