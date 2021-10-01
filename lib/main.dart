import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash_assignment_movies/src/configurations/routes/app_routes.dart';
import 'package:slash_assignment_movies/src/core/utils/constants.dart';
import 'package:slash_assignment_movies/src/injector.dart';
import 'package:slash_assignment_movies/src/presentation/blocs/movies_bloc.dart';

import 'src/configurations/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoviesBloc>(
      create: (_) => injector()..add(const GetMoviesEvent(fetchMore: false)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kMaterialAppTitle,
        initialRoute: AppRoutes.initialRoute(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        theme: AppTheme.light,
      ),
    );
  }
}
