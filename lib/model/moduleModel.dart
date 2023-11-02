import 'package:becademy/model/materialModel.dart';

class ModuleModel {
  final String id;
  final String course_id;
  final String name;
  final String slug;
  final String created_at;
  final String updated_at;
  final List<MaterialModel>? materials;

  ModuleModel({
    required this.id,
    required this.course_id,
    required this.name,
    required this.slug,
    required this.created_at,
    required this.updated_at,
    this.materials
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) {
    List<MaterialModel> material = [];

    json['materials'].forEach((mat) {
      material.add(MaterialModel.fromJsonModule(mat));
    });

    return ModuleModel(
      id: json['id'],
      course_id: json['course_id'],
      name: json['name'],
      slug: json['slug'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      materials: material,
    );
  }

  factory ModuleModel.fromJsonCourse(Map<String, dynamic> json) {
    return ModuleModel(
      id: json['id'],
      course_id: json['course_id'],
      name: json['name'],
      slug: json['slug'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}