import 'package:becademy/model/categoryModel.dart';
import 'package:becademy/model/moduleModel.dart';

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
  String? payment_id;
  String? payment_method;
  String? payment_verified;
  String? payment_created_at;
  String? payment_updated_at;
  String? category_id;
  CategoryModel? category;
  List<ModuleModel>? modules;

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
    this.payment_id,
    this.payment_method,
    this.payment_verified,
    this.payment_created_at,
    this.payment_updated_at,
    this.category_id,
    this.category,
    this.modules,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    List<ModuleModel> module = [];

    json['modules'].forEach((mod){
      module.add(ModuleModel.fromJsonCourse(mod));
    });

    return CourseModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      desc: json['desc'],
      price: json['price'],
      min_processor: json['min_processor'],
      min_storage: json['min_storage'],
      min_ram: json['min_ram'],
      is_active: json['is_active'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      category: CategoryModel.fromJson(json['category']),
      category_id: json['category']['id'],
      modules: module,
    );
  }

  factory CourseModel.fromJsonMyCourse(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      desc: json['desc'],
      price: json['price'],
      min_processor: json['min_processor'],
      min_storage: json['min_storage'],
      min_ram: json['min_ram'],
      is_active: json['is_active'],
      payment_id: json['payment_id'],
      payment_method: json['payment_method'],
      payment_verified: json['payment_verified'],
      payment_created_at: json['payment_created_at'] ,
      payment_updated_at: json['payment_updated_at'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      category_id: json['category_id'],
    );
  }
}