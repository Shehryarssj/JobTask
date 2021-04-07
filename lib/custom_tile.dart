import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final title, distance, onTap;
  CustomTile({this.distance, this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.center,
      width: screenWidth * 0.5,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(title),
        subtitle: Text(distance),
        onTap: onTap,
      ),
    );
  }
}
