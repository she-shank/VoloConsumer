import 'package:volo_consumer/utils/datamodels/datamodels.dart';

Post tempPost_1 = Post(
    pID: "lll",
    profileID: "lll",
    mUsername: "Sunny Mobile Repair",
    mPhotoURL: "http://placekitten.com/200/300",
    mRating: "4.5",
    createDT: DateTime.now().toString(),
    pImageURL: "http://placekitten.com/400/400",
    pCat: 0,
    likeCount: 23);

Post tempPost_2 = Post(
    pID: "lll",
    profileID: "lll",
    mUsername: "Bhasin Brothers",
    mPhotoURL: "http://placekitten.com/200/300",
    mRating: "3.0",
    createDT: DateTime.now().toString(),
    pImageURL: "http://placekitten.com/400/400",
    pCat: 1,
    likeCount: 23);

Post tempPost_3 = Post(
    pID: "lll",
    profileID: "lll",
    mUsername: "Service Center",
    mPhotoURL: "http://placekitten.com/200/300",
    mRating: "4.5",
    createDT: DateTime.now().toString(),
    pImageURL: "http://placekitten.com/400/400",
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
    mLat: 2.2,
    mLong: 2.2,
    mRating: 4.2,
    totalLikeCount: 2300,
    reviewCount: 10);

Enduser tempUser = Enduser(uID: "Lol", userType: "Lol", username: "Lakhan");
