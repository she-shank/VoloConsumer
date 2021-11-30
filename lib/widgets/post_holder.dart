// ignore_for_file: prefer_const_constructors

//TODO: use cubit for profile gesture detector to open profile
//TODO: use screenutil to make sizee responsive

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:volo_consumer/utils/datamodels/post.dart';
import 'package:volo_consumer/widgets/shimmer_shape.dart';

class PostHolder extends StatelessWidget {
  final double pad = 10;
  final Post post;
  const PostHolder({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              pad,
              0,
              pad,
              0,
            ),
            child: Row(children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 4 * pad,
                      backgroundImage: NetworkImage(post.mPhotoURL),
                    ),
                    SizedBox(width: pad),
                    Text(post.mUsername),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Text(DateFormat("d MMM y").format(DateTime.parse(post.createDT))),
            ]),
          ),
          Image.network(
            post.pImageURL,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: LinearProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
          Row(
            children: [
              IconButton(icon: Icon(Icons.thumb_up_outlined), onPressed: () {}),
              SizedBox(
                width: pad,
              ),
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: post.likeCount.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: "people liked this deal")
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              Text("rating: ${post.mRating}/5.0")
            ],
          ),
        ],
      ),
    );
  }
}

class PostHolderLoading extends StatelessWidget {
  const PostHolderLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ShimmerShape.circular(height: 40, width: 40),
            ShimmerShape(
                height: 15,
                width: 200,
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7))),
          ],
        ),
        ShimmerShape.rectangular(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width),
        ShimmerShape(
            height: 15,
            width: 80,
            shapeBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
      ],
    );
  }
}
