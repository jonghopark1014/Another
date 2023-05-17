import 'package:another/constant/const/color.dart';
import 'package:another/constant/const/text_style.dart';
import 'package:another/screens/feed/detail_feed.dart';
import 'package:flutter/material.dart';

class ImageBox extends StatefulWidget {
  List<String> thumbnailUrls = [];
  List<String> runningIds = [];
  List<String> runningTimes = [];
  List<String> runningDistances = [];
  List<String> userCalories = [];

  ImageBox({
    required this.thumbnailUrls,
    required this.runningIds,
    required this.runningTimes,
    required this.runningDistances,
    required this.userCalories,
    Key? key,
  }) : super(key: key);

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0),
        itemCount: widget.thumbnailUrls.isNotEmpty ? widget.thumbnailUrls.length : 1,
        itemBuilder: (context, index) {
          if (widget.thumbnailUrls.isNotEmpty) {

            return InkWell(
              child: _buildListItem(context, index),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DetailFeed(
                      runningId: widget.runningIds[index],
                    ),
                  ),
                );
              },
            );
          } else{
            return Container(
              height: 180.0,
            );
          }
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Stack(
      children: [
        Image.network(
          widget.thumbnailUrls[index],
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 8.0,
          width: 120.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.runningDistances[index],
                style: MyTextStyle.twelveTextStyle.copyWith(
                  color: WHITE_COLOR,
                ),
              ),
              Text(
                widget.userCalories[index],
                style: MyTextStyle.twelveTextStyle.copyWith(
                  color: WHITE_COLOR,
                ),
              ),
              Text(
                widget.runningTimes[index],
                style: MyTextStyle.twelveTextStyle.copyWith(
                  color: WHITE_COLOR,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
