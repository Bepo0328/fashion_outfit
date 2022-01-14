import 'package:fashion_outfit/data/api.dart';
import 'package:fashion_outfit/data/weather.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[level],
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 65.0),
            const Text(
              '종로구',
              textAlign: TextAlign.center,
              style: TextStyle(
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
                const Text(
                  '26°C',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      '1월 14일',
                      style: TextStyle(
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
            Container(
              height: 150.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(10, (idx) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '온도',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                        const Text(
                          '강수 확률',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                        Container(
                          width: 50.0,
                          height: 50.0,
                          child: Image.asset(sky[level]),
                          alignment: Alignment.centerRight,
                        ),
                        const Text(
                          '0800',
                          style: TextStyle(
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final api = WeatherApi();
          List<Weather> weather = await api.getWeather(1, 1, 20220114, '2300');
          for (final w in weather) {
            print(w.date);
            print(w.time);
            print(w.tmp);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
