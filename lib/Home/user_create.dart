import 'package:flutter/material.dart';

import 'UserCreation.dart';
import 'UserCreationAdapter.dart';
import '../Common/RemoteAPI.dart';
class UserCreate extends StatefulWidget {
  const UserCreate({Key? key});

  @override
  State<UserCreate> createState() => _UserCreateState();
}

class _UserCreateState extends State<UserCreate> {
  List<UserCreation> items = [];

  @override
  void initState() {
    super.initState();
    // 从后端获取数据并
    fetchData();
  }

  Future<void> fetchData() async {
    List<Map<String, dynamic>> backendData = await RemoteAPI(context).getRecommendation();
    items = UserCreationAdapter.adapt(backendData);
  }

  @override
  Widget build(BuildContext context) {
    if(items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        // 计算实际索引
        final int itemIndex = index % items.length;
        return CustomWellHorizontalInfinite(
          onTap: () {},
          imagePath: items[itemIndex].imagePath,
          text: items[itemIndex].title,
          width: 250,
          height: 285,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 10); // 设置项之间的间距
      },
      itemCount: 100, // 设置一个足够大的数值，以实现无限滚动
    );
  }
}

class CustomWellHorizontalInfinite extends StatelessWidget {
  const CustomWellHorizontalInfinite({
    Key? key,
    required this.onTap,
    required this.imagePath,
    required this.text,
    required this.width,
    required this.height,
  }) : super(key: key);

  final VoidCallback onTap;
  final String imagePath;
  final String text;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.fitHeight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(20),
          ),
        ),
        width: width,
        height: height,
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
