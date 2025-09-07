import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: "https://api.zippopotam.us",
          connectTimeout: const Duration(seconds: 5),
          headers: {"content-type": "application/json"},
        ),
      );

  Future<Response> get(String path) async {
    try {
      final response = await dio.get(path);
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw Exception("No internet connection. Please check your network.");
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection timed out. Try again later.");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Server is taking too long to respond.");
      } else if (e.type == DioExceptionType.badResponse) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          throw Exception("No data found for this ZIP code.");
        } else {
          throw Exception("Server error: $statusCode");
        }
      } else {
        throw Exception("Something went wrong. Please try again.");
      }
    }
  }
}
