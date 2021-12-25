// ignore_for_file: prefer_const_constructors

//TODO: use cubit for profile gesture detector to open profile
//TODO: use screenutil to make sizee responsive

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:volo_consumer/screens/home/logic/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volo_consumer/utils/datamodels/post.dart';
import 'package:volo_consumer/widgets/shimmer_shape.dart';

class PostHolder extends StatelessWidget {
  final Post post;
  const PostHolder({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  10,
                  10,
                  10,
                  0,
                ),
                child: Row(children: [
                  GestureDetector(
                    onTap: () =>
                        context.read<HomeCubit>().openProfile(post.profileID),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(post.mPhotoURL),
                        ),
                        SizedBox(width: 10),
                        Text(
                          post.mUsername,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    DateFormat("d MMM y").format(post.createDT),
                    style: TextStyle(fontSize: 17),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Image.network(
                  post.pImageURL,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: LinearProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.thumb_up_outlined), onPressed: () {}),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: post.likeCount.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: " people liked this deal",
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    "rating: ${post.mRating}/5.0",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
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
                width: 10,
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
