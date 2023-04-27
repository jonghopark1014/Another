import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  const ImageBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0),
        itemCount: 30,
        itemBuilder: (context, index) {
          return _buildListItem(context, index);
        },
      ),
    );
  }
  Widget _buildListItem(BuildContext context, int index) {
    String img_src =
        'https://cdn.ggilbo.com/news/photo/201812/575659_429788_3144.jpg';
    // 'https://img.hankyung.com/photo/202202/AA.29026718.1-1200x.jpg'
    return Image.network(
      img_src,
      fit: BoxFit.cover,
    );
  }
}