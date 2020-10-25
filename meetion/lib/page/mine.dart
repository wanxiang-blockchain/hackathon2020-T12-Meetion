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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Mine",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [buildAvatarName()],
          ),
        ),
      ),
    );
  }

  Widget builderHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [Icon(Icons.settings)],
    );
  }

  Widget buildAvatarName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(children: [
          Container(
              padding: EdgeInsets.only(left: 0, top: 16),
              child: Row(children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: CircleAvatar(
                    radius: 24,
                    child: Image.asset("assets/images/my_avatar.png"),
                  ),
                ),
                Container(
                  child: Text("Hi, CYi",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500)),
                )
              ]))
        ]),
        Container(padding: EdgeInsets.all(16), child: Icon(Icons.chevron_right))
      ],
    );
  }

  Widget buildProfile() {
    return Row(
      children: [
        Card(
          child: Text(""),
        )
      ],
    );
  }
}
