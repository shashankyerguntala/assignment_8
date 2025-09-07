import 'dart:async';

import 'package:bloc/bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Map<String, String> countries = {
    "United States": "US",
    "India": "IN",
    "United Kingdom": "UK",
    "Canada": "CA",
    "Australia": "AU",
    "Germany": "DE",
    "France": "FR",
    "Italy": "IT",
    "Spain": "ES",
    "Japan": "JP",
    "China": "CN",
    "Brazil": "BR",
    "Mexico": "MX",
    "Russia": "RU",
    "South Africa": "ZA",
  };

  HomeBloc() : super(HomeInitial()) {
    on<LoadCountriesEvent>(onLoadCountries);
    on<SelectCountryEvent>(onSelectCountry);
  }

  FutureOr<void> onLoadCountries(
    LoadCountriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(HomeLoaded(country: countries));
  }

  FutureOr<void> onSelectCountry(
    SelectCountryEvent event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final selectedAbbreviation = countries[event.selectedCountry];
      emit(currentState.copyWith(selectedCountry: selectedAbbreviation));
    }
  }
}
