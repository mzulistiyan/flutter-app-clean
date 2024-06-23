part of 'delete_pulsa_bloc.dart';

abstract class DeletePulsaEvent extends Equatable {
  const DeletePulsaEvent();

  @override
  List<Object> get props => [];
}

class DeletePulsaAction extends DeletePulsaEvent {
  final String id;

  const DeletePulsaAction({required this.id});

  @override
  List<Object> get props => [id];
}
