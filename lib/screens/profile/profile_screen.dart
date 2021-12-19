import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:volo_consumer/screens/profile/logic/profile_cubit.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:volo_consumer/widgets/app_bar_title.dart';

class ProfileScreen extends StatefulWidget {
  final String profileID;
  const ProfileScreen({Key? key, required this.profileID}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileCubit _profileCubit = GetIt.instance.get<ProfileCubit>();

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileCubit.getProfileDetails(widget.profileID);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);

    double pageWidth = _mediaQueryData.size.width;
    double pageHeight = _mediaQueryData.size.height;


    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[400],
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const AppBarTitle(),
          ),
          body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  0,
                  pageHeight * 0.04,
                  0,
                  pageHeight * 0.04,
                ),
                child: CarouselSlider(
                  options: CarouselOptions(
                    initialPage: 1,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                  ),
                  items: state.maybeMap(ready:(Ready readyState)=> readyState.profile.carouselImageURLs!.map((e) => Image.network(e)).toList(),orElse: ()=>[CircularProgressIndicator()])
                ),
              ),
            ),
            SizedBox(
              height: pageHeight * 0.012,
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: pageHeight * 0.01,
                  ),
                  Text(
                    'Fairless Hills',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: pageHeight * 0.045,
                    ),
                  ),
                  SizedBox(
                    height: pageHeight * 0.012,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: pageWidth * 0.045,
                    ),
                    child: Text(
                      'Cafe Barista, dop by for a relaxing cup of coffee accompanied by delicious and unforgetful bagels to go with the soothing atmosphere. ☕ ',
                      style: TextStyle(
                        fontSize: pageHeight * 0.021,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: pageHeight * 0.012,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: pageWidth * 0.045,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Address:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: pageHeight * 0.025,
                          ),
                        ),
                        SizedBox(
                          width: pageWidth * 0.03,
                        ),
                        Text(
                          'Shop no 121 Patrakarpuram \nChauraha Gomtinagar \nLucknow - 226010',
                          style: TextStyle(
                            fontSize: pageHeight * 0.02,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: pageHeight * 0.012,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: pageHeight * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: pageWidth * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.5),
                      color: Colors.white,
                    ),
                    width: pageWidth * 0.47,
                    child: Padding(
                      padding: EdgeInsets.all(
                        pageWidth * 0.03,
                      ),
                      child: GestureDetector(
                        child: Row(
                          children: [
                            Icon(
                              Icons.call,
                              size: pageHeight * 0.045,
                            ),
                            SizedBox(
                              width: pageWidth * 0.03,
                            ),
                            Text(
                              'Call Merchant',
                              style: TextStyle(
                                fontSize: pageHeight * 0.022,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.5),
                      color: Colors.white,
                    ),
                    width: pageWidth * 0.47,
                    child: Padding(
                      padding: EdgeInsets.all(
                        pageWidth * 0.03,
                      ),
                      child: GestureDetector(
                        onTap: () => _profileCubit.openMap(state.maybeMap(orElse: ()=> )),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: pageHeight * 0.045,
                            ),
                            SizedBox(
                              width: pageWidth * 0.03,
                            ),
                            Text(
                              'Open Maps',
                              style: TextStyle(
                                fontSize: pageHeight * 0.022,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: pageHeight * 0.01,
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: pageWidth * 0.045),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Feedback',
                          style: TextStyle(
                            fontSize: pageHeight * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text('View All'),
                            Icon(
                              Icons.chevron_right,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: pageWidth * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        child: Column(
                          children: [
                            Text('Rating'),
                            Icon(Icons.star),
                            Text('4.7/5'),
                          ],
                        ),
                      ),
                      Container(
                        width: pageWidth * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        child: Column(
                          children: [
                            Text('Rating'),
                            Icon(Icons.star),
                            Text('4.7/5'),
                          ],
                        ),
                      ),
                      Container(
                        width: pageWidth * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        child: Column(
                          children: [
                            Text('Rating'),
                            Icon(Icons.star),
                            Text('4.7/5'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: pageHeight * 0.02,
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    'Offers',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: pageHeight * 0.03,
                    ),
                  ),
                  SizedBox(
                    height: pageHeight * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: pageHeight * 0.22,
                        child: Image(
                          image: AssetImage('images/deals.png'),
                        ),
                      ),
                      Container(
                        height: pageHeight * 0.22,
                        child: Image(
                          image: AssetImage('images/deals.png'),
                        ),
                      ),
                      Container(
                        height: pageHeight * 0.22,
                        child: Image(
                          image: AssetImage('images/deals.png'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: pageHeight * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: pageHeight * 0.22,
                        child: Image(
                          image: AssetImage('images/deals.png'),
                        ),
                      ),
                      Container(
                        height: pageHeight * 0.22,
                        child: Image(
                          image: AssetImage('images/deals.png'),
                        ),
                      ),
                      Container(
                        height: pageHeight * 0.22,
                        child: Image(
                          image: AssetImage('images/deals.png'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: pageHeight * 0.04,
            ),
          ],
        ),
      ),
        );
      },
    );
  }
}
