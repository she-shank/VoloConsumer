import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volo_consumer/screens/home/logic/home_cubit.dart';
import 'package:volo_consumer/utils/constants/categories.dart';
import 'package:volo_consumer/widgets/app_bar_title.dart';
import 'package:volo_consumer/widgets/load_post.dart';
import 'package:volo_consumer/widgets/post_holder.dart';
import 'package:volo_consumer/widgets/shimmer_shape.dart';
import 'package:volo_consumer/widgets/side_menu.dart';

const gradient = LinearGradient(
  colors: [Colors.pink, Colors.red],
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: context.read<HomeCubit>().scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: context.read<HomeCubit>().devFunc,
        ),
        appBar: AppBar(
          title: const AppBarTitle(),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.purple,
            ),
            onPressed: context.read<HomeCubit>().openDrawer,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.purple,
              ),
              onPressed: () {},
            ),
          ],
        ),
        drawer: const SideMenu(),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    expandedHeight: 54,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Welcome ",
                                style: TextStyle(
                                  fontSize: 40,
                                ),
                              ),
                              BlocBuilder<HomeCubit, HomeState>(
                                  builder: (context, state) {
                                return state.maybeMap(
                                    ready: (_) {
                                      return ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return gradient.createShader(
                                              Offset.zero & bounds.size);
                                        },
                                        child: Center(
                                          child: Text(
                                            context
                                                .read<HomeCubit>()
                                                .currentUsername,
                                            style: new TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    orElse: () => ShimmerShape.rectangular(
                                        height: 10, width: 50));
                              }),
                              Text(
                                ",",
                                style: TextStyle(
                                  fontSize: 40,
                                ),
                              ),
                            ],
                          )
                          // Text.rich(
                          //   TextSpan(
                          //     children: <TextSpan>[
                          //       //TODO : GiveTextStyle to both
                          //       TextSpan(
                          //         text: "Welcome ",
                          //         style: TextStyle(
                          //           fontSize: 40,
                          //         ),
                          //       ),
                          //       TextSpan(
                          //         text:
                          // context.read<HomeCubit>().currentUsername +
                          //     ",",
                          //         style: TextStyle(
                          //             fontSize: 40,
                          //             fontWeight: FontWeight.bold,
                          //             foreground: Paint()
                          //               ..shader = linearGradient),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          ),
                    ),
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    bloc: context.read<HomeCubit>(),
                    builder: (context, state) {
                      return SliverAppBar(
                        collapsedHeight: 90,
                        elevation: 0,
                        pinned: true,
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.grey,
                        flexibleSpace: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: List<Widget>.generate(
                                  (categories.length * 2) - 1, (index) {
                                if (index.isEven) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 6),
                                    decoration: context
                                        .read<HomeCubit>()
                                        .getBoxDecoration(index ~/ 2),
                                    child: TextButton(
                                      onPressed: () {
                                        context
                                            .read<HomeCubit>()
                                            .changeCategory(index ~/ 2);
                                      },
                                      child: Text(
                                        categories[index ~/ 2],
                                        style: context
                                            .read<HomeCubit>()
                                            .getTextStyle(index ~/ 2),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox(
                                    height: 25,
                                    child: VerticalDivider(
                                      color: Colors.black,
                                      thickness: 2,
                                      width: 20,
                                    ),
                                  );
                                }
                              }),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  CupertinoSliverRefreshControl(
                    onRefresh: () async {},
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    bloc: context.read<HomeCubit>(),
                    builder: (context, state) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Stack(
                              children: [
                                state.map(
                                    loading: (_) => Container(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 0,
                                          ),
                                          child: const PostHolderLoading(),
                                        ),
                                    ready: (readyState) {
                                      if (index == readyState.posts.length) {
                                        // context
                                        //     .read<HomeCubit>()
                                        //     .requestMorePosts();
                                        return const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                        // return LoadPostWidget(
                                        //     requestPosts: context
                                        //         .read<HomeCubit>()
                                        //         .requestMorePosts);
                                      } else {
                                        return PostHolder(
                                            post: readyState.posts[index]);
                                      }
                                    },
                                    error: (_) => const PostHolderLoading()),
                                Text(index.toString()),
                              ],
                            );
                          },
                          childCount: state.map(
                              loading: (_) => 2,
                              ready: (readyState) {
                                readyState.posts.length;
                                print("lkjh");
                              },
                              error: (_) => 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
