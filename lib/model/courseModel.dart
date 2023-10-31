import 'package:becademy/model/categoryModel.dart';

class CourseModel {
  final String id;
  final String name;
  final String slug;
  final String desc;
  final int price;
  final String min_processor;
  final int min_storage;
  final int min_ram;
  final int is_active;
  final String created_at;
  final String updated_at;
  final CategoryModel category;

  CourseModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.desc,
    required this.price,
    required this.min_processor,
    required this.min_storage,
    required this.min_ram,
    required this.is_active,
    required this.created_at,
    required this.updated_at,
    required this.category,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      desc: json['desc'],
      price: int.parse(json['price']),
      min_processor: json['min_processor'],
      min_storage: int.parse(json['min_storage']),
      min_ram: int.parse(json['min_ram']),
      is_active: int.parse(json['is_active']),
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      category: CategoryModel.fromJson(json['category']),
      // category: CategoryModel(
      //   id: json['category']['id'],
      //   name: json['category']['name'],
      //   slug: json['category']['slug'],
      //   icon: json['category']['icon'],
      //   color: json['category']['color'],
      //   created_at: json['category']['created_at'],
      //   updated_at: json['category']['updated_at']
      // ),
    );
  }
}