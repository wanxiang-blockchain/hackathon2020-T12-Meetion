import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meetion/util/screen_util.dart';
import 'package:meetion/page/chat.dart';

class Home extends StatefulWidget {
  Function fn;
  Home(Function fn) {
    this.fn = fn;
  }
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['Alice', "Alice2", "Alice3"];
    final List<String> messages = <String>['遇到你真是太幸运了，你真是一个阳光善良的boy~', "好的", "hi"];
    final List<int> notReads = <int>[2, 1, 1];
    final List<String> avatars = ["assets/images/user1.png", "assets/images/girl_avatar2.png", "assets/images/girl_avatar3.png", "assets/images/girl_avatar4.png"];

    ScreenUtil.getInstance()
      ..width = 375
      ..height = 812
      ..init(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "消息",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: SafeArea(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Container(
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(24.0)),
                            child: Column(
                              children: [
                                ListTile(
                                    leading: CircleAvatar(
                                        child: Image.asset(avatars[index])),
                                    title: Text(entries[index]),
                                    subtitle: Text(
                                      messages[index],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                    trailing: notReads[index] > 0
                                        ? CircleAvatar(
                                            radius: 12,
                                            backgroundColor:
                                                Colors.pink.shade500,
                                            child: Text(
                                              notReads[index].toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                          )),
                              ],
                            ))),
                    onTap: () => onTapped(),
                  );
                })));
  }

  void onTapped() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Chat()));
  }
}
