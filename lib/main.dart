import 'package:animation_widgets/animated_size_image.dart';
import 'package:animation_widgets/animation_any_hero.dart';
import 'package:animation_widgets/hero_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HeroImageView(),
    );
  }
}
