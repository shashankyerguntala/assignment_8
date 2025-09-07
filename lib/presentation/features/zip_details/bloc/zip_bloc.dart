import 'dart:async';

import 'package:assignment_8/domain/entity/zipcode_entity.dart';
import 'package:assignment_8/domain/usecase/get_data_usecase.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'zip_event.dart';
part 'zip_state.dart';

class ZipBloc extends Bloc<ZipEvent, ZipState> {
  final GetDataUsecase getDataUsecase;
  ZipBloc(this.getDataUsecase) : super(ZipLoading()) {
    on<GetDetailsEvent>(getDetailsEvent);
  }
  FutureOr<void> getDetailsEvent(
    GetDetailsEvent event,
    Emitter<ZipState> emit,
  ) async {
    emit(ZipLoading());

    try {
      final country = event.country;
      final data = await getDataUsecase.getData(country, event.zipCode);
      emit(ZipCodeDetails(data: data));
    } catch (e) {
      emit(ZipError(message: e.toString()));
    }
  }
}
