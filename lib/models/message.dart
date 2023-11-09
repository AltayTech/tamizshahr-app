import 'package:flutter/foundation.dart';

class Message with ChangeNotifier {
  final String comment_ID;
  final String comment_post_ID;
  final String comment_author;
  final String comment_author_email;
  final String comment_author_url;
  final String comment_author_IP;
  final String comment_date;
  final String comment_date_gmt;
  final String comment_content;
  final String comment_karma;
  final String comment_approved;
  final String comment_agent;
  final String comment_type;
  final String comment_parent;
  final String user_id;
  final String subject;

  Message({
    required this.comment_ID,
    required this.comment_post_ID,
    required this.comment_author,
    required this.comment_author_email,
    required this.comment_author_url,
    required this.comment_author_IP,
    required this.comment_date,
    required this.comment_date_gmt,
    required this.comment_content,
    required this.comment_karma,
    required this.comment_approved,
    required this.comment_agent,
    required this.comment_type,
    required this.comment_parent,
    required this.user_id,
    required this.subject,
  });

  factory Message.fromJson(Map<String, dynamic> parsedJson) {
    return Message(
      comment_ID:
          parsedJson['comment_ID'] != null ? parsedJson['comment_ID'] : '',
      comment_post_ID: parsedJson['comment_post_ID'] != null
          ? parsedJson['comment_post_ID']
          : '',
      comment_author: parsedJson['comment_author'] != null
          ? parsedJson['comment_author']
          : '',
      comment_author_email: parsedJson['comment_author_email'] != null
          ? parsedJson['comment_author_email']
          : '',
      comment_author_url: parsedJson['comment_author_url'] != null
          ? parsedJson['comment_author_url']
          : '',
      comment_author_IP: parsedJson['comment_author_IP'] != null
          ? parsedJson['comment_author_IP']
          : '',
      comment_date:
          parsedJson['comment_date'] != null ? parsedJson['comment_date'] : '',
      comment_date_gmt: parsedJson['comment_date_gmt'] != null
          ? parsedJson['comment_date_gmt']
          : '',
      comment_content: parsedJson['comment_content'] != null
          ? parsedJson['comment_content']
          : '',
      comment_karma: parsedJson['comment_karma'] != null ? parsedJson['v'] : '',
      comment_approved: parsedJson['comment_approved'] != null
          ? parsedJson['comment_approved']
          : '',
      comment_agent: parsedJson['comment_agent'] != null
          ? parsedJson['comment_agent']
          : '',
      comment_type:
          parsedJson['comment_type'] != null ? parsedJson['comment_type'] : '',
      comment_parent: parsedJson['comment_parent'] != null
          ? parsedJson['comment_parent']
          : '',
      user_id: parsedJson['user_id'] != null ? parsedJson['user_id'] : '',
      subject: parsedJson['subject'] != null ? parsedJson['subject'] : '',
    );
  }
}
