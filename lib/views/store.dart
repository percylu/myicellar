/*
 * @Author: Sam
 * @Date: 2020-11-23 22:13:30
 * @LastEditors: Sam
 * @LastEditTime: 2020-11-26 00:37:39
 * @Description: file content
 * @FilePath: \myicellar\lib\views\store.dart
 */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Store extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _Store createState() => _Store();
}

class _Store extends State<Store> {
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
        body: Stack(
      children: [
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
      ],
    ));
  }

  Widget get _appbar {
    return Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 2.0), //阴影xy轴偏移量
              blurRadius: 5.0, //阴影模糊程度
              spreadRadius: 0 //阴影扩散程度
              )
        ]),
        child: Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Row(children: [
              Icon(Icons.menu, color: Color(0xff820E0D)),
              Expanded(
                  child: Align(
                alignment: Alignment.center,
                child: Image.asset('images/logo.png', width: 100),
              )),
              Icon(Icons.shopping_cart, color: Color(0xff820E0D)),
            ])));
  }

  Widget get _listView {
    return ListView(
      children: [
        Container(height: 80),
        Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 1.0), //阴影xy轴偏移量
                  blurRadius: 5.0, //阴影模糊程度
                  spreadRadius: 0 //阴影扩散程度
                  )
            ]),
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                    child: Text('名庄酒',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('红酒',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('白酒',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('气酒',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)))
              ],
            )),
        _bannerSwiper,
        _goods
      ],
    );
  }

  Widget get _goods {
    List mock = [
      {
        'image': 'https://www.myicellar.com/imgstore/s52/bollinger-rose-limited-edition-special-gift-box-2006-8196.jpg?z=24',
        'title': 'Bollinger Rosé (Limited Edition - Special Gift Box) 2006',
        'price': '180',
        'moneyUnit': 'HKD',
        'year': '2009',
        'isSellOut': true,
        'capacity': '750ml',

      },
      {
        'image': 'https://www.myicellar.com/imgstore/s52/perrier-jouet-grand-brut-nv-10483.jpg?z=24',
        'title': 'Bollinger Rosé (Limited Edition - Special Gift Box) 2006',
        'price': '180',
        'moneyUnit': 'HKD',
        'year': 'N.V.',
        'isSellOut': false,
        'capacity': '700ml',

      },
      {
        'image': 'https://www.myicellar.com/imgstore/s52/dassai-23-junmai-daiginjo-nv-2821.jpg?z=24',
        'title': 'Dassai 23 Junmai Daiginjo 獺祭 二割三分 純米大吟釀 N.V.',
        'price': '180',
        'moneyUnit': 'HKD',
        'year': 'N.V',
        'isSellOut': false,
        'capacity': '720ml',

      },
      {
        'image': 'https://www.myicellar.com/imgstore/s52/suntory-whisky-hibiki-japanese-harmony-nv-3261.jpg?z=24',
        'title': 'Suntory Hibiki Harmony Blended Japanese Whisky NAS (Without Box) 三得利 響 日本調和威士忌 無年份（無盒） ',
        'price': '200',
        'moneyUnit': 'HKD',
        'year': '2009',
        'isSellOut': false,
        'capacity': '700ml',

      },
      {
        'image': 'https://www.myicellar.com/imgstore/s52/husk-distillers-small-batch-hand-crafted-ink-gin-nv-6771.jpg?z=24',
        'title': 'Husk Distillers Small Batch Hand Crafted Ink Gin N.V.',
        'price': '180',
        'moneyUnit': 'HKD',
        'year': '2012',
        'isSellOut': false,
        'capacity': '700ml',

      }
    ];
    List<Widget> list = [];
    for (var i = 0; i < mock.length; i++) {
      list.add(
        
        Container(

          width: screenSize.width / 4 - 100,
          // padding: EdgeInsets.all(30),
          decoration: BoxDecoration(  
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 3.0), //阴影xy轴偏移量
                  blurRadius: 5.0, //阴影模糊程度
                  spreadRadius: 0 //阴影扩散程度
                  )
            ]
          ),
          margin: EdgeInsets.fromLTRB(50, 20, 50, 20),
          child: Stack(
            children: [ 
              Column(
                children: [
                  ClipPath(
                  clipper: BottomClippertest(),
                    child: Container(
                      color: Color(0xffF4D486),
                      height: 150,
                    ),
                  )
                ],
              ),
              Column(
            children: [
              
              Container(
                width: (screenSize.width / 4 - 20) * 0.4,
                height: (screenSize.width / 4 - 20) * 0.4,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular((screenSize.width / 4 - 20) / 2),
                  border: Border.all(color: Color(0xffF4D486), width: 3),
                  image: DecorationImage(
                    image: NetworkImage(mock[i]['image']),
                    fit: BoxFit.cover
                  )

                ),
              ),
              Text(mock[i]['title']),
              Text(mock[i]['year']),
            ]
          ),
            ],
          )
        )
      );
    }


    return Container(
      width: screenSize.width - 500,
      child: Wrap(
        children: list
      ),
    );
  }

  _onScroll(offset) {
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

  Widget get _bannerSwiper {
    List banners = [
      {'image': 'images/bottega-miabi-10487.jpg'},
      {'image': 'images/cbd-plantb-cbd-beer-10691.jpg'},
      {'image': 'images/rp90-orin-swift-10545.jpg'}
    ];
    return Container(
        height: 500,
        child: Swiper(
            itemCount: banners.length,
            autoplay: true,
            duration: 3,
            containerWidth: screenSize.width,
            itemBuilder: (BuildContext context, int index) {
              var cur = banners[index];

              return Container(
                width: screenSize.width,
                // height: screenSize.width / 2,
                child: Image.asset(cur['image'],
                    fit: BoxFit.fill,
                    width: screenSize.width),
              );
            }));
  }
}
class  BottomClippertest extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path=Path();
    path.lineTo(0, 0); //第一个点
    path.lineTo(0, size.height-60);//第二个点
    var firstControlPoint=Offset(size.width/2, size.height);  //曲线开始点
    var firstendPoint=Offset(size.width, size.height-60); // 曲线结束点
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstendPoint.dx, firstendPoint.dy);
    path.lineTo(size.width, size.height-60); //第四个点
    path.lineTo(size.width,0);  // 第五个点
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
