import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_application_clean_arch/core/core.dart';
import 'package:flutter_application_clean_arch/presentation/presentation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../data_dummy/data_dummy.dart';

class MockGetListHistoryPulsa extends Mock implements GetListPulsa {}

void main() {
  late GetListPulsa usecase;
  late GetListPulsaBloc bloc;

  setUp(() {
    usecase = MockGetListHistoryPulsa();
    bloc = GetListPulsaBloc(usecase);
  });

  group('ListPulsaHistoryBloc', () {
    test('initial state should be InitializedState.', () {
      expect(bloc.state, const InitializedState<List<Pulsa>>());
    });

    blocTest<GetListPulsaBloc, BaseState<List<Pulsa>>>(
      'emits [LoadingState<List<Pulsa>>, LoadedState<List<Pulsa>>] when GetListPulsaAction is added.',
      build: () {
        when(() => usecase.execute()).thenAnswer((_) async {
          print('Mock execute called');
          return Right([listHistoryPulsa]);
        });
        return bloc;
      },
      act: (bloc) => bloc.add(const GetListPulsaAction()),
      expect: () => <BaseState<List<Pulsa>>>[
        const LoadingState<List<Pulsa>>(),
        LoadedState<List<Pulsa>>(data: [listHistoryPulsa]),
      ],
      verify: (bloc) {
        verify(() => usecase.execute()).called(1);
        print('Verify executed');
      },
    );
  });
}
