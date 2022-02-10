import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fluttix/bloc/blocs.dart';
import 'package:my_fluttix/services/services.dart';
import 'package:my_fluttix/ui/pages/pages.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageBloc()),
          BlocProvider(create: (_) => UserBloc()),
          BlocProvider(create: (_) => ThemeBloc()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (_, themeState) {
            return MaterialApp(
              theme: themeState.themeData,
              debugShowCheckedModeBanner: false,
              home: const Wrapper(),
            );
          },
        ),
      ),
    );
  }
}
