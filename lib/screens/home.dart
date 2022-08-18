// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field, use_build_context_synchronously, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_new

import 'package:flutter/material.dart';
import 'package:posts/helpers/margin.dart';
import 'package:posts/models/post.dart';
import 'package:posts/providers/posts.dart';
import 'package:posts/widgets/postCard.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  List<Post> posts = [];
  List<Post> foundPosts = [];
  bool _isSearching = false;
  TextEditingController searchPostsController = TextEditingController();
  FocusNode _postFocus = new FocusNode();

  @override
  Future<void> didChangeDependencies() async {
    // Here the Request of the posts provider
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Posts>(context, listen: false).fetchAllPosts();
      posts = Provider.of<Posts>(context, listen: false).posts;
      foundPosts = posts;
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void runFilter(String enteredKeyword) {
    List<Post> results = [];
    if (enteredKeyword.isEmpty) {
      results = posts;
    } else {
      results = posts
          .where((post) =>
              post.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundPosts = results;
    });
  }

  @override
  void dispose() {
    _postFocus.dispose();
    searchPostsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: () {
                runFilter('');
                setState(() {
                  _postFocus.unfocus();
                  searchPostsController.text = '';
                  _isSearching = false;
                });
              },
              child: Column(
                children: [
                  Container(
                    color: Colors.blueGrey,
                    child: Column(
                      children: [
                        Margin.verticalMargin48(),
                        Text(
                          'Post',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Container(
                            height: 35,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: TextField(
                              focusNode: _postFocus,
                              controller: searchPostsController,
                              onChanged: (value) => runFilter(value),
                              onTap: () {
                                FocusScope.of(context).requestFocus(_postFocus);
                                setState(() {
                                  _isSearching = true;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: _isSearching ? null : 'Buscar Post',
                                prefixIcon:
                                    _isSearching ? null : Icon(Icons.search),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Margin.verticalMargin12(),
                      ],
                    ),
                  ),
                  Margin.verticalMargin48(),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        runFilter('');
                        setState(() {
                          _postFocus.unfocus();
                          searchPostsController.text = '';
                          _isSearching = false;
                        });
                      },
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        separatorBuilder: (context, index) => Margin.margin48(),
                        itemCount: foundPosts.length,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: PostCard(
                              id: foundPosts[index].id,
                              title: foundPosts[index].title,
                              body: foundPosts[index].body,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Margin.verticalMargin48(),
                ],
              ),
            ),
    );
  }
}
