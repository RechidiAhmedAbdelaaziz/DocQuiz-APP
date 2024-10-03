import 'package:equatable/equatable.dart';

class UpdatesModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  const UpdatesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  String get formattedDate =>
      '${date.day}/${date.month}/${date.year}';

  factory UpdatesModel.fromJson(Map<String, dynamic> json) {
    return UpdatesModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }

  UpdatesModel copyWith({
    String? title,
    String? description,
    DateTime? date,
  }) {
    return UpdatesModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [id];
}
