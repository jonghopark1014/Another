import 'package:another/screens/feed/api/feed_api.dart';
import 'package:another/screens/feed/detail_feed.dart';
import 'package:flutter/material.dart';

class ImageBox extends StatefulWidget {
  const ImageBox({Key? key}) : super(key: key);

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  List<String> _thumbnailUrls = [];

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }


  Future<void> _loadFeed() async {
    try {
      final response = await FeedApi.getFeed();
      print(response['feedId']);
      print(response['runningTime']);
      print(response['runningDistance']);
      print(response['walkCount']);
      print(response['thumbnail']);

      setState(() {

        _thumbnailUrls.add(response['thumbnail']);
      });
    } catch (e) {
      print(e);
    }
  }






  @override
  Widget build(BuildContext context) {
    print(_thumbnailUrls);
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0),
        itemCount: 30,
        itemBuilder: (context, index) {
          return InkWell(
            child: _buildListItem(context, index),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DetailFeed(),
              ));
            },
          );
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
