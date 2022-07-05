import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AnimationSearchBarText extends StatefulWidget {
  const AnimationSearchBarText({Key? key}) : super(key: key);

  @override
  State<AnimationSearchBarText> createState() => _AnimationSearchBarTextState();
}

class _AnimationSearchBarTextState extends State<AnimationSearchBarText> {
  String? searchString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              OpenContainer<String>(
                openBuilder: (_, closeContainer) => SearchPage(closeContainer),
                onClosed: (res) => setState(() {
                  searchString = res;
                }),
                tappable: false,
                closedBuilder: (_, openContainer) => SearchBar(
                  searchString: searchString ?? "",
                  openContainer: openContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, required this.searchString, required this.openContainer}) : super(key: key);

  final String searchString;
  final VoidCallback openContainer;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: openContainer,
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: Row(
            children: [
              const Icon(Icons.search),
              const SizedBox(width: 10),
              Expanded(child: Text(searchString)),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage(
    this.onClose, {
    Key? key,
  }) : super(key: key);

  final void Function({String returnValue}) onClose;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? _searchText;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                    blurRadius: 1,
                    color: Colors.black26,
                  )
                ],
                color: Colors.white,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
                    onPressed: widget.onClose,
                  ),
                  Expanded(
                    child: TextFormField(
                      onFieldSubmitted: (value) {
                        widget.onClose(returnValue: value);
                      },
                      decoration: const InputDecoration(border: InputBorder.none),
                      textInputAction: TextInputAction.search,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () => widget.onClose(returnValue: 'Flutter'),
                    child: const Text('Search: "Flutter"'),
                  ),
                  ElevatedButton(
                    onPressed: () => widget.onClose(returnValue: 'Rabbit'),
                    child: const Text('Search: "Rabbit"'),
                  ),
                  ElevatedButton(
                    onPressed: () => widget.onClose(returnValue: 'What is the Matrix'),
                    child: const Text('Search: "What is the Matrix"'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
