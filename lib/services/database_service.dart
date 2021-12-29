import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:volo_consumer/utils/datamodels/enduser.dart';
import 'package:volo_consumer/utils/datamodels/post.dart';
import 'package:volo_consumer/utils/datamodels/profile.dart';
import 'package:tuple/tuple.dart';

//TODO: get all liked deals
//TODO: update database to support geocoding

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Either<String, List<Post>>> getAllPosts() async {
    try {
      var postsQuerySnapShot = await _db.collection('Posts').get();
      return Right(
          postsQuerySnapShot.docs.map((e) => Post.fromJson(e.data())).toList());
    } catch (e) {
      //print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> addPost({
    required String profileID,
    required String mUsername,
    required String mPhotoURL,
    required String mRating,
    required DateTime createDT,
    required String pImageURL,
    required String mGeoHash,
    required int pCat,
    required int likeCount,
  }) async {
    try {
      String tempID = _db.collection("Posts").doc().id;
      Post tempPost = Post(
          pID: tempID,
          profileID: profileID,
          mUsername: mUsername,
          mPhotoURL: mPhotoURL,
          mRating: mRating,
          createDT: createDT,
          mGeoHash: mGeoHash,
          pImageURL: pImageURL,
          pCat: pCat,
          likeCount: likeCount);

      await _db.collection('Posts').doc(tempID).set(tempPost.toJson());
      await _db
          .collection('Profiles/$profileID/Data')
          .doc('posts_data')
          .update({
        'pList': FieldValue.arrayUnion([tempID])
      });
      await _db
          .collection('Posts/$tempID/Data')
          .doc('likes_data')
          .set({"lList": []});
      return const Right(true);
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, Tuple2<List<Post>, DocumentSnapshot>>>
      getPostsPaginated({int? category, DocumentSnapshot? lastdoc}) async {
    try {
      Query query = _db
          .collection('Posts')
          .orderBy('createDT', descending: true)
          .limit(4);

      if (category != null) {
        query = query.where('pCat', isEqualTo: category);
      }

      if (lastdoc != null) {
        query = query.startAfterDocument(lastdoc);
      }

      var querySnapShot = await query.get();

      return Right(Tuple2<List<Post>, DocumentSnapshot>(
          querySnapShot.docs
              .map((e) => Post.fromJson(e.data() as Map<String, dynamic>))
              .toList(),
          querySnapShot.docs.last));
    } catch (e) {
      //print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> addUser(Enduser user) async {
    try {
      await _db.collection('Users').doc(user.uID).set(user.toJson());
      return const Right(true);
    } catch (e) {
      //print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, Enduser>> getUser(String uid) async {
    try {
      var userDoc = await _db.collection('Users').doc(uid).get();
      return Right(Enduser.fromJson(userDoc.data() as Map<String, dynamic>));
    } catch (e) {
      //print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> addProfile({
    required String mID,
    required String mUsername,
    required String mProfileDesc,
    required String mAddress,
    required String mContactNumber,
    required GeoPoint mGeoPoint,
    List<String>? carouselImageURLs = const <String>[],
  }) async {
    try {
      String tempID = _db.collection("Profiles").doc().id;
      Profile profile = Profile(
          profileID: tempID,
          mID: mID,
          mUsername: mUsername,
          mProfileDesc: mProfileDesc,
          mAddress: mAddress,
          mContactNumber: mContactNumber,
          mGeoPoint: mGeoPoint,
          mRating: 0.0,
          totalLikeCount: 0,
          reviewCount: 0,
          carouselImageURLs: carouselImageURLs);
      await _db.collection('Profiles').doc(tempID).set(profile.toJson());

      //do similar for storing reviews,ratings
      await _db
          .collection('Profiles/$tempID/Data')
          .doc('posts_data')
          .set({"pList": []});
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Profile>> getProfile(String profileID) async {
    try {
      var profileDoc = await _db.collection('Profiles').doc(profileID).get();
      return Right(Profile.fromJson(profileDoc.data() as Map<String, dynamic>));
    } catch (e) {
      //print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> addLike(String uid, String pid) async {
    try {
      await _db.collection('Posts/$pid/Data').doc('likes_data').update({
        "lList": FieldValue.arrayUnion([uid])
      });
      await _db
          .collection('Posts')
          .doc(pid)
          .update({'likeCount': FieldValue.increment(1)});
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> removeLike(String uid, String pid) async {
    try {
      await _db.collection('Posts/$pid/Data').doc('likes_data').update({
        "lList": FieldValue.arrayRemove([uid])
      });
      await _db
          .collection('Posts')
          .doc(pid)
          .update({'likeCount': FieldValue.increment(-1)});
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  // TODO: make has user liked
  // Future<Either<String, bool>> (String uid, String pid) async {
  //   try{

  //     return const Right(true);
  //   } catch(e){
  //     return Left(e.toString());
  //   }
  // }
}
