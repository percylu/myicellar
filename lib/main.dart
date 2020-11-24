//import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'generated/l10n.dart';

const APPBAR_SCROLL_OFFSET = 80;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyiCellar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "MyiCellar"),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      // 设置中文为首选项
      supportedLocales: [
        const Locale('zh_HK', ''),
        ...S.delegate.supportedLocales
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color appbarBgColor = Colors.transparent;
  Size screenSize;
  bool isBigScreen = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    setState(() {
      isBigScreen = size.width > 620;
      screenSize = size;
    });

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Stack(children: <Widget>[
          MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: NotificationListener(
                  // ignore: missing_return
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                  },
                  child: _listView,
                ),
              )),
          _appbar
        ]),
      ),

      // body: Column(
      //     // mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Image.asset('assets/images/logo.png', width: 100),
      //       Text(S.of(context).title),
      //       Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
    );
  }

  _onScroll(offset) {
    // print(offset);

    setState(() {
      appbarBgColor =
          offset > APPBAR_SCROLL_OFFSET ? Colors.white : Colors.transparent;
    });

    // double alpha = offset / APPBAR_SCROLL_OFFSET;
    // if (alpha < 0) {
    //   alpha = 0;
    // } else if (alpha > 1) {
    //   alpha = 1;
    // }
    // setState(() {
    //   appBarAlpha = alpha;
    // });
  }

  Widget get _listView {
    Size size = screenSize;
    Widget bigScreen =
    Container(constraints: BoxConstraints(maxWidth: 1440),
    child: ListView(
      children: <Widget>[
        Container(
            width: size.width,
            alignment: Alignment.bottomCenter,
            // height: size.height / 1.2,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(30, 180, 30, 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text('从此踏上你的美酒之旅。',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold)),
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/download-app-qr-code.png',
                          width: 100,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(bottom: 30),
                                      child: Text('酒迷必备手机程式...',
                                          style: TextStyle(fontSize: 18))),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 20),
                                        child: Image.asset(
                                            'assets/images/apple-store-myicellar-app.png',
                                            width: 150),
                                      ),
                                      Container(
                                          child: Image.asset(
                                              'assets/images/google-play-store-myicellar-app.png',
                                              width: 150)),
                                    ],
                                  ),
                                ]))
                      ],
                    ),
                  ),
                  Image.asset('assets/images/beach.png')
                ]),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.pinkAccent,
                  Colors.white,
                ],
              ),
            )),
        Container(
            margin: EdgeInsets.all(50),
            child: Row(children: <Widget>[
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(right: size.width / 5),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Align(
                                alignment: FractionalOffset.centerLeft,
                                child: Text('拣酒有道',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Color(0xff820E0D))),
                              ),
                              // Text('拣酒有道', textAlign: TextAlign.left, style: TextStyle(fontSize: 30, color: Color(0xff820E0D))),
                              Align(
                                alignment: FractionalOffset.centerLeft,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                                    child: Text(
                                        '简单几个步骤，即可直接选购逾五千款美酒佳酿。以价钱、品种、国家、产地等不同关键字，轻松搜寻出你的心水靓酒。')),
                              ),
                              Align(
                                alignment: FractionalOffset.centerLeft,
                                child: Image.asset('assets/images/glass-group.png'),
                              )
                            ],
                          )))),
              Image.asset('assets/images/myicellar-app-shop.png'),
            ])),
        Container(
            margin: EdgeInsets.all(50),
            child: Row(children: <Widget>[
              Image.asset('assets/images/myicellar-app-event-list.png'),
              Expanded(
                  child: Container(
                    // margin: EdgeInsets.only(right: size.width / 5),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Align(
                                alignment: FractionalOffset.centerLeft,
                                child: Text('品酒盛会',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Color(0xff820E0D))),
                              ),
                              // Text('拣酒有道', textAlign: TextAlign.left, style: TextStyle(fontSize: 30, color: Color(0xff820E0D))),
                              Align(
                                alignment: FractionalOffset.centerLeft,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                                    child: Text(
                                        '收录城中大小品酒活动，从入门试酒会到酿酒师主持晚宴，都可即时网上报名。')),
                              )
                            ],
                          )))),
              Image.asset('assets/images/friends-1.png'),
            ])),
        Container(
            margin: EdgeInsets.all(50),
            child: Row(children: <Widget>[
              Expanded(
                  child: Container(
                    // margin: EdgeInsets.only(right: size.width / 5),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Align(
                                alignment: FractionalOffset.centerLeft,
                                child: Text('我的酒窖',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Color(0xff820E0D))),
                              ),
                              // Text('拣酒有道', textAlign: TextAlign.left, style: TextStyle(fontSize: 30, color: Color(0xff820E0D))),
                              Align(
                                alignment: FractionalOffset.centerLeft,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                                    child: Text(
                                        '建立你的云端酒窖，记录你的品酒笔记。添加你的最爱到到愿望清单中，我们会在它们减价时通知你。')),
                              )
                            ],
                          )))),
              Image.asset('assets/images/friends-2.png'),
              Image.asset('assets/images/myicellar-app-cellar.png'),
            ])),
        Container(
            child: Row(children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 80, 0, 80),
                  color: Color(0xff820E0D),
                  child: Column(children: [
                    Text('5000+',
                        style: TextStyle(fontSize: 38, color: Colors.white)),
                    Text('上架酒款',
                        style: TextStyle(fontSize: 38, color: Colors.white))
                  ]),
                ),
              ),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 80, 0, 80),
                    color: Color(0xffccb9a2),
                    child: Column(children: [
                      Text('800+', style: TextStyle(fontSize: 38, color: Colors.white)),
                      Text('品牌阵容', style: TextStyle(fontSize: 38, color: Colors.white))
                    ]),
                  )),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 80, 0, 80),
                    color: Color(0xff4a4a4a),
                    child: Column(children: [
                      Text('1500', style: TextStyle(fontSize: 38, color: Colors.white)),
                      Text('品牌活动', style: TextStyle(fontSize: 38, color: Colors.white))
                    ]),
                  ))
            ])),
        Container(
          color: Color(0xfff7f7f7),
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Text('下载手机程式 尊享更全面功能',
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4a4a4a))),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Image.asset('assets/images/apple-store-myicellar-app.png',
                        width: 200),
                  ),
                  Container(
                      child: Image.asset(
                          'assets/images/google-play-store-myicellar-app.png',
                          width: 200)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Text('支持机构',
                  style: TextStyle(fontSize: 18, color: Color(0xff4a4a4a))),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Image.asset('assets/images/cathay-pacific-logo.png',
                          width: 300)),
                  Container(
                      child:
                      Image.asset('assets/images/cyberport-logo.png', width: 300))
                ],
              ),
            ),
          ]),
        ),
        Container(
          child: Column(children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 70, 0, 100),
              child: Text('顾客意见', style: TextStyle(fontSize: 30)),
            ),
            Container(height: 300, child: _bannerSwiper)
          ]),
        ),
        Container(
          color: Color(0xfff7f7f7),
          child: Column(children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 70, 0, 70),
              child: Text('联系我们',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Text('想紧贴酒坛动向、最新优惠及城中大小活动？立即订阅我们！',
                    style: TextStyle(fontSize: 18))),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(right: 15),
                    alignment: Alignment.center,
                    height: 30,
                    child: TextField(
                      // obscureText: true,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.pink,
                          ),
                        ),
                        hintText: '你的电邮',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[300],
                        ),
                      ),
                      // controller: this._pass,
                      // onChanged: (value) {
                      //   this.setState(() {
                      //     this._pass.text = value;
                      //   });
                      // },
                    ),
                  ),
                  RaisedButton(
                    child: Text('订阅'),
                    onPressed: () {},
                  )
                ]),
            Image.asset('assets/images/friends-in-sea.png')
          ]),
        ),
        Container(
          color: Color(0xff4a4a4a),
          padding: EdgeInsets.all(60),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: Text('联系我们',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white))),
                          Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text('+852 62891140',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                  ),
                                  Image.asset('assets/images/whatsapp-icon.png',
                                      width: 30),
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text('info@myicellar.com',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white))),
                          Container(
                              child: Text('香港鲗鱼涌华兰路20号华兰中心907室',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white)))
                        ])),
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: Text('云窖',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white))),
                          Container(
                              child: Text('加入我们',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white)))
                        ])),
                Expanded(
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Image.asset('assets/images/whtie-logo.png'),
                    ),
                    Container(
                        child: Text('@2020 MyiCellar All rights reserved.',
                            style:
                            TextStyle(fontSize: 14, color: Colors.white)))
                  ]),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: Text('關注我們',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white))),
                          Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/fb-icon.png', width: 30),
                                  Image.asset('assets/images/ig-icon.png', width: 30),
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text('条款',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white))),
                          Container(
                              child: Text('隐私政策',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white)))
                        ])),
              ]),
        )
      ],
    ));

    Widget smallScreen = ListView(
      children: <Widget>[
        Container(
            width: size.width,
            alignment: Alignment.bottomCenter,
            // height: size.height / 1.2,
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(30, 150, 30, 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text('从此踏上你的美酒之旅。',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold)),
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
                    child: Row(
                      children: [
                        Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  child: Text('酒迷必备手机程式...',
                                      style: TextStyle(fontSize: 18))),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Image.asset(
                                        'assets/images/apple-store-myicellar-app.png',
                                        width: (size.width / 3) - 20),
                                  ),
                                  Container(
                                      child: Image.asset(
                                          'assets/images/google-play-store-myicellar-app.png',
                                          width: (size.width / 3) - 20)),
                                ],
                              ),
                            ]))
                      ],
                    ),
                  ),
                  Image.asset('assets/images/beach.png')
                ]),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.pinkAccent,
                  Colors.white,
                ],
              ),
            )),
        Container(
            margin: EdgeInsets.all(50),
            child: Column(children: <Widget>[
              Container(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Align(
                            alignment: FractionalOffset.centerLeft,
                            child: Text('拣酒有道',
                                style: TextStyle(
                                    fontSize: 30, color: Color(0xff820E0D))),
                          ),
                          // Text('拣酒有道', textAlign: TextAlign.left, style: TextStyle(fontSize: 30, color: Color(0xff820E0D))),
                          Align(
                            alignment: FractionalOffset.centerLeft,
                            child: Container(
                                margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                                child: Text(
                                    '简单几个步骤，即可直接选购逾五千款美酒佳酿。以价钱、品种、国家、产地等不同关键字，轻松搜寻出你的心水靓酒。')),
                          ),
                        ],
                      ))),
              Image.asset('assets/images/myicellar-app-shop.png',
                  width: size.width / 1.5),
            ])),
        Container(
            margin: EdgeInsets.all(50),
            child: Column(children: <Widget>[
              Container(
                  // margin: EdgeInsets.only(right: size.width / 5),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Align(
                            alignment: FractionalOffset.centerLeft,
                            child: Text('品酒盛会',
                                style: TextStyle(
                                    fontSize: 30, color: Color(0xff820E0D))),
                          ),
                          // Text('拣酒有道', textAlign: TextAlign.left, style: TextStyle(fontSize: 30, color: Color(0xff820E0D))),
                          Align(
                            alignment: FractionalOffset.centerLeft,
                            child: Container(
                                margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                                child: Text(
                                    '收录城中大小品酒活动，从入门试酒会到酿酒师主持晚宴，都可即时网上报名。')),
                          )
                        ],
                      ))),
              Image.asset('assets/images/myicellar-app-event-list.png'),
            ])),
        Container(
            margin: EdgeInsets.all(50),
            child: Column(children: <Widget>[
              Container(
                  // margin: EdgeInsets.only(right: size.width / 5),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Align(
                            alignment: FractionalOffset.centerLeft,
                            child: Text('我的酒窖',
                                style: TextStyle(
                                    fontSize: 30, color: Color(0xff820E0D))),
                          ),
                          // Text('拣酒有道', textAlign: TextAlign.left, style: TextStyle(fontSize: 30, color: Color(0xff820E0D))),
                          Align(
                            alignment: FractionalOffset.centerLeft,
                            child: Container(
                                margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                                child: Text(
                                    '建立你的云端酒窖，记录你的品酒笔记。添加你的最爱到到愿望清单中，我们会在它们减价时通知你。')),
                          )
                        ],
                      ))),
              Image.asset('assets/images/myicellar-app-cellar.png'),
            ])),
        Container(
            child: Column(children: [
          Container(
            width: size.width,
            padding: EdgeInsets.fromLTRB(0, 80, 0, 80),
            color: Color(0xff820E0D),
            child: Column(children: [
              Text('5000+',
                  style: TextStyle(fontSize: 38, color: Colors.white)),
              Text('上架酒款', style: TextStyle(fontSize: 38, color: Colors.white))
            ]),
          ),
          Container(
            width: size.width,
            padding: EdgeInsets.fromLTRB(0, 80, 0, 80),
            color: Color(0xffccb9a2),
            child: Column(children: [
              Text('800+', style: TextStyle(fontSize: 38, color: Colors.white)),
              Text('品牌阵容', style: TextStyle(fontSize: 38, color: Colors.white))
            ]),
          ),
          Container(
            width: size.width,
            padding: EdgeInsets.fromLTRB(0, 80, 0, 80),
            color: Color(0xff4a4a4a),
            child: Column(children: [
              Text('1500', style: TextStyle(fontSize: 38, color: Colors.white)),
              Text('品牌活动', style: TextStyle(fontSize: 38, color: Colors.white))
            ]),
          )
        ])),
        Container(
          color: Color(0xfff7f7f7),
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Text('下载手机程式 尊享更全面功能',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4a4a4a))),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Image.asset('assets/images/apple-store-myicellar-app.png',
                        width: (size.width / 3) - 20),
                  ),
                  Container(
                      child: Image.asset(
                          'assets/images/google-play-store-myicellar-app.png',
                          width: (size.width / 3) - 20)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Text('支持机构',
                  style: TextStyle(fontSize: 18, color: Color(0xff4a4a4a))),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Image.asset('assets/images/cathay-pacific-logo.png',
                          width: (size.width / 3) - 20)),
                  Container(
                      child: Image.asset('assets/images/cyberport-logo.png',
                          width: (size.width / 3) - 20))
                ],
              ),
            ),
          ]),
        ),
        Container(
          child: Column(children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Text('顾客意见', style: TextStyle(fontSize: 30)),
            ),
            Container(height: 300, child: _bannerSwiper)
          ]),
        ),
        Container(
          color: Color(0xfff7f7f7),
          child: Column(children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Text('联系我们',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 30),
                width: screenSize.width - 60,
                child: Text('想紧贴酒坛动向、最新优惠及城中大小活动？立即订阅我们！',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18))),
            Container(
              width: screenSize.width / 2.5,
              alignment: Alignment.center,
              height: 30,
              child: TextField(
                // obscureText: true,

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink,
                    ),
                  ),
                  hintText: '你的电邮',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[300],
                  ),
                ),
                // controller: this._pass,
                // onChanged: (value) {
                //   this.setState(() {
                //     this._pass.text = value;
                //   });
                // },
              ),
            ),
            Container(
              width: screenSize.width / 2.5,
              margin: EdgeInsets.only(top: 15),
              child: RaisedButton(
                child: Text('订阅'),
                onPressed: () {},
              ),
            ),
            Image.asset('assets/images/friends-in-sea.png')
          ]),
        ),
        Container(
          color: Color(0xff4a4a4a),
          padding: EdgeInsets.all(60),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: Text('联系我们',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white))),
                          Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text('+852 62891140',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                  ),
                                  Image.asset('assets/images/whatsapp-icon.png',
                                      width: 20),
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text('info@myicellar.com',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white))),
                          Container(
                              child: Text('香港鲗鱼涌华兰路20号华兰中心907室',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white)))
                        ])),
                Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: Text('云窖',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white))),
                          Container(
                              child: Text('加入我们',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white)))
                        ])),
                Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: Text('關注我們',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white))),
                          Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/fb-icon.png', width: 30),
                                  Image.asset('assets/images/ig-icon.png', width: 30),
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text('条款',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white))),
                          Container(
                              child: Text('隐私政策',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white)))
                        ])),
                Column(children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Image.asset('assets/images/whtie-logo.png'),
                  ),
                  Container(
                      child: Text('@2020 MyiCellar All rights reserved.',
                          style: TextStyle(fontSize: 14, color: Colors.white)))
                ]),
              ]),
        )
      ],
    );
    return isBigScreen ? bigScreen : smallScreen;
  }

  Widget get _bannerSwiper {
    List banners = [
      {'content': '送貨準時👍價錢合理👍絕對係買紅酒的好平台', 'name': 'Paul Lew', 'user': 'User'},
      {
        'content': '唔錯呀👍幫手揀嘅酒夠特別，價錢合理，質量不错，只會買多咗💸唔會揀錯👏',
        'name': 'Angus Leung',
        'user': 'User'
      },
      {
        'content':
            'The app is easy to use and contains Informative descriptions for each bottle of wine. It allows  me to choose my favourite wine at ease. Price is fair.Deliveryservice is convenient which saves me a lot of trouble in carrying the bottles home.',
        'name': 'Keith Lee',
        'user': 'User'
      },
      {
        'content':
            '每次本人向MyiCellar 訂購紅酒，他們訂貨服務方便，專人聯絡送貨安排，服務貼心。不過若網上提供更多紅酒資料及taste notes,就更佳。',
        'name': 'David Ho',
        'user': 'User'
      }
    ];
    print(screenSize);
    return Swiper(
        itemCount: banners.length,
        autoplay: true,
        duration: 3,
        containerWidth: isBigScreen ? 500 : screenSize.width - 60,
        itemBuilder: (BuildContext context, int index) {
          var cur = banners[index];
          return Column(
            children: [
              Container(
                  width: isBigScreen ? 500 : screenSize.width - 60,
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  margin: EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 2, color: Colors.black))),
                  child: Text(cur['content'])),
              Text(cur['name'], style: TextStyle(fontWeight: FontWeight.bold)),
              Text(cur['user']),
            ],
          );
        });
  }

  Widget get _appbar {
    Widget bigScreen = Container(
      constraints: BoxConstraints(maxWidth: 1440),
      color: appbarBgColor,
      child: Padding(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Row(children: [
            Image.asset('assets/images/logo.png', width: 100),
            Expanded(
              child: Text(''), // 中间用Expanded控件
            ),
            Container(
              child: Text('商店',
                  style: TextStyle(
                      color: Color(0xff4a4a4a),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(10),
            ),
            Container(
              child: Text('试酒活动',
                  style: TextStyle(
                      color: Color(0xff4a4a4a),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(10),
            ),
          ])),
    );
    Widget smallScreen = Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0), //阴影xy轴偏移量
              blurRadius: 15.0, //阴影模糊程度
              spreadRadius: 1.0 //阴影扩散程度
              )
        ]),
        child: Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Row(children: [
              Icon(Icons.menu, color: Color(0xff820E0D)),
              Expanded(
                  child: Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/logo.png', width: 100),
              )),
              Icon(Icons.shopping_cart, color: Color(0xff820E0D)),
            ])));
    return isBigScreen ? bigScreen : smallScreen;
  }

  Future<void> _handleRefresh() async {
    // try {
    //   HomeModel result = await HomeDao.fetch();
    //   print(result);
    //   setState(() {
    //     localNavList = result.localNavList;
    //     gridNavModel = result.gridNav;
    //     subNavList = result.subNavList;
    //     salesBox = result.salesBox;
    //     bannerList = result.bannerList;
    //     _loading = false;
    //   });
    // } catch (e) {
    //   print(e);
    //   setState(() {
    //     _loading = false;
    //   });
    // }
    // return null;
  }
}
