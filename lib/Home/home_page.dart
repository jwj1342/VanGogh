import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vangogh/Home/user_create.dart';

import 'ArticlePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    )); //透明状态栏
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xA6ECE8B9),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    '生有热烈',
                    style: TextStyle(
                        color: Color(0xff252323),
                        fontSize: 28.0,
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    '藏与俗常',
                    style: TextStyle(
                        color: Color(0xff252323),
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 40, bottom: 20),
                      child: const Text(
                        '不同的流派画作',
                        style: TextStyle(
                          color: Color(0xff252323),
                          fontSize: 20.0,
                        ),
                      )),
                  SizedBox(
                    height: 180,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          CustomWellHorizonal(

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ArticlePage(articlePath: 'assets/article/impressionist.md',appBarTitle:'印象派介绍'),
                                ),
                              );
                            },
                            imagePath:"assets/images/impression.jpeg",
                            text: "印象派",
                          ),
                          Container(
                            width: 10,
                          ),
                          CustomWellHorizonal(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ArticlePage(articlePath:'assets/article/巴洛克艺术.md',appBarTitle:'巴洛克艺术'),
                                ),
                              );
                            },
                            imagePath: "assets/images/Baroqueart.webp",
                            text: "巴洛克艺术",
                          ),
                          Container(
                            width: 10,
                          ),
                          CustomWellHorizonal(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ArticlePage(articlePath:'assets/article/表现主义.md',appBarTitle:'表现主义'),
                                ),
                              );
                            },
                            imagePath: "assets/images/expressionism.webp",
                            text: "表现主义",
                          ),
                          Container(
                            width: 10,
                          ),
                        ]),
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 40, bottom: 20),
                      child: const Text(
                        '用户的创作',
                        style: TextStyle(
                          color: Color(0xff252323),
                          fontSize: 20.0,
                        ),
                      )),
                  Expanded(
                    child:
                    Container(
                      height: screenHeight-300,
                      child: UserCreate(),
                    ),)
                ])));
  }
}

class CustomWellHorizonal extends StatelessWidget {
  const CustomWellHorizonal({
    super.key,
    required this.onTap,
    required this.imagePath,
    required this.text,
  });

  final VoidCallback onTap;
  final String imagePath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.fitWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(20),
          ),
        ),
        width: 250,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

