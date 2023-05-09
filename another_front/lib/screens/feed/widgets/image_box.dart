import 'package:another/constant/color.dart';
import 'package:another/constant/text_style.dart';
import 'package:another/screens/feed/detail_feed.dart';
import 'package:flutter/material.dart';

class ImageBox extends StatefulWidget {
  List<String> thumbnailUrls = [];
  List<String> runningIds = [];
  List<String> runningTimes = [];
  List<String> runningDistances = [];
  List<String> kcals = [];

  ImageBox({
    required this.thumbnailUrls,
    required this.runningIds,
    required this.runningTimes,
    required this.runningDistances,
    required this.kcals,
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
        itemCount: widget.thumbnailUrls.length,
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
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
        Positioned(
          bottom: 8.0,
          width: 110.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.runningDistances[index],
                style: MyTextStyle.fourteenTextStyle.copyWith(
                  color: WHITE_COLOR,
                ),
              ),
              Text(
                widget.kcals[index],
                style: MyTextStyle.fourteenTextStyle.copyWith(
                  color: WHITE_COLOR,
                ),
              ),
              Text(
                widget.runningTimes[index],
                style: MyTextStyle.fourteenTextStyle.copyWith(
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
