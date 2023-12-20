import 'package:becademy/model/accountModel.dart';

class ForumModel{
  final String id;
  final String account_id;
  final String course_id;
  final String message;
  final String created_at;
  final String updated_at;
  final AccountModel account;

  ForumModel({
    required this.id,
    required this.account_id,
    required this.course_id,
    required this.message,
    required this.created_at,
    required this.updated_at,
    required this.account
  });

  factory ForumModel.fromJson(Map<String, dynamic> json) {
    return ForumModel(
      id: json['id'],
      account_id: json['account_id'],
      course_id: json['course_id'],
      message: json['message'],
      account: AccountModel.fromJson(json['account']),
      created_at: json['created_at'],
      updated_at: json['updated_at']
    );
  }
}