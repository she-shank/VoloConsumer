// ignore_for_file: prefer_final_fields, avoid_print

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:tuple/tuple.dart';
import 'package:volo_consumer/services/services.dart';
import 'package:volo_consumer/utils/datamodels/datamodels.dart';
import 'package:volo_consumer/utils/constants/categories.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final DatabaseService _db = GetIt.instance.get<DatabaseService>();
  final AuthenticationService _auth =
      GetIt.instance.get<AuthenticationService>();
  final NavigationService _nav = GetIt.instance.get<NavigationService>();

  String get currentUsername => _auth.activeUser!.username;
  Enduser get currentUser => _auth.activeUser!;

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

  @override
  void onChange(Change<HomeState> change) {
    super.onChange(change);

    // Ready? _readyState;
    // change.currentState.maybeMap(ready: (Ready val) {
    //   _readyState = val;
    // }, orElse: () {
    //   return;
    // });

    // Loading? _loadingState;
    // change.nextState.maybeMap(loading: (Loading val) {
    //   _loadingState = val;
    // }, orElse: () {
    //   return;
    // });

    // if (change.currentState is Ready && change.nextState is Loading) {
    //   if (_readyState!.cat != _loadingState!.cat) {
    //     _savedStates[_readyState!.cat] = _readyState!;
    //     _savedLastDocs[_readyState!.cat] = _lastDoc;
    //   }
    // }

    print(change);
  }

  void requestMorePosts() async {
    int catt = state.maybeMap(ready: (ready) => ready.cat, orElse: () => -1);
    await _getPosts(catt != 0 ? catt : null, _lastDoc)
        .fold((left) => print(left), (right) {
      _lastDoc = right.item2;
      emit(HomeState.ready(posts: right.item1, cat: catt));
    });
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

  void openProfile(String pID) async {
    _nav.pushNamed(routeName: '/profile', arguments: pID);
  }

  //TODO: complete like functinoality
  // toggglelike, has user liked(DataBaseService),
  void toggleLike(String pid, String uid) {}

  BoxDecoration? getBoxDecoration(index) {
    Ready? _readyState;
    state.maybeMap(ready: (Ready val) {
      _readyState = val;
    }, orElse: () {
      return;
    });

    if (_readyState != null) {
      if (_readyState!.cat == index) {
        const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.pink,
              Colors.blue,
            ],
          ),
        );
      }
    }
  }

  TextStyle getTextStyle(index) {
    Ready? _readyState;
    state.maybeMap(ready: (Ready val) {
      _readyState = val;
    }, orElse: () {
      return;
    });

    if (_readyState != null) {
      if (_readyState!.cat == index) {
        return const TextStyle();
      } else {
        return const TextStyle();
      }
    } else {
      return const TextStyle();
    }
  }
}
