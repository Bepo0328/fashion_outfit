import 'package:fashion_outfit/data/preference.dart';
import 'package:fashion_outfit/data/weather.dart';
import 'package:flutter/material.dart';

class ClothPage extends StatefulWidget {
  const ClothPage({Key? key}) : super(key: key);

  @override
  _ClothPageState createState() => _ClothPageState();
}

class _ClothPageState extends State<ClothPage> {
  List<ClothTmp> clothes = [];
  List<List<String>> sets = [
    [
      'assets/img/shirt.png',
      'assets/img/short.png',
      'assets/img/pants.png',
    ],
    [
      'assets/img/jumper.png',
      'assets/img/long.png',
      'assets/img/short.png',
    ],
    [
      'assets/img/jumper1.png',
      'assets/img/skirts1.png',
      'assets/img/shirts1.png',
    ],
  ];

  void getCloth() async {
    final pref = Preference();
    clothes = await pref.getTmp();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCloth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: List.generate(clothes.length, (idx) {
          return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(sets.length, (_idx) {
                        return InkWell(
                          onTap: () async {
                            clothes[idx].cloth = sets[_idx];
                            final pref = Preference();
                            await pref.setTmp(clothes[idx]);
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children:
                                  List.generate(sets[_idx].length, (__idx) {
                                return Container(
                                  padding: const EdgeInsets.all(8.0),
                                  width: 50.0,
                                  height: 50.0,
                                  child: Image.asset(
                                    sets[_idx][__idx],
                                    fit: BoxFit.contain,
                                  ),
                                );
                              }),
                            ),
                          ),
                        );
                      }),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('닫기'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              child: Column(
                children: [
                  Text('${clothes[idx].tmp}°C'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(clothes[idx].cloth!.length, (_idx) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        width: 100.0,
                        height: 100.0,
                        child: Image.asset(
                          clothes[idx].cloth![_idx],
                          fit: BoxFit.contain,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
