import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ImageItemModel {
  String url;
  ImageItemModel(this.url);
}

class AnimatedSizeImage extends StatefulWidget {
  const AnimatedSizeImage({Key? key}) : super(key: key);

  @override
  State<AnimatedSizeImage> createState() => _AnimatedSizeImageState();
}

class _AnimatedSizeImageState extends State<AnimatedSizeImage> {
  final ItemScrollController _scrollController = ItemScrollController();
  final List<ImageItemModel> _imageList = [
    ImageItemModel("https://wallpaperaccess.com/full/1682077.png"),
    ImageItemModel("https://i.pinimg.com/736x/e9/b1/d2/e9b1d2fa679e10e73d2c111ad879f5e6--nature-wallpaper-mobile"
        "-wallpaper.jpg"),
    ImageItemModel("https://www.enjpg.com/img/2020/4k-mobile-3-scaled.jpg"),
    ImageItemModel("https://wallpaper.dog/large/20492767.jpg"),
    ImageItemModel("https://www.teahub.io/photos/full/14-143293_beautiful-wallpapers-for-phone.jpg"),
    ImageItemModel("https://www.enjpg.com/img/2020/4k-mobile-3-scaled.jpg"),
    ImageItemModel(
        "https://images.hdqwalls.com/download/crystal-bal-transparent-nature-background-reflection-5k-m1-750x1334.jpg"),
    ImageItemModel("https://i.pinimg.com/originals/81/b3/da/81b3da332e71a7a5a4e13aad03b13da6.jpg"),
    ImageItemModel("https://www.enjpg.com/img/2020/4k-mobile-3-scaled.jpg"),
    ImageItemModel("https://wallpaperaccess.com/full/1682077.png"),
    ImageItemModel("https://s.itl.cat/pngfile/s/13-132890_nb90-sky-sunset-sea-nature-night-cool-view.jpg"),
    ImageItemModel(
        "https://4.bp.blogspot.com/-kUA-LnUYyNg/XGHkafN7n5I/AAAAAAAACdY/7CZ77Y6qTxcL-0YCkejml7nDGedsh3ARwCKgBGAs/w1080-h1920-c/seascape-bay-sunset-sea-nature-sky-clouds-8K-156.jpg"),
  ];
  late String imageUrl = _imageList[mIndex].url;
  int mIndex = 0;
  int nextIndex = 1;
  double height = 0;
  bool isOpen = false;
  Alignment alignment = Alignment.centerLeft;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        isOpen = true;
        height = MediaQuery.of(context).size.width;
      });
    });
  }

  void updateImageUrl(int index, bool nextIsRight) {
    setState(() {
      alignment = nextIsRight ? Alignment.centerLeft : Alignment.centerRight;
      height = 0;
      isOpen = false;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        imageUrl = _imageList[index].url;
        isOpen = true;
        mIndex = index;
        height = MediaQuery.of(context).size.width;
      });
    });
    _scrollController.scrollTo(index: index, duration: const Duration(milliseconds: 300));
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        nextIndex = index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_imageList[nextIndex].url),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  if ((details.primaryVelocity ?? 0) > 0) {
                    if (mIndex > 0) {
                      updateImageUrl(mIndex - 1, false);
                    }
                  } else if ((details.primaryVelocity ?? 0) < 0) {
                    if ((mIndex + 1) < _imageList.length) {
                      updateImageUrl(mIndex + 1, true);
                    }
                  }
                },
                child: Align(
                  alignment: alignment,
                  child: AnimatedContainer(
                    height: double.infinity,
                    width: height,
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isOpen ? 1 : 0.8,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).padding.bottom),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: Colors.white12,
                    height: 80,
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      itemCount: _imageList.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => updateImageUrl(index, index < mIndex ? false : true),
                          child: Container(
                            height: 70,
                            width: 70,
                            margin: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(6.0),
                                child: Image.network(
                                  _imageList[index].url,
                                  fit: BoxFit.fill,
                                )),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                border: Border.all(color: index == mIndex ? Colors.orange : Colors.white12, width: 3)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
