class Weather {
  String? date;
  String? time;
  int? pop;
  int? pty;
  String? pcp;
  int? sky;
  double? wsd;
  int? tmp;
  int? reh;

  Weather({this.date, this.time, this.pop, this.pty, this.pcp, this.sky, this.wsd, this.tmp, this.reh});

  factory Weather.fromJson(Map<String, dynamic> data) {
    return Weather(
      date: data['fcstDate'] ?? '',
      time: data['fcstTime'] ?? '',
      pop: int.tryParse(data['POP'] ?? '') ?? 0,
      pty: int.tryParse(data['PTY'] ?? '') ?? 0,
      pcp: data['PCP'] ?? '',
      sky: int.tryParse(data['SKY'] ?? '') ?? 0,
      wsd: double.tryParse(data['WSD'] ?? '') ?? 0.0,
      tmp: int.tryParse(data['TMP'] ?? '') ?? 0,
      reh: int.tryParse(data['REH'] ?? '') ?? 0,
    );
  }
}