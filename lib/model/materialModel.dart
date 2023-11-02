class MaterialModel {
  final String id;
  final String module_id;
  final String name;
  final String slug;
  final String? video;
  final String? body;
  final String? created_at;
  final String? updated_at;

  MaterialModel({
    required this.id,
    required this.module_id,
    required this.name,
    required this.slug,
    this.video,
    this.body,
    this.created_at,
    this.updated_at
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['id'],
      module_id: json['module_id'],
      name: json['name'],
      slug: json['slug'],
      video: json['video'],
      body: json['body'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  factory MaterialModel.fromJsonModule(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['id'],
      module_id: json['module_id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}