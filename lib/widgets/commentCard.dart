// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace, avoid_print, file_names

import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String comment;
  final String email;
  final bool toRight;

  CommentCard({
    required this.comment,
    required this.email,
    required this.toRight,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        // Comment Card
        Row(
          mainAxisAlignment:
              toRight ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(
                  color: Colors.black26,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      color: Colors.greenAccent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: screenWidth / 1.8,
                              child: Text(
                                comment,
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        //email
        Padding(
          padding: const EdgeInsets.only(
            top: 5,
            right: 5,
            left: 5,
          ),
          child: Row(
            mainAxisAlignment:
                toRight ? MainAxisAlignment.end : MainAxisAlignment.center,
            children: [
              Text(
                email,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
