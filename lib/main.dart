import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Screens
import 'screens/home.dart';

//Providers
import 'providers/posts.dart';
import 'providers/comments.dart';
import 'providers/images.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Posts(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Comments(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PostImages(),
        ),
      ],
      child: MaterialApp(
        title: 'Posts',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
