import 'package:fashion_outfit/data/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:collection/collection.dart';

class WeatherApi {
  final BASE_URL = 'http://apis.data.go.kr';

  final String key = 'your api key';

  Future<List<Weather>> getWeather(int x, int y, int data, String baseTime) async {
    Uri url = Uri.parse('$BASE_URL/1360000/VilageFcstInfoService_2.0/getVilageFcst?'
        'serviceKey=$key&'
        'pageNo=1&'
        'numOfRows=130&'
        'dataType=JSON&'
        'base_date=$data&'
        'base_time=$baseTime&'
        'nx=$x&'
        'ny=$y');

    final response = await http.get(url);

    List<Weather> weather = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      var res = json.decode(body) as Map<String, dynamic>;
      List<dynamic> _data = [];
      _data = res['response']['body']['items']['item'] as List<dynamic>;
      final data = groupBy(_data, (dynamic obj) => '${obj['fcstTime']}').entries.toList();

      for(final _r in data) {
        final _data = {
          'fcstTime': _r.key,
          'fcstDate': _r.value.first['fcstDate'],
        };

        for(final _d in _r.value) {
          _data[_d['category']] = _d['fcstValue'];
        }

        final w = Weather.fromJson(_data);
        weather.add(w);
      }

      return weather;
    } else {
      return [];
    }
  }
}