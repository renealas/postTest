// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_print, prefer_const_constructors_in_immutables, file_names

import 'package:flutter/material.dart';
import 'package:posts/helpers/margin.dart';
import 'package:posts/screens/comments.dart';
import 'package:posts/screens/images.dart';

class PostCard extends StatelessWidget {
  final String title;
  final String body;
  final int id;

  PostCard({
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(
          color: Colors.grey[300]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF061f48).withOpacity(0.05),
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 7.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: screenWidth / 1.8,
                      child: Text(
                        body,
                        maxLines: 3,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration: Duration(seconds: 0),
                                pageBuilder: (_, __, ___) =>
                                    ImagesScreen(id: id),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.perm_media_outlined,
                          ),
                        ),
                        Margin.margin36(),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration: Duration(seconds: 0),
                                pageBuilder: (_, __, ___) =>
                                    CommentsScreen(id: id),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.chat_bubble_outline,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
