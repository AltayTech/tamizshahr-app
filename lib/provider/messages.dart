import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/message.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'urls.dart';

class Messages with ChangeNotifier {
  List<Message> _allMessages = [];
  List<Message> _allMessagesDetail = [];
  String _token;

  List<Message> get allMessages => _allMessages;

  List<Message> get allMessagesDetail => _allMessagesDetail;

  Future<void> createMessage(String subject, String content,
      String comment_post_ID, String parent_id, bool isLogin) async {
    print('createMessage');
    try {
      if (isLogin) {
        final prefs = await SharedPreferences.getInstance();

        _token = prefs.getString('token');

        final url = comment_post_ID == '0'
            ? Urls.rootUrl +
                Urls.messageEndPoint +
                '?subject=$subject&content=$content'
            : Urls.rootUrl +
                Urls.messageEndPoint +
                '?subject=$subject&content=$content&comment_post_ID=$comment_post_ID&parent_id=$parent_id';

        final response = await post(url, headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });

        final extractedData = json.decode(response.body);

        print(extractedData.toString());
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }

  Future<void> getMessages(String commentPostId, bool isLogin) async {
    print('getMessages');
    print(commentPostId);

    try {
      if (isLogin) {
        final prefs = await SharedPreferences.getInstance();

        _token = prefs.getString('token');

        final url = commentPostId == '0'
            ? Urls.rootUrl + Urls.messageEndPoint
            : Urls.rootUrl +
                Urls.messageEndPoint +
                '?comment_post_ID=$commentPostId';
        print(url);

        final response = await get(url, headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });

        final extractedData = json.decode(response.body) as List<dynamic>;
        print(extractedData);

        List<Message> messageList =
            extractedData.map((i) => Message.fromJson(i)).toList();
        print(extractedData.toString());

        commentPostId == '0'
            ? _allMessages = messageList
            : _allMessagesDetail = messageList;
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }
}
