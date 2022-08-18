// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously, avoid_print, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:posts/helpers/margin.dart';
import 'package:posts/models/image.dart';
import 'package:posts/providers/images.dart';
import 'package:posts/widgets/imagePost.dart';
import 'package:provider/provider.dart';

class ImagesScreen extends StatefulWidget {
  final int id;

  ImagesScreen({
    required this.id,
  });

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  List<PostImage> images = [];

  @override
  Future<void> didChangeDependencies() async {
    // Here the Request of the posts provider
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<PostImages>(context, listen: false)
          .fetchImagesForPost(albumId: widget.id);
      images = Provider.of<PostImages>(context, listen: false).images;
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  color: Colors.blueGrey,
                  child: Column(
                    children: [
                      Margin.verticalMargin36(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Album',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Container(),
                          ],
                        ),
                      ),
                      Margin.verticalMargin24(),
                    ],
                  ),
                ),
                Margin.verticalMargin24(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(images.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                            bottom: 25,
                          ),
                          child: ImagePostCard(
                            url: images[index].thumbnail,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Margin.verticalMargin48(),
              ],
            ),
    );
  }
}
