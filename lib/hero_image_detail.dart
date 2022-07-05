import 'package:flutter/material.dart';

class HeroImageDetail extends StatefulWidget {
  const HeroImageDetail({Key? key}) : super(key: key);

  @override
  State<HeroImageDetail> createState() => _HeroImageDetailState();
}

class _HeroImageDetailState extends State<HeroImageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            child: Image.network(
              "https://wallpaperaccess.com/full/51364.jpg",
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Back"),
          ),
        ],
      ),
    );
  }
}
