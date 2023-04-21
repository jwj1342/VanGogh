import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xA6ECE8B9),
      appBar: AppBar(
        title: SearchAppBar(),
        backgroundColor:  Color(0xA6ECE8B9),
      ),
      body: Stack(
          children:  <Widget>[
            // Container(
            //   child: Padding(
            //
            //   ),
            // )
            Align(
              alignment: FractionalOffset(0,0),
              child: CustomPaint(
                size: Size(1000,1000),
                painter: MyPainter(),
              ),
            ),
            Align(
                 alignment: FractionalOffset(0.05,0.05),
                 child: Text(
                   '生有热烈',
                   style: TextStyle(
                     color:Color(0xff252323),
                     fontSize: 20.0,
                   ),
                 ),
               ),
               Align(
                 alignment:FractionalOffset(0.05,0.1),
                 child:Text(
                   '藏与俗常',
                   style: TextStyle(
                     color:Color(0xff252323),
                     fontSize: 25.0,
                   ),
                ),
               ),
               Align(
                 alignment: FractionalOffset(0.05,0.23),
                   child:Text(
                      '不同的流派画作',
                      style: TextStyle(
                      color:Color(0xff252323),
                      fontSize: 17.0,
                      ),
                   )
               ),
            Align(
                child:Padding(
                  padding: const EdgeInsets.only(left: 30,top: 100,right: 30),
                  child:new GridView(
                    padding: EdgeInsets.only(top: 100),
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 30,childAspectRatio: 1.5),
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Container(
                        decoration: ShapeDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/1.jpg"),
                                fit: BoxFit.fitWidth),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.circular(20))),
                        width: 200,
                        height: 150,
                        child: Align(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "印象派",
                              style: TextStyle(color: Colors.white,fontSize: 20,fontWeight:FontWeight.w500),
                            ),
                          ),
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                      Container(
                        decoration: ShapeDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/2.jpg"),
                                fit: BoxFit.fitWidth),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.circular(20))),
                        width: 200,
                        height: 150,
                        child: Align(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "后印象派",
                              style: TextStyle(color: Colors.white,fontSize: 20,fontWeight:FontWeight.w500),
                            ),
                          ),
                          alignment: Alignment.bottomCenter,
                        ),
                      )
                    ],
                  ),
                )
            ),
            Align(
                alignment: FractionalOffset(0.05,0.4),
                child:Padding(
                  padding: const EdgeInsets.only(top: 170),
                    child:Text(
                      '用户的创作',
                      style: TextStyle(
                        color:Color(0xff252323),
                        fontSize: 17.0,
                      ),
                    )
                )
            ),
            Align(
                child:Padding(
                  padding: const EdgeInsets.only(left: 30,top: 430,right: 30),
                  child:new GridView(
                    padding: EdgeInsets.only(top: 1),
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 30,childAspectRatio: 1.5),
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Container(
                        decoration: ShapeDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/3.jpg"),
                                fit: BoxFit.fitWidth),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.circular(20))),
                        width: 150,
                        height: 150,
                      ),
                      Container(
                        decoration: ShapeDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/5.jpg"),
                                fit: BoxFit.fitWidth),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.circular(20))),
                        width: 150,
                        height: 150,
                      ),
                      Container(
                        decoration: ShapeDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/6.jpg"),
                                fit: BoxFit.fitWidth),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.circular(20))),
                        width: 150,
                        height: 150,
                      )
                    ],
                  ),
                )
            ),
          ],
         ),
     );
  }
}

class SearchAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,  //搜索框高度
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),  // 搜索框背景色-灰色
        borderRadius: BorderRadius.circular(16), // 设置搜索框圆角
      ),
      child: Row(
        children: const [
          SizedBox(
            width: 32,
            height: 24,
            child: Icon(Icons.search, size: 16, color: Color(0xFF999999)),  //搜索框图标
          ),
        ],
      ),
    );
  }

}
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //画背景
    var paint = Paint()
      ..isAntiAlias = false
      ..strokeWidth=1.0
      ..color = Colors.orange;
    canvas.drawLine(Offset(0,100), Offset(2000,100), paint..strokeCap);
    canvas.drawLine(Offset(30,0), Offset(30,2000), paint..strokeCap);
  }

  //在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
void main(){
  runApp(
    const MaterialApp(
    home: HomePage(),
  ),
  );
}
