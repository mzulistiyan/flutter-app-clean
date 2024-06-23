import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_clean_arch/core/base_state/base_state.dart';
import 'package:flutter_application_clean_arch/core/core.dart';

part 'create_pulsa_event.dart';

class CreatePulsaBloc extends Bloc<CreatePulsaEvent, BaseState> {
  final CreatePulsa createPulsaUsecase;
  CreatePulsaBloc(this.createPulsaUsecase) : super(const InitializedState()) {
    on<CreatePulsaAction>((event, emit) async {
      emit(const LoadingState());
      final result = await createPulsaUsecase.execute(pulsa: event.pulsa);
      result.fold(
        (failure) => emit(ErrorState(message: failure.message)),
        (data) => emit(SuccessState(data: data)),
      );
    });
  }
}
