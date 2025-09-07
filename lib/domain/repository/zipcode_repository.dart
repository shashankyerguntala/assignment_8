import 'package:assignment_8/domain/entity/zipcode_entity.dart';

abstract class ZipcodeRepository {
  Future<ZipcodeEntity> getData(String country, String zipCode);
}
