// ignore_for_file: prefer_final_fields, unused_field, unused_local_variable, avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:posts/models/comment.dart';

class Comments with ChangeNotifier {
  List<Comment> _comments = [];

  List<Comment> get comments {
    return [..._comments];
  }

  Future<void> fetchCommentsForPost({required int postId}) async {
    final url = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/$postId/comments');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);

      List<Comment> comenties = [];

      for (final comment in extractedData) {
        comenties.add(
          Comment(
            id: comment['id'],
            postId: comment['postId'],
            name: comment['name'],
            email: comment['email'],
            body: comment['body'],
          ),
        );
      }
      _comments = comenties;
      notifyListeners();
    } catch (e) {
      print('Error fetching all comments $e');
    }
  }
}
