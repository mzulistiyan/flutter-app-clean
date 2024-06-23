part of 'get_pulsa_by_id_bloc.dart';

abstract class GetPulsaByIdEvent extends Equatable {
  const GetPulsaByIdEvent();

  @override
  List<Object> get props => [];
}

class GetPulsaByIdAction extends GetPulsaByIdEvent {
  final String id;

  const GetPulsaByIdAction({required this.id});

  @override
  List<Object> get props => [id];
}
