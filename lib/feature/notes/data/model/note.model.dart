class NoteModel {
  final String id;
  final List<_Note> notes;

  NoteModel({
    required this.id,
    required this.notes,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['_id'],
      notes: json['notes'] != null
          ? List<_Note>.from(
              json['notes'].map((x) => _Note.fromJson(x)))
          : [],
    );
  }
}

class _Note {
  final String? note;
  final int? index;

  _Note({
    required this.note,
    required this.index,
  });

  factory _Note.fromJson(Map<String, dynamic> json) {
    return _Note(
      note: json['note'] as String?,
      index: json['index'] as int?,
    );
  }
}
