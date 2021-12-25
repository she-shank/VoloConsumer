import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volo_consumer/screens/home/logic/home_cubit.dart';
import 'package:volo_consumer/utils/datamodels/datamodels.dart';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:tuple/tuple.dart';
import 'package:volo_consumer/services/services.dart';
import 'package:volo_consumer/temp_models.dart';
import 'package:volo_consumer/utils/datamodels/datamodels.dart';
import 'package:volo_consumer/utils/constants/categories.dart';
import 'package:volo_consumer/widgets/stateful_list_tile.dart';

Post tempPost_1 = Post(
    pID: "lll",
    profileID: "lll",
    mUsername: "Sunny Mobile Repair",
    mPhotoURL: "http://placekitten.com/200/300",
    mRating: "4.5",
    createDT: DateTime.now(),
    pImageURL: "http://placekitten.com/400/400",
    mGeoHash: "e9ss",
    pCat: 0,
    likeCount: 23);

Post tempPost_2 = Post(
    pID: "lll",
    profileID: "lll",
    mUsername: "Bhasin Brothers",
    mPhotoURL: "http://placekitten.com/200/300",
    mRating: "3.0",
    createDT: DateTime.now(),
    pImageURL: "http://placekitten.com/400/400",
    mGeoHash: "e9ss",
    pCat: 1,
    likeCount: 23);

Post tempPost_3 = Post(
    pID: "lll",
    profileID: "lll",
    mUsername: "Service Center",
    mPhotoURL: "http://placekitten.com/200/300",
    mRating: "4.5",
    createDT: DateTime.now(),
    pImageURL: "http://placekitten.com/400/400",
    mGeoHash: "e9ss",
    pCat: 2,
    likeCount: 23);

List<Post> tempPostList = [tempPost_1, tempPost_2, tempPost_3, tempPost_1];

Profile tempProfile = Profile(
    profileID: "profileID",
    mID: "mID",
    mUsername: "CinePolis",
    mProfileDesc:
        "Lorem ipsum dolor sit amet, consectetur adiscing elit. Etiam accumsan, urna vel suscipit feugiat, erat sapien arcu, a sodales leo libero ac mauris. Duis ornare turpis ut orci vehicula iaculis.",
    mAddress: "Patrakarpuram, Lucknow",
    mContactNumber: "1231231231",
    mGeoPoint: GeoPoint(100.4, 49.1),
    mRating: 4.2,
    totalLikeCount: 2300,
    reviewCount: 10);

Enduser tempUser = Enduser(uID: "Lol", userType: "Lol", username: "Lakhan");

// ignore_for_file: prefer_final_fields, avoid_print

class HomeCubit extends Cubit<HomeState> {
  final DatabaseService _db = GetIt.instance.get<DatabaseService>();
  final AuthenticationService _auth =
      GetIt.instance.get<AuthenticationService>();
  final NavigationService _nav = GetIt.instance.get<NavigationService>();

  //TODO: change unnecccessary globalkey to local or object key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  final GlobalKey<StfulListTileState> logOutListTileKey =
      GlobalKey<StfulListTileState>();

  // String get currentUsername => "Rahul";
  // Enduser get currentUser => tempUser;

  DocumentSnapshot? _lastDoc;
  List<HomeState?> _savedStates = List.filled(categories.length, null);
  List<DocumentSnapshot?> _savedLastDocs = List.filled(categories.length, null);

  void _saveStateData() {
    state.map(
        loading: (loading) => {},
        ready: (ready) {
          _savedStates[ready.cat] = ready;
          _savedLastDocs[ready.cat] = _lastDoc;
        },
        error: (_) => {});
  }

  Future<Either<String, Tuple2<List<Post>, DocumentSnapshot>>> _getPosts(
      int? category, DocumentSnapshot? lastdoc) async {
    return await _db.getPostsPaginated(
        category: (category != null) ? category - 1 : null, lastdoc: lastdoc);
  }

  void _initializeCubit() async {
    await _getPosts(null, null).fold((left) => print(left), (right) {
      _lastDoc = right.item2;
      emit(HomeState.ready(posts: right.item1, cat: 0));
    });
  }

  HomeCubit() : super(const HomeState.loading()) {
    _initializeCubit();
  }

  void requestMorePosts() async {
    List<Post>? result;
    int catt = state.maybeMap(
        ready: (ready) {
          print(ready.cat);
          return ready.cat;
        },
        orElse: () => -1);

    await _getPosts(catt != 0 ? catt : null, _lastDoc).fold((left) {
      print(left);
    }, (right) {
      result = right.item1;
      _lastDoc = right.item2;
    });

    state.maybeMap(
      ready: (Ready readyState) {
        List<Post>? templist = readyState.posts;
        if (result != null) {
          templist.addAll(result!);
        }
        emit(HomeState.ready(posts: templist, cat: catt));
      },
      orElse: () {},
    );
  }

  void changeCategory(int newCat) async {
    if (newCat ==
        state.maybeMap(ready: (ready) => ready.cat, orElse: () => -1)) {
      return;
    }

    _saveStateData();

    emit(const HomeState.loading());

    if (_savedStates[newCat] == null) {
      await _getPosts(newCat, null).fold((left) => print(left), (right) {
        _lastDoc = right.item2;
        emit(HomeState.ready(posts: right.item1, cat: newCat));
      });
    } else {
      _lastDoc = _savedLastDocs[newCat]!;
      emit(_savedStates[newCat]!);
    }
  }
}
