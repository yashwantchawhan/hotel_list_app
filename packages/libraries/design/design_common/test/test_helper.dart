import 'package:flutter/material.dart';

class FakeCachedNetworkImage extends StatelessWidget {
  final String imageUrl;

  const FakeCachedNetworkImage({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(key: Key(imageUrl), color: Colors.grey);
  }
}