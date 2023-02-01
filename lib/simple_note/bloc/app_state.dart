part of 'app_cubit.dart';

enum AppStatus {
  init,
  ready,
  writing,
}

class AppState extends Equatable {
  final AppStatus status;
  final List<Note> notes;
  final String writingTitle;
  final String writingContent;
  final bool isLoading;

  const AppState({
    this.status = AppStatus.init,
    this.notes = const [],
    this.writingTitle = "",
    this.writingContent = "",
    this.isLoading = false,
  });

  AppState copyWith({AppStatus? status, List<Note>? notes, String? writingTitle, String? writingContent, bool? isLoading}) {
    return AppState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      writingTitle: writingTitle ?? this.writingTitle,
      writingContent: writingContent ?? this.writingContent,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        status,
        notes,
        writingTitle,
        writingContent,
        isLoading,
      ];
}
