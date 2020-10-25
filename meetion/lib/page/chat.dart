import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:convert/convert.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:decimal/decimal.dart';
import 'package:ethereum_util/ethereum_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meetion/config/theme.dart';
import 'package:meetion/data/model/nft_item.dart';
import 'package:meetion/util/screen_util.dart';
import 'package:meetion/widget/bottom_sheet.dart';
import 'package:meetion/widget/nft_detail_dialog.dart';
import 'package:meetion/widget/nft_list_dialog.dart';

import '../config/config.dart';
import '../ethereum/chain_id.dart';
import '../ethereum/ethereum.dart';
import '../ethereum/ethereum.dart';
import '../extension/string_ext.dart';

class Chat extends StatefulWidget {
  Chat({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  final ChatUser user = ChatUser(
    name: "Fayeed",
    firstName: "Fayeed",
    lastName: "Pawaskar",
    uid: "12345678",
    avatar: "assets/images/my_avatar.png",
    // color: Colors.green,
    // containerColor: Colors.yellow
  );

  final ChatUser otherUser = ChatUser(
    name: "Mrfatty",
    uid: "25649654",
    avatar: "assets/images/other_avatar.png",
  );

  List<ChatMessage> messages = List<ChatMessage>();
  var m = List<ChatMessage>();
  var i = 0;
  var nftList = List<NFTItem>();

  @override
  void initState() {
    getNFTData();
    super.initState();
  }

  void getNFTData() async {
    nftList.clear();
    // final eth = Ethereum();
    // final count = await eth.getTotalSupply(contract: Config.erc721_contract);
    // for (var i = 0; i < count; i++) {
    //   var url = await eth.getTokenURI(
    //     chainId: ChainId.ropsten,
    //     privateKey: null,
    //     contract: Config.erc721_contract,
    //     tokenId: BigInt.from(i)
    //   );

    //   final indexP = url.indexOf("h");
    //   url = url.substring(indexP);
    //   if (url[0] == "P") {
    //     url = url.substring(1);
    //   }

    //   final nftItem = NFTItem(
    //     url,
    //     "Norangi Olekey",
    //     "#1966091",
    //     Decimal.parse("0.009")
    //   );
    //   nftList.add(nftItem);
    // }

    nftList.add(NFTItem("https://gateway.pinata.cloud/ipfs/QmR1e5RzZ5MBBpHQMGe2CKtXnaaXq3NA3J4Lwvcr5JTKdJ", 0, "Norangi Olekey", "#1966055", Decimal.parse("0.009")));
    nftList.add(NFTItem("https://gateway.pinata.cloud/ipfs/QmeEdH8zwh1ivcHn4YxkF1WAb9KMMtUn5wCuCMw1NvYqP2", 1, "Norangi Olekey", "#1966091", Decimal.parse("0.32")));
    nftList.add(NFTItem("https://gateway.pinata.cloud/ipfs/QmUAnVspFbxpAecYuBYu56otyjNeVkUKiyUyYHXALSYEEt", 2, "Norangi Olekey", "#1966092", Decimal.parse("0.012")));
    nftList.add(NFTItem("https://gateway.pinata.cloud/ipfs/QmNPUp84WoCt69poP7SDy1BoBms2sxg4j7i6h2xxG71nDj", 3, "Norangi Olekey", "#1966093", Decimal.parse("0.01")));
    // nftList.add(NFTItem("https://http.cat/303", 4, "Norangi Olekey", "#1966091", Decimal.parse("1")));

  }

  void systemMessage() {
    Timer(Duration(milliseconds: 300), () {
      if (i < 6) {
        setState(() {
          messages = [...messages, m[i]];
        });
        i++;
      }
      Timer(Duration(milliseconds: 300), () {
        _chatViewKey.currentState.scrollController
          ..animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }

  void onSend(ChatMessage message) async {
    print(message.toJson());

    Map<dynamic, dynamic> msg =  {
      "id": "12312312312",
      "text": "你好",
      // "image": "https://http.cat/100",
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "user": otherUser.toJson()
    };

    setState(() {
      messages.add(message);
      // messages.add(ChatMessage.fromJson(msg));
    });
  }

  List<NFTItem> selectedNFTs;

  void selectedNFTCallback(List<NFTItem> nfts) {
    print("receive nfts lenght: ${nfts.length}");
    
    selectedNFTs = nfts;

    final msgs = List<ChatMessage>();
    for (var item in nfts) {
      Map<dynamic, dynamic> msg =  {
        "id": "123121212",
        "text": "",
        // "image": item.imgUrl,
        "image": "assets/images/chat_nft_gitf.png",
        "createdAt": DateTime.now().millisecondsSinceEpoch,
        "user": user.toJson()
      };
      msgs.add(ChatMessage.fromJson(msg));
    }

  //  Map<dynamic, dynamic> testMsg =  {
  //     "id": "25649654",
  //     "text": "hello world",
  //     "createdAt": DateTime.now().millisecondsSinceEpoch,
  //     "user": otherUser.toJson()
  //   };
  //   messages.add(ChatMessage.fromJson(testMsg));

    setState(() {
      messages.addAll(msgs);
    });
  }

  Widget buildGiftButton(func) {
    return CupertinoButton(
      child: SizedBox(
        width: 44,
        height: 44,
        child: Image.asset("assets/images/send_gift.png"),
      ),
      onPressed: () {
        showCustomBottomSheet(context: context, builder: (context) {
          return NFTListDialog(nftList, selectedNFTCallback);
        });

        // send nft token
        // sendNFTTest();

      },
    );
  }

  Widget buildImageMessage(String url) {
    Widget image;
    if (url.startsWith("http")) {
      image = CachedNetworkImage(imageUrl: url);
    } else {
      image = Stack(
        children: [
          Image.asset(url),
          Positioned(
            right: 20,
            top: 30,
            child: Text("Boom Shaka Laka", style: TextStyle(color: Colors.white, fontSize: 16))
          ),
        ],
      );
    }

    return Container(child: image);
  }

  Widget buildUserAvatar(ChatUser user) {
    Widget avatar;
    if (user.avatar == null) {
      avatar = null;
    }
    else if (user.avatar.startsWith("http")) {
      avatar = CachedNetworkImage(imageUrl: user.avatar);
    } else {
      avatar = Image.asset(user.avatar);
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20)
      ),
      child: avatar,
    );
  }

  Widget buildChatList() {
    return SafeArea(
      child: DashChat(
        key: _chatViewKey,
        sendButtonBuilder: buildGiftButton,
        avatarBuilder: (chatUser) => buildUserAvatar(chatUser),
        messageImageBuilder: (url, [message]) {
          return GestureDetector(
            onTap: (){
              print("select msg: ${message.id} image url: $url");
              showDialog(context: context, builder: (context) {
                return NFTDetailDialog(selectedNFTs[0]);
              });
            },
            child: buildImageMessage(url)
            );
        },
        messageTimeBuilder: (url, [message]) {
          return Container(width: 0, height: 0);
        },
        // messageContainerDecoration: BoxDecoration(color: AppTheme.myChatBubbleBackgroundColor),
        messageDecorationBuilder: (message, isUser) {
          if (isUser) {
            if (message.image != null && message.image.isNotEmpty) {
              return null;
            } else {
              return BoxDecoration(
                  color: AppTheme.myChatBubbleBackgroundColor,
                  borderRadius: BorderRadius.circular(5.0)
                );
            }
          } else {
            return BoxDecoration(color: AppTheme.otherChatBubbleBackgroundColor,
            borderRadius: BorderRadius.circular(5.0));
          }
        },
        inverted: false,
        onSend: onSend,
        sendOnEnter: true,
        textInputAction: TextInputAction.send,
        user: user,
        inputDecoration:
            InputDecoration.collapsed(hintText: "说点什么吧"),
        dateFormat: DateFormat('yyyy-MMM-dd'),
        timeFormat: DateFormat('HH:mm'),
        messages: messages,
        showUserAvatar: true,
        showAvatarForEveryMessage: false,
        scrollToBottom: false,
        onPressAvatar: (ChatUser user) {
          print("OnPressAvatar: ${user.name}");
        },
        onLongPressAvatar: (ChatUser user) {
          print("OnLongPressAvatar: ${user.name}");
        },
        inputMaxLines: 5,
        messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
        alwaysShowSend: true,
        inputTextStyle: TextStyle(fontSize: 16.0),
        // inputContainerStyle: BoxDecoration(
        //   border: Border.all(width: 0.0),
        //   color: Colors.white,
        // ),
        onQuickReply: (Reply reply) {
          setState(() {
            messages.add(ChatMessage(
                text: reply.value,
                createdAt: DateTime.now(),
                user: user));

            messages = [...messages];
          });

          Timer(Duration(milliseconds: 300), () {
            _chatViewKey.currentState.scrollController
              ..animateTo(
                _chatViewKey.currentState.scrollController.position
                    .maxScrollExtent,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );

            if (i == 0) {
              systemMessage();
              Timer(Duration(milliseconds: 600), () {
                systemMessage();
              });
            } else {
              systemMessage();
            }
          });
        },
        onLoadEarlier: () {
          print("laoding...");
        },
        shouldShowLoadEarlier: false,
        showTraillingBeforeSend: true,
        trailing: <Widget>[
          SizedBox(
            width: 44,
            height: 44,
            child: Image.asset("assets/images/smile.png"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    ScreenUtil.getInstance()
      ..width = 375
      ..height = 812
      ..init(context);
      

    return Scaffold(
      appBar: AppBar(
        title: Text("徐橘子", style: TextStyle(fontSize: 18, color: AppTheme.nameColor)),
      ),
      body: buildChatList()
    );
  }
}