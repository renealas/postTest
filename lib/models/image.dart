import 'package:flutter/cupertino.dart';

class PostImage with ChangeNotifier {
  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnail;

  PostImage({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnail,
  });
}
