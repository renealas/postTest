// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously, avoid_print, unused_field, avoid_unnecessary_containers, prefer_final_fields, unnecessary_new

import 'package:flutter/material.dart';
import 'package:posts/helpers/margin.dart';
import 'package:posts/models/comment.dart';
import 'package:posts/providers/comments.dart';
import 'package:posts/widgets/commentCard.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final int id;

  CommentsScreen({
    required this.id,
  });

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  List<Comment> comments = [];
  List<Comment> foundCommets = [];
  bool _isSearching = false;
  TextEditingController searchCommentsController = TextEditingController();
  FocusNode _commentFocus = new FocusNode();

  @override
  Future<void> didChangeDependencies() async {
    // Here the Request of the posts provider
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Comments>(context, listen: false)
          .fetchCommentsForPost(postId: widget.id);
      comments = Provider.of<Comments>(context, listen: false).comments;
      foundCommets = comments;
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void runFilter(String enteredKeyword) {
    List<Comment> results = [];
    if (enteredKeyword.isEmpty) {
      results = comments;
    } else {
      results = comments
          .where((coment) =>
              coment.body.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundCommets = results;
    });
  }

  @override
  void dispose() {
    _commentFocus.dispose();
    searchCommentsController.dispose();
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
                  _commentFocus.unfocus();
                  searchCommentsController.text = '';
                  _isSearching = false;
                });
              },
              child: Column(
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
                                'Comments',
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
                              focusNode: _commentFocus,
                              controller: searchCommentsController,
                              onChanged: (value) => runFilter(value),
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(_commentFocus);
                                setState(() {
                                  _isSearching = true;
                                });
                              },
                              decoration: InputDecoration(
                                labelText:
                                    _isSearching ? null : 'Buscar Comentarios',
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
                  Margin.verticalMargin24(),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        runFilter('');
                        setState(() {
                          _commentFocus.unfocus();
                          searchCommentsController.text = '';
                          _isSearching = false;
                        });
                      },
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        separatorBuilder: (context, index) => Margin.margin36(),
                        itemCount: comments.length,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: CommentCard(
                              comment: comments[index].body,
                              email: comments[index].email,
                              toRight: index.floor().isOdd,
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
