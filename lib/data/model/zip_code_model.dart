import 'package:assignment_8/domain/entity/zipcode_entity.dart';

class ZipCodeModel extends ZipcodeEntity {
  ZipCodeModel({
    required super.country,
    required super.postCode,
    required super.placeName,
    required super.state,
    required super.longitude,
    required super.latitude,
  });

  factory ZipCodeModel.fromJson(Map<String, dynamic> json) {
    final place = (json["places"] as List)[0];

    return ZipCodeModel(
      country: json["country"],
      postCode: json["post code"],
      placeName: place["place name"],
      state: place["state"],
      longitude: place["longitude"],
      latitude: place["latitude"],
    );
  }
}
