import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';

class Akun extends StatefulWidget {
  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      imageProvider: NetworkImage("https://picsum.photos/250?image=9"),
    ));
  }
}
