import 'package:flutter_test_example/simple_note/bloc/app_cubit.dart';
import 'package:flutter_test_example/simple_note/repositories/note_repository.dart';
import 'package:flutter_test_example/simple_note/repositories/local_note_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:localstorage/localstorage.dart';

Future<void> init() async {
  await initLocalStorage();
  GetIt.I.reset(dispose: false);
  GetIt.I.registerFactory<AppCubit>(() => AppCubit());
  GetIt.I.registerLazySingleton<NoteRepository>(() => LocalNoteRepository());
}
