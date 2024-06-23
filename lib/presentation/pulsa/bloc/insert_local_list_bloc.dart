import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';

part 'insert_local_list_event.dart';

class InsertLocalListBloc extends Bloc<InsertLocalListEvent, BaseState> {
  final InsertLocalList insertLocalListUsecase;
  InsertLocalListBloc(
    this.insertLocalListUsecase,
  ) : super(const InitializedState()) {
    on<InsertLocalListAction>((event, emit) async {
      emit(const LoadingState());
      final result = await insertLocalListUsecase.execute(pulsa: event.listPulsa);
      result.fold(
        (failure) => emit(ErrorState(message: failure.message)),
        (data) => emit(SuccessState(data: data)),
      );
    });
  }
}
