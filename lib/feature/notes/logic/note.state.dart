part of 'note.cubit.dart';

class NoteState extends ErrorState {
  final NoteModel? note;

  NoteState({
    this.note,
    String? error,
  }) : super(error);

  factory NoteState.initial() => NoteState();

  NoteState _fetchNote(NoteModel note) => _copyWith(note: note);

  NoteState _errorOccured(String error) => _copyWith(error: error);

  NoteState _copyWith({
    NoteModel? note,
    String? error,
  }) {
    return NoteState(
      note: note ?? this.note,
      error: error,
    );
  }
}
