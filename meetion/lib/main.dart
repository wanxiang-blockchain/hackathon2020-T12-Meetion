import 'dart:async';
import 'dart:io';

import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meetion/config/theme.dart';
import 'package:meetion/page/chat.dart';
import 'package:meetion/page/home.dart';
import 'package:meetion/util/screen_util.dart';

import 'page/mine.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'meetion',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: AppTheme.background,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: FlutterEasyLoading(
        // child: MyHomePage(title: 'Flutter Demo Home Page')
        child:  Home(null),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CupertinoTabController _controller = CupertinoTabController();
  void navi(int index) {
    _controller.index = index;
  }

  @override
  Widget build(BuildContext context) {
    _controller.index = 1;
    return CupertinoTabScaffold(
      controller: _controller,
      tabBar: CupertinoTabBar(
        activeColor: Colors.blue,
        inactiveColor: Colors.blueAccent,
        items: [
          BottomNavigationBarItem(
              title: Text("推荐"),
              icon: Icon(Icons.add_to_queue),
              activeIcon: Icon(Icons.add_to_queue)),
          BottomNavigationBarItem(
              title: Text("消息"),
              icon: Icon(Icons.ac_unit),
              activeIcon: Icon(Icons.ac_unit)),
          BottomNavigationBarItem(
              title: Text("我的"),
              icon: Icon(Icons.accessibility),
              activeIcon: Icon(Icons.accessibility))
        ],
      ),
      tabBuilder: (context, index) {
        assert(index >= 0 && index <= 2);
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) => Chat(),
              defaultTitle: '',
            );
            break;
          case 1:
            return CupertinoTabView(
              builder: (context) => Home(this.navi),
              defaultTitle: '',
            );
            break;
          case 2:
            return CupertinoTabView(
              builder: (context) => Mine(),
              defaultTitle: '',
            );
            break;
        }
        return null;
      },
    );
  }
}
