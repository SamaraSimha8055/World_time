import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; // Location name for UI
  late String time; // Time in that location
  late String flag; // Url to an asset flag icon
  late String url; // Location url for api endpoint
  late bool isDayNight; // Boolean to display day/night background

  WorldTime({required this.location, required this.flag, required this.url});
  Future<void> getTime() async {
    //Error Handling
    try {
      // Make the request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //Create dateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set time property
      /*time = now.toString();*/
      isDayNight = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      if (kDebugMode) {
        print('caught error: $e');
        time = 'could not get time data';
      }
    }
  }
}