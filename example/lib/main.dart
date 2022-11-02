import 'dart:async';
import 'dart:io';
import 'package:fl_baidu_mob_stat_ys/fl_baidu_mob_stat_ys.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bool key = await FlBaiduMobStatYs()
      .setApiKey(androidKey: 'androidKey', iosKey: 'iosKey');
  debugPrint('初始化是否成功：$key');

  String channelName = 'flutter';
  if (Platform.isAndroid) channelName += '- Android';
  if (Platform.isIOS) channelName += '- IOS';

  final bool channel = await FlBaiduMobStatYs().setAppChannel(channelName);
  debugPrint('设置channel：$channelName = $channel');

  final bool version = await FlBaiduMobStatYs().setAppVersionName('1.0.0');
  debugPrint('设置version name：$version');

  final bool debug = await FlBaiduMobStatYs().setDebug(true);
  debugPrint('设置是否开启debug模式：$debug');

  runApp(MaterialApp(
    home: _MyApp(),
    debugShowCheckedModeBanner: false,
    title: 'FlBaiduMobStatYs',
  ));
}

class _MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  bool _eventStartEndButtonSelected = false;
  String text = '';

  Future<void> _getDeviceCuId() async {
    final String? cuId = await FlBaiduMobStatYs().getDeviceCuId();
    if (cuId == null) return;
    text = 'CuId:\n' + cuId;
    setState(() {});
  }

  Future<void> _getTestDeviceId() async {
    final String? id = await FlBaiduMobStatYs().getTestDeviceId();
    if (id == null) return;
    text = 'TestId\n' + id;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FlBaiduMobStatYs Example')),
      body: Center(
        child: Column(children: <Widget>[
          Container(
              height: 100, child: Text(text), alignment: Alignment.center),
          ElevatedButton(
              child: const Text('logEvent'),
              onPressed: () async {
                final bool state = await FlBaiduMobStatYs().logEvent(
                    eventId: 'Event1',
                    attributes: <String, String>{'k1': 'v1', 'k2': 'v2'});
                text = 'logEvent: $state';
                setState(() {});
              }),
          ElevatedButton(
              child: const Text('logDurationEvent'),
              onPressed: () async {
                final bool state = await FlBaiduMobStatYs().logDurationEvent(
                    eventId: 'Event2',
                    duration: 3000,
                    label: 'event',
                    attributes: <String, String>{'k1': 'v1'});
                text = 'logDurationEvent: $state';
                setState(() {});
              }),
          ElevatedButton(
              child: Text(
                  _eventStartEndButtonSelected ? 'eventEnd' : 'eventStart'),
              onPressed: () async {
                _eventStartEndButtonSelected = !_eventStartEndButtonSelected;
                if (_eventStartEndButtonSelected) {
                  final bool state =
                      await FlBaiduMobStatYs().eventStart(eventId: 'Event3');
                  text = 'eventStart: $state';
                } else {
                  final bool state = await FlBaiduMobStatYs().eventEnd(
                      eventId: 'Event3',
                      attributes: <String, String>{'k1': 'v1'});
                  text = 'eventEnd: $state';
                }
                setState(() {});
              }),
          ElevatedButton(
              child: const Text('open page'),
              onPressed: () async {
                final bool state =
                    await FlBaiduMobStatYs().pageStart('AnotherPage');
                text = 'pageStart: $state';
                setState(() {});
              }),
          ElevatedButton(
              child: const Text('close page'),
              onPressed: () async {
                final bool state =
                    await FlBaiduMobStatYs().pageEnd('AnotherPage');
                text = 'pageEnd: $state';
                setState(() {});
              }),
          ElevatedButton(
              child: const Text('getDeviceCuId'), onPressed: _getDeviceCuId),
          ElevatedButton(
              child: const Text('getTestDeviceId'),
              onPressed: _getTestDeviceId),
        ]),
      ),
    );
  }
}
