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
    this.comment_ID,
    this.comment_post_ID,
    this.comment_author,
    this.comment_author_email,
    this.comment_author_url,
    this.comment_author_IP,
    this.comment_date,
    this.comment_date_gmt,
    this.comment_content,
    this.comment_karma,
    this.comment_approved,
    this.comment_agent,
    this.comment_type,
    this.comment_parent,
    this.user_id,
    this.subject,
  });

  factory Message.fromJson(Map<String, dynamic> parsedJson) {
    return Message(
      comment_ID: parsedJson['comment_ID'],
      comment_post_ID: parsedJson['comment_post_ID'],
      comment_author: parsedJson['comment_author'],
      comment_author_email: parsedJson['comment_author_email'],
      comment_author_url: parsedJson['comment_author_url'],
      comment_author_IP: parsedJson['comment_author_IP'],
      comment_date: parsedJson['comment_date'],
      comment_date_gmt: parsedJson['comment_date_gmt'],
      comment_content: parsedJson['comment_content'],
      comment_karma: parsedJson['comment_karma'],
      comment_approved: parsedJson['comment_approved'],
      comment_agent: parsedJson['comment_agent'],
      comment_type: parsedJson['comment_type'],
      comment_parent: parsedJson['comment_parent'],
      user_id: parsedJson['user_id'],
      subject: parsedJson['subject'],
    );
  }
}
