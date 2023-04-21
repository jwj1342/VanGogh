import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    //TODO: 1.使用Padding来设置顶部两个文字间距，让他俩变得美观一点
    //TODO: 2.对整个首页的Stack进行优化，让他们不会贴到两边，就是之前参考线的位置
    //TODO: 3.图片全部使用占位符代替，等到后面再进行替换
    return Scaffold(
      backgroundColor: const Color(0xA6ECE8B9),
      // appBar: AppBar(
      //   title: const SearchAppBar(),
      //   backgroundColor: const Color(0xA6ECE8B9),
      // ),
      body: Stack(
        children: <Widget>[
          const Align(
            alignment: FractionalOffset(0.05, 0.05),
            child: Text(
              '生有热烈',
              style: TextStyle(
                color: Color(0xff252323),
                fontSize: 25.0,
              ),
            ),
          ),
          const Align(
            alignment: FractionalOffset(0.05, 0.1),
            child: Text(
              '藏与俗常',
              style: TextStyle(
                color: Color(0xff252323),
                fontSize: 30.0,
              ),
            ),
          ),
          const Align(
              alignment: FractionalOffset(0.05, 0.23),
              child: Text(
                '不同的流派画作',
                style: TextStyle(
                  color: Color(0xff252323),
                  fontSize: 17.0,
                ),
              )),
          Align(
              child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 100, right: 30),
            child: GridView(
              padding: const EdgeInsets.only(top: 100),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  childAspectRatio: 1.5),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  decoration: ShapeDecoration(
                      image: const DecorationImage(
                          image: AssetImage("images/placeholder.jpg"),
                          fit: BoxFit.fitWidth),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(20))),
                  width: 200,
                  height: 150,
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "印象派",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: ShapeDecoration(
                      image: const DecorationImage(
                          image: AssetImage("images/2.jpg"),
                          fit: BoxFit.fitWidth),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(20))),
                  width: 200,
                  height: 150,
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "后印象派",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
          const Align(
              alignment: FractionalOffset(0.05, 0.4),
              child: Padding(
                  padding: EdgeInsets.only(top: 170),
                  child: Text(
                    '用户的创作',
                    style: TextStyle(
                      color: Color(0xff252323),
                      fontSize: 17.0,
                    ),
                  ))),
          Align(
              child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 430, right: 30),
            child: GridView(
              padding: const EdgeInsets.only(top: 1),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 30,
                  childAspectRatio: 1.5),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  decoration: ShapeDecoration(
                      image: const DecorationImage(
                          image: AssetImage("images/3.jpg"),
                          fit: BoxFit.fitWidth),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(20))),
                  width: 150,
                  height: 150,
                ),
                Container(
                  decoration: ShapeDecoration(
                      image: const DecorationImage(
                          image: AssetImage("images/5.jpg"),
                          fit: BoxFit.fitWidth),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(20))),
                  width: 150,
                  height: 150,
                ),
                Container(
                  decoration: ShapeDecoration(
                      image: const DecorationImage(
                          image: AssetImage("images/6.jpg"),
                          fit: BoxFit.fitWidth),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(20))),
                  width: 150,
                  height: 150,
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32, //搜索框高度
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2), // 搜索框背景色-灰色
        borderRadius: BorderRadius.circular(16), // 设置搜索框圆角
      ),
      child: Row(
        children: const [
          SizedBox(
            width: 32,
            height: 24,
            child:
                Icon(Icons.search, size: 16, color: Color(0xFF999999)), //搜索框图标
          ),
        ],
      ),
    );
  }
}
