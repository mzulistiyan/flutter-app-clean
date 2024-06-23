part of 'insert_local_list_bloc.dart';

abstract class InsertLocalListEvent extends Equatable {
  const InsertLocalListEvent();

  @override
  List<Object> get props => [];
}

class InsertLocalListAction extends InsertLocalListEvent {
  final List<Pulsa> listPulsa;

  InsertLocalListAction({required this.listPulsa});

  @override
  List<Object> get props => [listPulsa];
}
