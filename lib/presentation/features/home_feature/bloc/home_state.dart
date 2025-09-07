part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Map<String, String> country;
  final String? selectedCountry;

  HomeLoaded({required this.country, this.selectedCountry});

  HomeLoaded copyWith({Map<String, String>? country, String? selectedCountry}) {
    return HomeLoaded(
      country: country ?? this.country,
      selectedCountry: selectedCountry ?? this.selectedCountry,
    );
  }
}
