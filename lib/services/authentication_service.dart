import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:volo_consumer/services/database_service.dart';
import 'package:volo_consumer/utils/datamodels/enduser.dart';
import 'package:get_it/get_it.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _dbService = GetIt.instance.get<DatabaseService>();

  Enduser? _activeUser;
  Enduser? get activeUser => _activeUser;
  bool get isUserSignedIn => _auth.currentUser == null ? false : true;

  AuthenticationService._() {
    _init();
  }
  static final instance = AuthenticationService._();
  //AuthenticationService get instance => _instance;

  void _init() {
    _auth.authStateChanges().listen((user) async {
      if (user == null) {
        _activeUser = null;
      } else {
        _activeUser = await _dbService
            .getUser(user.uid)
            .fold((left) => null, (right) => right);
      }
    });
  }

  Future<Either<String, UserCredential>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential _credentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(_credentials);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserCredential>> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      UserCredential _credentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _dbService.addUser(Enduser(
          uID: _credentials.user!.uid, username: username, userType: "user"));

      //to ensure activeuser is updated after signup as authStateChanges stream
      //will be updated immediately after sign up and the user record may have
      //added to the database
      _activeUser = await _dbService
          .getUser(_credentials.user!.uid)
          .fold((left) => null, (right) => right);

      return Right(_credentials);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> signOut() async {
    try {
      await _auth.signOut();
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserCredential>> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return Right(await _auth.signInWithCredential(credential));
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }
}
