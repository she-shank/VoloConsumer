import 'package:flutter/material.dart';

//TODO: make this a generalized widget

class LoadPostWidget extends StatefulWidget {
  final Function requestPosts;
  const LoadPostWidget({Key? key, required this.requestPosts})
      : super(key: key);

  @override
  _LoadPostWidgetState createState() => _LoadPostWidgetState();
}

class _LoadPostWidgetState extends State<LoadPostWidget> {
  @override
  void initState() {
    super.initState();
    //widget.requestPosts();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
