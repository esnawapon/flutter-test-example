import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_example/simple_note/model/note.dart';
import 'package:flutter_test_example/simple_note/repositories/note_repository.dart';
import 'package:get_it/get_it.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  late final NoteRepository _noteRepo;

  AppCubit({
    NoteRepository? noteRepo,
  }) : super(const AppState()) {
    _noteRepo = noteRepo ?? GetIt.I<NoteRepository>();
  }

  void fetch() async {
    emit(state.copyWith(isLoading: true));
    final response = await _noteRepo.all();
    emit(state.copyWith(
      status: AppStatus.ready,
      notes: response,
      writingTitle: "",
      writingContent: "",
      isLoading: false,
    ));
  }

  void toggleWriting() {
    if (state.status != AppStatus.writing) {
      emit(state.copyWith(status: AppStatus.writing));
    } else {
      emit(state.copyWith(status: AppStatus.ready));
    }
  }

  void saveNote() async {
    emit(state.copyWith(isLoading: true));
    await _noteRepo.update(
      Note(
        title: state.writingTitle,
        content: state.writingContent,
        updated: DateTime.now(),
      ),
    );
    fetch();
  }

  void updateTitle(String? value) {
    emit(state.copyWith(writingTitle: value ?? ""));
  }

  void updateContent(String? value) {
    emit(state.copyWith(writingContent: value ?? ""));
  }

  Future<void> delete(String id) async {
    emit(state.copyWith(isLoading: true));
    await _noteRepo.delete(id);
    fetch();
  }
}
