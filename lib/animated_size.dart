import 'package:flutter/material.dart';

class AnimatedSizeWidget extends StatefulWidget {
  const AnimatedSizeWidget({Key? key}) : super(key: key);

  @override
  State<AnimatedSizeWidget> createState() => _AnimatedSizeWidgetState();
}

class _AnimatedSizeWidgetState extends State<AnimatedSizeWidget> {
  double selected = 200;

  void updateSize() {
    setState(() {
      if (selected == 200) {
        selected = 300;
      } else {
        selected = 200;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => updateSize(),
              child: const Text("animate"),
            ),
            AnimatedContainer(
              width: selected,
              height: selected,
              decoration: BoxDecoration(
                  color: selected == 200 ? Colors.red : Colors.blue,
                  borderRadius: BorderRadius.circular(selected == 200 ? 0 : 12)),
              alignment: selected == 200 ? Alignment.center : AlignmentDirectional.topCenter,
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              child: const FlutterLogo(size: 75),
            ),
          ],
        ),
      ),
    );
  }
}
