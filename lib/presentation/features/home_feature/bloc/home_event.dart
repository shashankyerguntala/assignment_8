part of 'home_bloc.dart';

sealed class HomeEvent {}

class LoadCountriesEvent extends HomeEvent {}

class SelectCountryEvent extends HomeEvent {
  final String selectedCountry;
  SelectCountryEvent(this.selectedCountry);
}
