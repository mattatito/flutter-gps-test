import 'package:flutter/material.dart';
import 'package:gps_test/location_client.dart';
import 'package:gps_test/location_service.dart';

void main() async {
  final locationService = LocationServiceImpl(GeoLocationClient());
  final app = MyApp(
    locationService: locationService,
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  final LocationService locationService;

  const MyApp({Key? key, required this.locationService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(locationService: locationService,),
    );
  }
}

class MyHomePage extends StatefulWidget {

  final LocationService locationService;

  MyHomePage({Key? key,required this.locationService}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _latitude = "";
  String _longitude = "";
  String error = '';
  bool _buttonEnabled = true;

  void _fetchCurrentLocation() async{

    _buttonEnabled = false;
    _latitude = '';
    _longitude = '';
    setState(() {});

    try{
      final currentLocation = await widget.locationService.currentPosition;

      _latitude = currentLocation.latitude.toStringAsFixed(2);
      _longitude = currentLocation.longitude.toStringAsFixed(2);
      _buttonEnabled = true;
    }catch(e){
      error = "Deu ruim";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App location'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(error),
            Text('Latitude: $_latitude '),
            Text('Longitude: $_longitude '),
            Center(
              child: _buttonEnabled
                  ? ElevatedButton(
                      onPressed: _fetchCurrentLocation,
                      child: const Text('Get current location'),
                    )
                  : const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
