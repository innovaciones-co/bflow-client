import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/theme/text_theme.dart';
import 'package:bflow_client/src/core/theme/theme.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/jobs_bloc.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/login_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/core/routes/router.dart';
import 'src/core/routes/routes.dart';

class BflowApp extends StatelessWidget {
  const BflowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (_) => DependencyInjection.sl()),
        BlocProvider<JobsBloc>(
            create: (_) => DependencyInjection.sl()..add(GetJobsEvent())),
        BlocProvider<LoginCubit>(create: (_) => DependencyInjection.sl()),
      ],
      child: MaterialApp.router(
        theme: MaterialTheme(textTheme(context)).light(),
        darkTheme: MaterialTheme(textTheme(context)).dark(),
        debugShowCheckedModeBanner: false,
        routeInformationParser: appRouter.routeInformationParser,
        routeInformationProvider: appRouter.routeInformationProvider,
        routerDelegate: appRouter.routerDelegate,
      ),
    );
  }
}
