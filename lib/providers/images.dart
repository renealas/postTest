// ignore_for_file: prefer_final_fields, unused_field, unused_local_variable, avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:posts/models/image.dart';

class PostImages with ChangeNotifier {
  List<PostImage> _images = [];

  List<PostImage> get images {
    return [..._images];
  }

  Future<void> fetchImagesForPost({required int albumId}) async {
    final url =
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$albumId/photos');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);

      List<PostImage> imagies = [];

      for (final image in extractedData) {
        imagies.add(
          PostImage(
            id: image['id'],
            albumId: image['albumId'],
            title: image['title'],
            url: image['url'],
            thumbnail: image['thumbnailUrl'],
          ),
        );
      }
      _images = imagies;
      notifyListeners();
    } catch (e) {
      print('Error fetching all images $e');
    }
  }
}
