class CategoryModel {
  final String id;
  final String name;
  final String slug;
  final String icon;
  final String color;
  final String created_at;
  final String updated_at;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.color,
    required this.created_at,
    required this.updated_at
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      icon: json['icon'],
      color: json['color'],
      created_at: json['created_at'],
      updated_at: json['updated_at']
    );
  }
}