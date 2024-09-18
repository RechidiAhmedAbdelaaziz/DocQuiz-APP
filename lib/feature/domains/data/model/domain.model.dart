import 'package:equatable/equatable.dart';

abstract class NamedModel extends Equatable {
  final String id;
  final String name;

  const NamedModel(this.id, this.name);

  @override
  List<Object> get props => [id, name];
}

class DomainModel extends NamedModel {
  DomainModel({
    required String id,
    required String name,
  }) : super(id, name);

  factory DomainModel.fromJson(Map<String, dynamic> json) {
    return DomainModel(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class LevelModel extends NamedModel {
  LevelModel({
    required String id,
    required String name,
  }) : super(id, name);

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class MajorModel extends NamedModel {
  MajorModel({
    required String id,
    required String name,
  }) : super(id, name);

  factory MajorModel.fromJson(Map<String, dynamic> json) {
    return MajorModel(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class CourseModel extends NamedModel {
  CourseModel({
    required String id,
    required String name,
  }) : super(id, name);

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class SourceModel extends NamedModel {
  SourceModel({
    required String id,
    required String name,
  }) : super(id, name);

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['_id'],
      name: json['title'],
    );
  }
}
