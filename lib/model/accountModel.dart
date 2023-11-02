class AccountModel {
  final String id;
  final String name;
  final String email;
  final String picture;
  final String gender;
  final String school;
  final String degree;
  final String field_of_study;
  final String? title;
  final String? company;
  final String? location;
  final String? withdraw_method;
  final String? withdraw_number;
  final String? email_verified_at;

  AccountModel({
    required this.id,
    required this.name,
    required this.email,
    required this.picture,
    required this.gender,
    required this.school,
    required this.degree,
    required this.field_of_study,
    this.title,
    this.company,
    this.location,
    this.withdraw_method,
    this.withdraw_number,
    this.email_verified_at
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      picture: json['picture'],
      gender: json['gender'],
      school: json['school'],
      degree: json['degree'],
      field_of_study: json['field_of_study'],
      title: json['title'],
      company: json['company'],
      location: json['location'],
      email_verified_at: json['email_verified_at'],
      withdraw_method: json['withdraw_method'],
      withdraw_number: json['withdraw_number'],
    );
  }

}