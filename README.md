# fl_baidu_mob_stat_ys

百度移动统计Flutter插件

## 开始使用

- 安卓初始化。IOS 不需要这一步
```dart
Future<void> fun() async {
   if(Platform.isAndroid){
      await FlBaiduMobStatYs().init();
    }
}

```

- 注册key
```dart
Future<void> fun() async {
  final bool key = await FlBaiduMobStatYs().setApiKey(
      androidKey: 'androidKey', iosKey: 'iosKey');
     print('初始化是否成功：$key');
}

```

- 设置channel (可选)
```dart
Future<void> fun() async {
   final bool channel = await FlBaiduMobStatYs().setAppChannel(channelName);
   print('设置channel：$channelName = $channel');
}

```

- 设置version (可选)
```dart
Future<void> fun() async {
    final bool version = await FlBaiduMobStatYs().setAppVersionName('1.0.0');
    print('设置version name：$version');
}

```
- 是否开启debug模式 (可选)
```dart
Future<void> fun() async {
     final bool debug = await FlBaiduMobStatYs().setDebug(true);
     print('设置是否开启debug模式：$debug');
}

```

- 获取SDK生成的设备的测试ID
```dart
Future<void> fun()async{
   final String? id = await FlBaiduMobStatYs().getTestDeviceId();
}
```

- 获取SDK生成的设备的cuId  （android 上获取为空字符串）
```dart
Future<void> fun()async{
   final String? id = await  FlBaiduMobStatYs().getDeviceCuId();
}
```

- 记录一次事件的点击。
```dart
Future<void> fun()async{
   final bool state = await FlBaiduMobStatYs().logEvent(
                       eventId: 'Event1',
                       attributes: <String, String>{'k1': 'v1', 'k2': 'v2'});
}
```

- 记录一次事件的时长。
```dart
Future<void> fun()async{
   final bool state = await FlBaiduMobStatYs().logDurationEvent(
                     eventId: 'Event2',
                     duration: 3000,
                     label: 'event',
                     attributes: <String, String>{'k1': 'v1'});
}
```

- 记录一次事件的开始。
```dart
Future<void> fun()async{
   final bool state = await FlBaiduMobStatYs().eventStart(eventId: 'Event3');
}
```

- 记录一次事件的结束。
```dart
Future<void> fun()async{
   final bool state = await FlBaiduMobStatYs().eventEnd(
                       eventId: 'Event3',
                       attributes: <String, String>{'k1': 'v1'});
}
```

- 记录某个页面访问的开始。
```dart
Future<void> fun()async{
   final bool state = await FlBaiduMobStatYs().pageStart('AnotherPage');
}
```

- 记录某个页面访问的结束。
```dart
Future<void> fun()async{
   final bool state = await FlBaiduMobStatYs().pageEnd('AnotherPage');
}
```
