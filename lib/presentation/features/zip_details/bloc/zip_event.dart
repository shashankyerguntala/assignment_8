part of 'zip_bloc.dart';

@immutable
sealed class ZipEvent {}

class GetDetailsEvent extends ZipEvent {
  final String country;
  final String zipCode;

  GetDetailsEvent({required this.country, required this.zipCode});
}
