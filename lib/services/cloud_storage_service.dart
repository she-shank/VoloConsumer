import 'package:either_dart/either.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class CloudStorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Either<String, UploadTask> uploadImage(
      String destination, File imageToUpload) {
    try {
      Reference ref = storage.ref(destination);
      return Right(ref.putFile(imageToUpload));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
