import 'package:assignment_8/domain/entity/zipcode_entity.dart';
import 'package:assignment_8/domain/repository/zipcode_repository.dart';

class GetDataUsecase {
  final ZipcodeRepository zipcodeRepository;

  GetDataUsecase({required this.zipcodeRepository});

  Future<ZipcodeEntity> getData(String country, String zipCode) {
    return zipcodeRepository.getData(country, zipCode);
  }
}
