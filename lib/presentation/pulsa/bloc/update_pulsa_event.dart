part of 'update_pulsa_bloc.dart';

abstract class UpdatePulsaEvent extends Equatable {
  const UpdatePulsaEvent();

  @override
  List<Object> get props => [];
}

class UpdatePulsaAction extends UpdatePulsaEvent {
  final Pulsa pulsa;
  final String id;

  const UpdatePulsaAction({required this.pulsa, required this.id});

  @override
  List<Object> get props => [pulsa];
}
