import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Store the data from another file widget.
  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    if (kDebugMode) {
      print(data);
    }

    // Set background
    String bgImage = data['isDayNight'] ? 'day.png' : 'night.png';

    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
              child: Column(
                children: [
                  TextButton.icon(
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data = {
                            'time': result['time'],
                            'location': result['location'],
                            'isDayNight': result['isDayNight'],
                            'flag': result['flag'],
                          };
                        });
                      },
                      icon: const Icon(Icons.edit_location),
                      label: const Text('Edit Location')
                  ),
                  const SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data ['location'],
                        style: const TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0,),
                  Text(
                    data['time'],
                    style: const TextStyle(
                      fontSize: 66.0
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
