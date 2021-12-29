import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

class URLLauncher {
  static Future<bool> openMapWithGeoPoint(
      {required GeoPoint geoPoint, String? placeID}) async {
    Uri uri;
    if (Platform.isAndroid) {
      Map<String, dynamic> queryParameters = {
        'query': "${geoPoint.latitude},${geoPoint.longitude}"
      };
      if (placeID != null) {
        queryParameters['query_place_id'] = placeID;
      }
      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: queryParameters);

      //} else if (Platform.isIOS) {
    } else {
      Map<String, dynamic> queryParameters = {
        'api': '1',
        'query': "${geoPoint.latitude},${geoPoint.longitude}"
      };
      if (placeID != null) {
        queryParameters['query_place_id'] = placeID;
      }
      uri = Uri.https('www.google.com', '/maps/search/', queryParameters);
    }
    if (await canLaunch(uri.toString())) {
      return await launch(uri.toString());
    } else {
      //return fsilure
      return false;
    }
    ;
  }

  static bool openDialerWithNumber(String number) {
    if (Platform.isAndroid) {
    } else if (Platform.isIOS) {
    } else {}
    return true;
  }
}


//  var uri;

//     if (kIsWeb) {
//       uri = Uri.https('www.google.com', '/maps/search/',
//           {'api': '1', 'query': '$latitude,$longitude'});
//     } else if (Platform.isAndroid) {
//       var query = '$latitude,$longitude';

//       if (label != null) query += '($label)';

//       uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
//     } else if (Platform.isIOS) {
//       var params = {'ll': '$latitude,$longitude'};

//       if (label != null) params['q'] = label;

//       uri = Uri.https('maps.apple.com', '/', params);
//     } else {
//       uri = Uri.https('www.google.com', '/maps/search/',
//           {'api': '1', 'query': '$latitude,$longitude'});
//     }