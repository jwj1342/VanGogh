import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});
  //const Placeholder();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:Color(0xf3a7bbae),//背景
        body: Padding(
          padding: EdgeInsets.symmetric(vertical:30,horizontal: 30),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                  '时光清浅处',
                  style: TextStyle(
                    color: Color(0xff252323),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600
                  ),
                  )
                ),
                Container(
                  child: Text(
                  '一步一安然',
                  style: TextStyle(
                    color: Color(0xff252323),
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600
                 ),
                 )
               ),
              const SizedBox(//分割线
                child: Divider(
                color: Colors.black26,
                thickness: 5,
                ),
              ),
              Wrap(
                spacing:8,
                runSpacing:8,
                children:<Widget>[
                  Container(//三个button
                    padding:EdgeInsets .fromLTRB( 0,10, 4, 30),
                    child:ElevatedButton (
                      child:Text('全部'),
                      onPressed:(){},
                      style:ButtonStyle(
                        backgroundColor:MaterialStateProperty.all(CupertinoColors.inactiveGray),
                        foregroundColor:MaterialStateProperty.all(Colors.black),
                        textStyle:MaterialStateProperty.all(TextStyle(fontSize:14)),
                        shape:MaterialStateProperty.all(
                          StadiumBorder(
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(//三个button
                    padding:EdgeInsets .fromLTRB( 0,10, 4, 30),
                    child: ElevatedButton (
                      child:Text('已编辑'),
                        onPressed:(){

                      },
                      style:ButtonStyle(
                        backgroundColor:MaterialStateProperty.all(CupertinoColors.inactiveGray),
                        foregroundColor:MaterialStateProperty.all(Colors.black),
                        textStyle:MaterialStateProperty.all(TextStyle(fontSize:14)),
                        shape:MaterialStateProperty.all(
                          StadiumBorder(
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(//三个button
                    padding:EdgeInsets .fromLTRB( 0,10, 50, 30),
                    child: ElevatedButton (
                      child:Text('已发布'),
                      onPressed:(){},
                      style:ButtonStyle(
                        backgroundColor:MaterialStateProperty.all(CupertinoColors.inactiveGray),
                        foregroundColor:MaterialStateProperty.all(Colors.black),
                        textStyle:MaterialStateProperty.all(TextStyle(fontSize:14)),
                        shape:MaterialStateProperty.all(
                          StadiumBorder(
                          ),
                        ),
                      ),
                    ),
                  ),
                   Wrap(//通过流式布局排列图片
                     spacing:2,
                     runSpacing:5,
                     children :<Widget>[


                     ],
                   )
               ],
             ),
           ],
          ),
        ),
        floatingActionButton://加号
        FloatingActionButton(
        backgroundColor:Colors.orangeAccent,
        onPressed:(){},
        child:IconButton(
        icon:Icon(Icons.add),
        onPressed:(){},
        ),
      ),
    );
  }

}

