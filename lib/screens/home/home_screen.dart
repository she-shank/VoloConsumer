import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volo_consumer/screens/home/logic/home_cubit.dart';
import 'package:volo_consumer/utils/constants/categories.dart';
import 'package:volo_consumer/widgets/load_post.dart';
import 'package:volo_consumer/widgets/post_holder.dart';
import 'package:volo_consumer/widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
          drawer: SideMenu(),
          body: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: <Widget>[
                    SliverAppBar(
                      expandedHeight: 135,
                      automaticallyImplyLeading: false,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              //TODO : GiveTextStyle to both
                              TextSpan(text: "Welcome"),
                              TextSpan(
                                  text:
                                      context.read<HomeCubit>().currentUsername)
                            ],
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return SliverAppBar(
                          elevation: 0,
                          pinned: true,
                          automaticallyImplyLeading: false,
                          backgroundColor: Colors.white,
                          flexibleSpace: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Row(
                                children: List<Widget>.generate(
                                    (categories.length * 2) - 1, (index) {
                                  if (index.isEven) {
                                    return Container(
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
                    BlocBuilder<HomeCubit, HomeState>(
                      bloc: context.read<HomeCubit>(),
                      builder: (context, state) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return state.map(
                                  loading: (_) => const PostHolderLoading(),
                                  ready: (readyState) {
                                    if (index == readyState.posts.length) {
                                      return LoadPostWidget(
                                          requestPosts: context
                                              .read<HomeCubit>()
                                              .requestMorePosts);
                                    }
                                    PostHolder(post: readyState.posts[index]);
                                  },
                                  error: (_) => const PostHolderLoading());
                            },
                            childCount: state.map(
                                loading: (_) => 2,
                                ready: (readyState) =>
                                    readyState.posts.length + 1,
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
      ),
    );
  }
}
