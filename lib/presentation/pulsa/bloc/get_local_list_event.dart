part of 'get_local_list_bloc.dart';

abstract class GetLocalListEvent extends Equatable {
  const GetLocalListEvent();

  @override
  List<Object> get props => [];
}

class GetLocalListAction extends GetLocalListEvent {}
