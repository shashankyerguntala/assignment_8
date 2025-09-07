import 'package:assignment_8/core/network/dio_client.dart';
import 'package:assignment_8/data/model/zip_code_model.dart';
import 'package:assignment_8/core/di/di.dart';
import 'package:assignment_8/domain/entity/zipcode_entity.dart';

class ZipCodeDataSource {
  Future<ZipcodeEntity> getData(String country, String zipCode) async {
    final DioClient dioClient = di<DioClient>();
    final response = await dioClient.get("/$country/$zipCode");

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = response.data;
      if (jsonMap.isEmpty) {
        throw Exception("Invalid ZIP code. Please try again.");
      }
      return ZipCodeModel.fromJson(jsonMap);
    } else {
      throw Exception("Error while fetching data: ${response.statusCode}");
    }
  }
}
