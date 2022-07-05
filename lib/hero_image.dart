import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class HeroImageView extends StatefulWidget {
  const HeroImageView({Key? key}) : super(key: key);

  @override
  State<HeroImageView> createState() => _HeroImageViewState();
}

class _HeroImageViewState extends State<HeroImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(context, SharedAxisPageTransitionsBuilder(transitionType: TransactionType))
        },
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Image.network(
            "https://wallpaperaccess.com/full/51364.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
