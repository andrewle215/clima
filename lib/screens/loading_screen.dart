import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '0d764e81aba4a1294cd8c57f41e77aa8';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}


class _LoadingScreenState extends State<LoadingScreen> {

  late double latitude;
  late double longitude;
  void initState(){
    super.initState();
    getLocation();
  }

  void getLocation() async {
   Location location = Location();
   await location.getCurrentLocation();

   latitude = location.latitude;
   longitude = location.longitude;

   NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat '
       '=$longitude&lon=$longitude&appid=$apiKey&units=metric');
   var weatherdata = await networkHelper.getData();
   
   Navigator.push(context, MaterialPageRoute(builder: (context){
     return LocationScreen(
     //  locationWeather: weatherdata,
     );
   }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 100.0,
          )
      ),
    );
  }
  }

