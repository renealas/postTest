// ignore_for_file: prefer_final_fields, unused_field, unused_local_variable, avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:posts/models/post.dart';

class Posts with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts {
    return [..._posts];
  }

  Future<void> fetchAllPosts() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);

      List<Post> posties = [];

      for (final post in extractedData) {
        posties.add(
          Post(
            id: post['id'],
            userId: post['userId'],
            title: post['title'],
            body: post['body'],
          ),
        );
      }
      _posts = posties;
      notifyListeners();
    } catch (e) {
      print('Error fetching all posts $e');
    }
  }
}
