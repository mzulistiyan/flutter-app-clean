import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_clean_arch/core/base_state/base_state.dart';
import 'package:flutter_application_clean_arch/core/core.dart';

part 'get_local_list_event.dart';

class GetLocalListBloc extends Bloc<GetLocalListEvent, BaseState<List<Pulsa>>> {
  final GetLocalList getLocalListUsecase;
  GetLocalListBloc(
    this.getLocalListUsecase,
  ) : super(const InitializedState()) {
    on<GetLocalListAction>((event, emit) async {
      emit(const LoadingState());
      final result = await getLocalListUsecase.execute();
      result.fold(
        (failure) => emit(ErrorState(message: failure.message)),
        (data) => emit(LoadedState(data: data)),
      );
    });
  }
}
