import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_clean_arch/core/base_state/base_state.dart';
import 'package:flutter_application_clean_arch/core/core.dart';

part 'get_list_pulsa_event.dart';

class GetListPulsaBloc extends Bloc<GetListPulsaEvent, BaseState<List<Pulsa>>> {
  final GetListPulsa getListPulsaUsecase;
  GetListPulsaBloc(this.getListPulsaUsecase) : super(const InitializedState()) {
    on<GetListPulsaAction>((event, emit) async {
      emit(const LoadingState());
      final result = await getListPulsaUsecase.execute(search: event.search);
      result.fold(
        (failure) => emit(ErrorState(message: failure.message)),
        (data) => emit(LoadedState(data: data)),
      );
    });
  }
}
