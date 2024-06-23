import 'package:flutter/material.dart';
import 'package:flutter_application_clean_arch/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'common/common.dart';
import 'injection.dart' as di;
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<GetListPulsaBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<GetPulsaByIdBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<CreatePulsaBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<UpdatePulsaBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<DeletePulsaBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<GetLocalListBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<InsertLocalListBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Inter',
          useMaterial3: true,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
