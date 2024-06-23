import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';

part 'update_pulsa_event.dart';

class UpdatePulsaBloc extends Bloc<UpdatePulsaEvent, BaseState> {
  final UpdatePulsa updatePulsaUsecase;
  UpdatePulsaBloc(this.updatePulsaUsecase) : super(const InitializedState()) {
    on<UpdatePulsaAction>((event, emit) async {
      emit(const LoadingState());
      final result = await updatePulsaUsecase.execute(
        pulsa: event.pulsa,
        id: event.id,
      );
      result.fold(
        (failure) => emit(ErrorState(message: failure.message)),
        (data) => emit(SuccessState(data: data)),
      );
    });
  }
}
