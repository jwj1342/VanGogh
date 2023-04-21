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
        body: Padding(
            padding: EdgeInsets.symmetric(vertical:30,horizontal: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      child: Text(
                        '生有热烈',
                        style: TextStyle(
                            color: Color(0xff252323),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600
                        ),
                      )
                  ),
                  Container(
                      child: Text(
                        '藏与俗常',
                        style: TextStyle(
                            color: Color(0xff252323),
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600
                        ),
                      )
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 40,bottom: 20),
                      child: Text(
                        '不同的流派画作',
                        style: TextStyle(
                          color: Color(0xff252323),
                          fontSize: 20.0,
                        ),
                      )
                  ),
                  Container(
                    height: 180,
                    child: new ListView(
                        scrollDirection: Axis.horizontal,
                        children:<Widget> [
                          new InkWell(
                            onTap: (){},
                            child: new Container(

                              decoration: ShapeDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage("images/placeholder.jpg"),
                                      fit: BoxFit.fitWidth),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusDirectional.circular(20))),
                              width: 250,
                              child: const Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "印象派",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          new Container(
                            width: 10,
                          ),
                          new InkWell(
                            onTap: (){},
                            child: new Container(
                              decoration: ShapeDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage("images/placeholder.jpg"),
                                      fit: BoxFit.fitWidth),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusDirectional.circular(20))),
                              width: 250,
                              child: const Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "后印象派",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          new Container(
                            width: 10,
                          ),
                          new InkWell(
                            onTap: (){},
                            child: new Container(
                              decoration: ShapeDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage("images/placeholder.jpg"),
                                      fit: BoxFit.fitWidth),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusDirectional.circular(20))),
                              width: 250,
                              child: const Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "抽象派",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          new Container(
                            width: 10,
                          ),
                          new InkWell(
                            onTap: (){},
                            child: new Container(
                              decoration: ShapeDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage("images/placeholder.jpg"),
                                      fit: BoxFit.fitWidth),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusDirectional.circular(20))),
                              width: 250,
                              child: const Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "实派",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 40,bottom: 20),
                      child: Text(
                        '用户的创作',
                        style: TextStyle(
                          color: Color(0xff252323),
                          fontSize: 20.0,
                        ),
                      )
                  ),
                  Container(
                      height: 200,
                      child: Placeholder())
                ]
            )
        ));
  }
}

// ？未来会用到的搜索框
// class SearchAppBar extends StatelessWidget {
//   const SearchAppBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 32, //搜索框高度
//       decoration: BoxDecoration(
//         color: const Color(0xFFF2F2F2), // 搜索框背景色-灰色
//         borderRadius: BorderRadius.circular(16), // 设置搜索框圆角
//       ),
//       child: Row(
//         children: const [
//           SizedBox(
//             width: 32,
//             height: 24,
//             child:
//                 Icon(Icons.search, size: 16, color: Color(0xFF999999)), //搜索框图标
//           ),
//         ],
//       ),
//     );
//   }
// }
