import 'package:fashion_outfit/data/weather.dart';
import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  List<LocationData> locations = [
    LocationData(name: '동작구', x: 0, y: 0, lat: 37.4965953, lng: 126.9442389),
    LocationData(name: '용산구', x: 0, y: 0, lat: 37.5309894, lng: 126.9809114),
    LocationData(name: '강동구', x: 0, y: 0, lat: 37.5488877, lng: 127.1464473),
    LocationData(name: '서초구', x: 0, y: 0, lat: 37.4785856, lng: 127.0378328),
    LocationData(name: '도봉구', x: 0, y: 0, lat: 37.6664809, lng: 127.031868),
    LocationData(name: '구로구', x: 0, y: 0, lat: 37.4950165, lng: 126.8580211),
    LocationData(name: '은평구', x: 0, y: 0, lat: 37.617591, lng: 126.9227168),
    LocationData(name: '송파구', x: 0, y: 0, lat: 37.5041561, lng: 127.1145053),
    LocationData(name: '강서구', x: 0, y: 0, lat: 37.5658778, lng: 126.82286),
    LocationData(name: '양천구', x: 0, y: 0, lat: 37.5268414, lng: 126.8558701),
    LocationData(name: '성동구', x: 0, y: 0, lat: 37.5505429, lng: 127.0408531),
    LocationData(name: '강남구', x: 0, y: 0, lat: 37.4959668, lng: 127.0674358),
    LocationData(name: '마포구', x: 0, y: 0, lat: 37.5622856, lng: 126.9087601),
    LocationData(name: '서대문구', x: 0, y: 0, lat: 37.5822045, lng: 126.9358821),
    LocationData(name: '강북구', x: 0, y: 0, lat: 37.6467882, lng: 127.0149297),
    LocationData(name: '동대문구', x: 0, y: 0, lat: 37.583842, lng: 127.050783),
    LocationData(name: '성북구', x: 0, y: 0, lat: 37.6064386, lng: 127.0234837),
    LocationData(name: '광진구', x: 0, y: 0, lat: 37.5481788, lng: 127.085671),
    LocationData(name: '중랑구', x: 0, y: 0, lat: 37.5953615, lng: 127.094155),
    LocationData(name: '금천구', x: 0, y: 0, lat: 37.4600806, lng: 126.9001305),
    LocationData(name: '영등포구', x: 0, y: 0, lat: 37.5206852, lng: 126.9138776),
    LocationData(name: '관악구', x: 0, y: 0, lat: 37.4653743, lng: 126.9436746),
    LocationData(name: '종로구', x: 0, y: 0, lat: 37.599253, lng: 126.9860953),
    LocationData(name: '중구', x: 0, y: 0, lat: 37.5579348, lng: 126.9941819),
    LocationData(name: '노원구', x: 0, y: 0, lat: 37.655214, lng: 127.0770748),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: List.generate(locations.length, (idx) {
          return ListTile(
            onTap: () {
              Navigator.pop(context, locations[idx]);
            },
            title: Text('${locations[idx].name}'),
            trailing: const Icon(Icons.arrow_forward),
          );
        }),
      ),
    );
  }
}
