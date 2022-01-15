import 'package:fashion_outfit/cloth.dart';
import 'package:fashion_outfit/data/api.dart';
import 'package:fashion_outfit/data/preference.dart';
import 'package:fashion_outfit/data/weather.dart';
import 'package:fashion_outfit/location.dart';
import 'package:fashion_outfit/utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion Outfit App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> clothes = [
    'assets/img/shirt.png',
    'assets/img/short.png',
    'assets/img/pants.png',
  ];
  List<Weather> weather = [];
  List<ClothTmp> tmpCloth = [];
  Weather? current;
  LocationData location =
      LocationData(name: '동작구', x: 0, y: 0, lat: 37.4965953, lng: 126.9442389);
  List<String> sky = [
    'assets/img/sky1.png',
    'assets/img/sky2.png',
    'assets/img/sky3.png',
    'assets/img/sky4.png',
  ];
  List<String> status = [
    '오늘은 날이 맑아요',
    '구름이 조금 있어요',
    '구름이 잔뜩 꼈네요',
    '비 조심하세요',
  ];
  List<Color> colors = [
    const Color(0xFFFE7347),
    const Color(0xFF0197DD),
    const Color(0xFF3839D1),
    const Color(0xFF47728B),
  ];
  int level = 0;

  void getWeather() async {
    final api = WeatherApi();
    final now = DateTime.now();
    Map<String, int> xy = Utils.latLngToXY(location.lat!, location.lng!);

    final pref = Preference();
    tmpCloth = await pref.getTmp();

    int time = int.parse('${now.hour}00');
    String _time = '';

    if (time > 2300) {
      _time = '2300';
    } else if (time > 2000) {
      _time = '2000';
    } else if (time > 1700) {
      _time = '1700';
    } else if (time > 1400) {
      _time = '1400';
    } else if (time > 1100) {
      _time = '1100';
    } else if (time > 800) {
      _time = '0800';
    } else if (time > 500) {
      _time = '0500';
    } else {
      _time = '0200';
    }

    weather = await api.getWeather(
        xy['nx']!, xy['ny']!, Utils.getFormTime(DateTime.now()), _time);

    current = weather.first;
    clothes = tmpCloth.firstWhere((t) => t.tmp! < current!.tmp!).cloth!;
    level = getLevel(current!);

    setState(() {});
  }

  int getLevel(Weather w) {
    if (w.sky! > 8) {
      return 3;
    } else if (w.sky! > 5) {
      return 2;
    } else if (w.sky! > 2) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const ClothPage()));
              getWeather();
            },
            icon: const Icon(Icons.category),
          ),
        ],
      ),
      backgroundColor: colors[level],
      body: weather.isEmpty
          ? Container(
              child: const Text('날씨정보를 불러오고 있어요'),
            )
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${location.name}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0,
                    ),
                    child: Image.asset(sky[level]),
                    alignment: Alignment.centerRight,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text(
                            '${current!.tmp}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 60.0,
                            ),
                          ),
                          const Text(
                            '°C',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${Utils.stringToDateTime(current!.date!).month}월 '
                            '${Utils.stringToDateTime(current!.date!).day}일',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            status[level],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Text(
                      '오늘 어울리는 복장을 추천해 드려요',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(clothes.length, (idx) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        width: 100.0,
                        height: 100.0,
                        child: Image.asset(
                          clothes[idx],
                          fit: BoxFit.contain,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 30.0),
                  Expanded(
                    child: Container(
                      height: 150.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(weather.length, (idx) {
                          final w = weather[idx];
                          int _level = getLevel(w);

                          return Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${w.tmp}°C',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  '${w.pop}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  child: Image.asset(sky[_level]),
                                  alignment: Alignment.centerRight,
                                ),
                                Text(
                                  '${w.time}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          LocationData data = await Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => const LocationPage()));
          location = data;
          getWeather();
        },
        child: const Icon(Icons.location_on),
      ),
    );
  }
}
