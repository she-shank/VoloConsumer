import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volo_consumer/services/authentication_service.dart';
import 'package:volo_consumer/utils/locator.dart';

class Init {
  static late final SharedPreferences _prefs;
  static late final bool _userSeenIntro;
  static late final bool _userSignedIn;

  Init._();
  static final instance = Init._();

  Future<String> initialize() async {
    await _registerServices();
    await _registerServices();
    await _loadSettings();
    return _loadInitialRoute();
  }

  static Future<void> _registerServices() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    ServiceLocator.registerLocator();
    //Bloc.observer = MyBlocObserver();
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> _loadSettings() async {
    _userSeenIntro = _prefs.getBool('USER_SEEN_INTRO') ?? false;
    //check here if the user is signed in or not
    _userSignedIn =
        GetIt.instance.get<AuthenticationService>().activeUser != null;
  }

  static String _loadInitialRoute() {
    if (_userSeenIntro && _userSignedIn) {
      return "/home";
    } else if (_userSeenIntro && !_userSignedIn) {
      return "/login";
    } else {
      //await can be used but not bcoz the below line does just needs to be completed once
      //use await and check for error
      _prefs.setBool('USER_SEEN_INTRO', true);
      return "/intro";
    }
  }
}
