import 'package:flutter_application_clean_arch/presentation/presentation.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import '../../../core/core.dart';
import 'package:hive_flutter/hive_flutter.dart';

final locator = GetIt.instance;

/// Submission 1108243 Fix
/// Make the init asynchronous
Future<void> init() async {
  // SSL pinning
  var logger = Logger();
  Get.put<Logger>(logger); // Memasukkan logger ke dalam container Get

  final DioClient ioClient = DioClient(
    logger: Get.find<Logger>(), // Memastikan Logger diinject ke DioClient
  );

  //Init Hive
  await Hive.initFlutter();
  Hive.registerAdapter(PulsaLocalModelAdapter());
  Hive.openBox<PulsaLocalModel>('pulsa');
  // Pulsa external
  Get.put<DioClient>(ioClient);

  // Pulsa data source
  Get.put<PulsaRemoteDataSource>(PulsaRemoteDataSourceImpl(
    dioClient: Get.find(),
  ));
  Get.put<PulsaLocalDataSource>(PulsaLocalDataSourceImpl());

  // Pulsa repository
  Get.put<PulsaRepository>(PulsaRepositoryImpl(
    remoteDataSource: Get.find(),
    localDataSource: Get.find(),
  ));

  // Pulsa usecases
  Get.put(GetListPulsa(Get.find()));
  Get.put(GetPulsaById(Get.find()));
  Get.put(CreatePulsa(Get.find()));
  Get.put(UpdatePulsa(Get.find()));
  Get.put(DeletePulsa(Get.find()));
  Get.put(GetLocalList(Get.find()));
  Get.put(InsertLocalList(Get.find()));

  // bloc
  locator.registerFactory(() => GetListPulsaBloc(locator()));
  locator.registerFactory(() => GetPulsaByIdBloc(locator()));
  locator.registerFactory(() => CreatePulsaBloc(locator()));
  locator.registerFactory(() => UpdatePulsaBloc(locator()));
  locator.registerFactory(() => DeletePulsaBloc(locator()));
  locator.registerFactory(() => GetLocalListBloc(locator()));
  locator.registerFactory(() => InsertLocalListBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetListPulsa(locator()));
  locator.registerLazySingleton(() => GetPulsaById(locator()));
  locator.registerLazySingleton(() => CreatePulsa(locator()));
  locator.registerLazySingleton(() => UpdatePulsa(locator()));
  locator.registerLazySingleton(() => DeletePulsa(locator()));
  locator.registerLazySingleton(() => GetLocalList(locator()));
  locator.registerLazySingleton(() => InsertLocalList(locator()));

  // repository
  locator.registerLazySingleton<PulsaRepository>(
    () => PulsaRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<PulsaRemoteDataSource>(() => PulsaRemoteDataSourceImpl(dioClient: Get.find()));
  locator.registerLazySingleton<PulsaLocalDataSource>(() => PulsaLocalDataSourceImpl());

  // helper

  // network info

  // external
  locator.registerLazySingleton(() => ioClient);
}
