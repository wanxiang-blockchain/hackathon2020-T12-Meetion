import 'package:flutter/material.dart';

class ScreenUtil{
  static ScreenUtil instance = new ScreenUtil();

  //设计稿的设备尺寸修改
  double width;
  double height;
  bool allowFontScaling;

  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;

  static double _bottomBarHeight;

  static double _textScaleFactor;

  ScreenUtil({
    this.width = 375,///设计图上的宽度
    this.height = 812,///设计图上的高度
    this.allowFontScaling = false,
  });

  static ScreenUtil getInstance() {
    return instance;
  }

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = _mediaQueryData.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  static MediaQueryData get mediaQueryData => _mediaQueryData;

  ///每个逻辑像素的字体像素数，字体的缩放比例
  static double get textScaleFactory => _textScaleFactor;

  ///设备的像素密度
  static double get pixelRatio => _pixelRatio;

  ///当前设备宽度 dp
  static double get screenWidthDp => _screenWidth;

  ///当前设备高度 dp
  static double get screenHeightDp => _screenHeight;

  ///当前设备宽度 px
  static double get screenWidth => _screenWidth * _pixelRatio;

  ///当前设备高度 px
  static double get screenHeight => _screenHeight * _pixelRatio;

  ///状态栏高度 dp 刘海屏会更高
  static double get statusBarHeight => _statusBarHeight;

  ///底部安全区距离 dp
  static double get bottomBarHeight => _bottomBarHeight;

  ///实际的dp与设计稿px的比例
  static get scaleWidth => _screenWidth / instance.width;

  static get scaleHeight => _screenHeight / instance.height;

  ///根据设计稿的设备宽度适配
  ///高度也根据这个来做适配可以保证不变形
  static setWidth(double width) => width * scaleWidth;

  /// 根据设计稿的设备高度适配
  /// 当发现设计稿中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,高度适配建议使用此方法
  /// 高度适配主要针对想根据设计稿的一屏展示一样的效果
  static setHeight(double height) => height * scaleHeight;

  ///字体大小适配方法
  ///@param fontSize 传入设计稿上字体的px ,
  ///@param allowFontScaling 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为false。
  ///@param allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
  setSp(double fontSize) => allowFontScaling
      ? setWidth(fontSize)
      : setWidth(fontSize) / _textScaleFactor;

  static get fontSize8 => instance.setSp(8);
  static get fontSize9 => instance.setSp(9);
  static get fontSize10 => instance.setSp(10);
  static get fontSize11 => instance.setSp(11);
  static get fontSize12 => instance.setSp(12);
  static get fontSize13 => instance.setSp(13);
  static get fontSize14 => instance.setSp(14);
  static get fontSize15 => instance.setSp(15);
  static get fontSize16=> instance.setSp(16);
  static get fontSize17 => instance.setSp(17);
  static get fontSize18 => instance.setSp(18);
  static get fontSize19 => instance.setSp(19);
  static get fontSize20 => instance.setSp(20);
  static get fontSize21 => instance.setSp(21);
  static get fontSize22 => instance.setSp(22);
  static get fontSize23 => instance.setSp(23);
  static get fontSize24 => instance.setSp(24);
  static get fontSize25 => instance.setSp(25);
  static get fontSize26 => instance.setSp(26);
  static get fontSize27 => instance.setSp(27);
  static get fontSize28 => instance.setSp(28);
  static get fontSize29 => instance.setSp(29);
  static get fontSize30 => instance.setSp(30);


  static get size1 => setWidth(1);
  static get size2 => setWidth(2);
  static get size3 => setWidth(3);
  static get size4 => setWidth(4);
  static get size5 => setWidth(5);
  static get size6 => setWidth(6);
  static get size7 => setWidth(7);
  static get size8 => setWidth(8);
  static get size9 => setWidth(9);

  static get size10 => setWidth(10);
  static get size11 => setWidth(11);
  static get size12 => setWidth(12);
  static get size13 => setWidth(13);
  static get size14 => setWidth(14);
  static get size15 => setWidth(15);
  static get size16 => setWidth(16);
  static get size17 => setWidth(17);
  static get size18 => setWidth(18);
  static get size19 => setWidth(19);

  static get size20 => setWidth(20);
  static get size21 => setWidth(21);
  static get size22 => setWidth(22);
  static get size23 => setWidth(23);
  static get size24 => setWidth(24);
  static get size25 => setWidth(25);
  static get size26 => setWidth(26);
  static get size27 => setWidth(27);
  static get size28 => setWidth(28);
  static get size29 => setWidth(29);

  static get size30 => setWidth(30);
  static get size31 => setWidth(31);
  static get size32 => setWidth(32);
  static get size33 => setWidth(33);
  static get size34 => setWidth(34);
  static get size35 => setWidth(35);
  static get size36 => setWidth(36);
  static get size37 => setWidth(37);
  static get size38 => setWidth(38);
  static get size39 => setWidth(39);

  static get size40 => setWidth(40);
  static get size41 => setWidth(41);
  static get size42 => setWidth(42);
  static get size43 => setWidth(43);
  static get size44 => setWidth(44);
  static get size45 => setWidth(45);
  static get size46 => setWidth(46);
  static get size47 => setWidth(47);
  static get size48 => setWidth(48);
  static get size49 => setWidth(49);

  static get size50 => setWidth(50);
  static get size51 => setWidth(51);
  static get size52 => setWidth(52);
  static get size53 => setWidth(53);
  static get size54 => setWidth(54);
  static get size55 => setWidth(55);
  static get size56 => setWidth(56);
  static get size57 => setWidth(57);
  static get size58 => setWidth(58);
  static get size59 => setWidth(59);
  static get size60 => setWidth(60);

  static get size64 => setWidth(64);

  static get size80 => setWidth(80);

  static get size92 => setWidth(92);

  static get size100 => setWidth(100);

  static get size106 => setWidth(106);

  static get size120 => setWidth(120);

  static get size125 => setWidth(125);

  static get size200 => setWidth(200);


}