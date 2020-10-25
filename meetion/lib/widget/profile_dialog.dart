
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:meetion/config/theme.dart';
import 'package:meetion/data/model/nft_item.dart';
import 'package:meetion/page/webview.dart';
import 'package:meetion/util/screen_util.dart';

import '../config/config.dart';
import '../config/config.dart';
import '../data/model/nft_item.dart';
import '../ethereum/chain_id.dart';
import '../ethereum/ethereum.dart';

class ProfileDialog extends StatefulWidget {

  ProfileDialog();

  @override
  State<StatefulWidget> createState() => _ProfileState();

}

class _ProfileState extends State<ProfileDialog> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Alice", style: TextStyle(fontSize: 18, color: AppTheme.nameColor)),
        elevation: 0,
        leading: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            "assets/images/back_arrow.png",
            width: ScreenUtil.size22,
            height: ScreenUtil.size22,
          )
        )
      ),
      backgroundColor: Colors.white,
      body: Container(
            height: 640,
            // width: 560,
            child: Center(child: Image.asset("assets/images/alice_profile.png"))
            )
    );
  }
}
