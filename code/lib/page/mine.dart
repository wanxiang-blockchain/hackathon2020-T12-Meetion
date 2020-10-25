
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mine extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MineState();

}

class _MineState extends State<Mine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Mine"),
      //
      // ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              builderHeader(),
              buildAvatarName()
            ],
          ),
        ),
      ),
    );
  }

  Widget builderHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(Icons.settings)
      ],
    );
  }

  Widget buildAvatarName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          child: Text("avatar"),
        ),
        Text("Title"),
        Icon(Icons.chevron_right)
      ],
    );
  }

}