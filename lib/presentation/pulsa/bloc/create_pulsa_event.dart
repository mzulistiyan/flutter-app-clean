part of 'create_pulsa_bloc.dart';

abstract class CreatePulsaEvent extends Equatable {
  const CreatePulsaEvent();

  @override
  List<Object> get props => [];
}

class CreatePulsaAction extends CreatePulsaEvent {
  final Pulsa pulsa;

  const CreatePulsaAction({required this.pulsa});

  @override
  List<Object> get props => [pulsa];
}
