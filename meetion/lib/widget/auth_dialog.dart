
import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:meetion/data/model/nft_item.dart';
import 'package:meetion/page/webview.dart';

import '../config/config.dart';
import '../config/config.dart';
import '../config/theme.dart';
import '../data/model/nft_item.dart';
import '../ethereum/chain_id.dart';
import '../ethereum/ethereum.dart';

class AuthDialog extends StatefulWidget {

  Function callback;
  AuthDialog(this.callback);

  @override
  State<StatefulWidget> createState() => _AuthState();

}

class _AuthState extends State<AuthDialog> {

  String authTitle = "请完成面容验证";
  String imagePath = "assets/images/auth_face.png";

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), (){
      setState(() {
        imagePath = "assets/images/auth_success.png";
        authTitle = "面容识别通过";
      });

        Future.delayed(Duration(seconds: 1), (){ 
          Navigator.pop(context); 
          widget?.callback();
        });
    });
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 220,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 54),
              Image.asset(imagePath, width: 64, height: 64),
              SizedBox(height: 23),
              Text(authTitle, style: TextStyle(color: AppTheme.disableColor)),
            ],
          ),
        ),
      )
    );
  }
}
