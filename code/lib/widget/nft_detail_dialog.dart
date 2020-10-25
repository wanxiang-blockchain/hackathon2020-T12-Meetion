
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:meetion/data/model/nft_item.dart';
import 'package:meetion/page/webview.dart';

import '../config/config.dart';
import '../config/config.dart';
import '../data/model/nft_item.dart';
import '../ethereum/chain_id.dart';
import '../ethereum/ethereum.dart';

class NFTDetailDialog extends StatefulWidget {

  final NFTItem nft;
  NFTDetailDialog(this.nft);

  @override
  State<StatefulWidget> createState() => _NFTDetailState();

}

class _NFTDetailState extends State<NFTDetailDialog> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
            height: 562,
            width: 320,
            child: Stack(
              children: [
                Image.asset("assets/images/nft_detail.png"),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: GestureDetector(
                    child: Container(color: Colors.transparent, width: 140, height: 50),
                    onTap: () {
                      // Navigator.pop(context);
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) {
                            var txHash = Config.txHash;
                            if (txHash == null || txHash.isEmpty) {
                              txHash = "0xf71fcd76ee5af1bfe229604fa423c5cf175050fd92b6e48bb6c5ed8b98c0c5e6";
                            }
                            return Webview(title: "NFT", url: "https://ropsten.etherscan.io/tx/$txHash");
                          }
                        )
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
