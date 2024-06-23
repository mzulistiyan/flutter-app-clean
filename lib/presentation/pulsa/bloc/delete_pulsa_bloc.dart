import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_clean_arch/core/base_state/base_state.dart';
import 'package:flutter_application_clean_arch/core/core.dart';

part 'delete_pulsa_event.dart';

class DeletePulsaBloc extends Bloc<DeletePulsaEvent, BaseState> {
  final DeletePulsa deletePulsaUsecase;
  DeletePulsaBloc(this.deletePulsaUsecase) : super(const InitializedState()) {
    on<DeletePulsaAction>((event, emit) async {
      emit(const LoadingState());
      final result = await deletePulsaUsecase.execute(id: event.id);
      result.fold(
        (failure) => emit(ErrorState(message: failure.message)),
        (data) => emit(SuccessState(data: data)),
      );
    });
  }
}
