part of 'zip_bloc.dart';

@immutable
sealed class ZipState {}

final class ZipInitial extends ZipState {}

final class ZipLoading extends ZipState {}

class ZipCodeDetails extends ZipState {
  final ZipcodeEntity data;

  ZipCodeDetails({required this.data});
}

class ZipError extends ZipState {
  final String message;
  ZipError({required this.message});
}
