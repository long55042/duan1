import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService{
  final String key = 'AIzaSyCBy3SnVXmun02WKq3NNKMwwzp3LyitrzA';

  Future<String> getPlaceId(String input) async{
    final String url = '';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    var placeId = json['cadidates'][0]['place_Id'] as String;
    print(placeId);
    return placeId;
  }
  Future<Map<String, dynamic>> getPlace(String input) async{
    final placeId = await getPlaceId(input);
    final String url = '';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    var results = json['result'] as Map<String, dynamic>;
    print(results);
    return results;
  }
  Future<Map<String, dynamic>> getDirections(String origin, String destination) async{
    final String url = '';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southeast'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded': PolylinePoints().decodePolyline(json['routes'][0]['overview_polyline']['points']),
    };
    print(results);
    return results;
  }
}
