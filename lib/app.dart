import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reloj_proyecto/controllers/clockCubit/clock_cubit.dart';
import 'package:reloj_proyecto/controllers/multipleClocksCubit/multi_clocks_cubit.dart';
import 'package:reloj_proyecto/controllers/routes/routers.dart';
import 'package:reloj_proyecto/screens/stop_watch_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final routerConfig = RouterController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClockCubit(),
        ),
        BlocProvider(
          create: (context) => MultiClocksCubit(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: routerConfig.getRoutesConfig(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
