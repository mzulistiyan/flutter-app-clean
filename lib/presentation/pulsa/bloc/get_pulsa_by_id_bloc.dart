import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_clean_arch/core/core.dart';

part 'get_pulsa_by_id_event.dart';

class GetPulsaByIdBloc extends Bloc<GetPulsaByIdEvent, BaseState<Pulsa>> {
  final GetPulsaById getPulsaByIdUsecase;

  GetPulsaByIdBloc(this.getPulsaByIdUsecase) : super(const InitializedState()) {
    on<GetPulsaByIdAction>((event, emit) async {
      emit(const LoadingState());
      final result = await getPulsaByIdUsecase.execute(id: event.id);
      result.fold(
        (failure) => emit(ErrorState(message: failure.message)),
        (data) => emit(SuccessState(data: data)),
      );
    });
  }
}
