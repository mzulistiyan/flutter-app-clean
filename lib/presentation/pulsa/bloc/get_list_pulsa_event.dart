part of 'get_list_pulsa_bloc.dart';

abstract class GetListPulsaEvent extends Equatable {
  const GetListPulsaEvent();

  @override
  List<Object> get props => [];
}

class GetListPulsaAction extends GetListPulsaEvent {
  final String? search;

  const GetListPulsaAction({this.search});

  @override
  List<Object> get props => [search ?? ''];
}
