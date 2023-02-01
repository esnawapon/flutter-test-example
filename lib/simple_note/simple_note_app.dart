import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_example/simple_note/bloc/app_cubit.dart';
import 'package:flutter_test_example/simple_note/widgets/landing_page.dart';
import 'package:get_it/get_it.dart';

class SimpleNoteApp extends StatelessWidget {
  const SimpleNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: const Key("simple_note_app"),
      title: "Simple Note",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: BlocProvider(
        create: (_) => GetIt.I<AppCubit>()..fetch(),
        child: const LandingPage(),
      ),
    );
  }
}
