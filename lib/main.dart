import 'package:assignment_8/core/Navigation/routes/routes.dart';
import 'package:assignment_8/core/di/di.dart';
import 'package:assignment_8/domain/usecase/get_data_usecase.dart';
import 'package:assignment_8/presentation/features/home_feature/bloc/home_bloc.dart';

import 'package:assignment_8/presentation/features/zip_details/bloc/zip_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final appRouter = AppRouter();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Di().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()),

        BlocProvider(
          create: (context) => ZipBloc(di<GetDataUsecase>()),
          child: Container(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
        title: 'Flutter Demo',

        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
