// ===== REPOSITORY LAYER =====

// 1. Notification Repository Interface
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:roobai/features/product/data/model/noti_model.dart';

abstract class NotificationRepository {
  Future<void> saveNotification(String key, String value);
  Future<String?> getNotification(String key);
  Future<void> saveNotificationModel(NotiModel notiModel);
  Future<List<NotiModel>> getNotificationModels();
}

// 2. Notification Repository Implementation
class NotificationRepositoryImpl implements NotificationRepository {
  final FlutterSecureStorage _storage;
  
  NotificationRepositoryImpl(this._storage);

  IOSOptions get _getIOSOptions => const IOSOptions(accountName: 'roobai');
  AndroidOptions get _getAndroidOptions => const AndroidOptions(encryptedSharedPreferences: true);

  @override
  Future<void> saveNotification(String key, String value) async {
    await _storage.write(
      key: key, 
      value: value, 
      iOptions: _getIOSOptions, 
      aOptions: _getAndroidOptions
    );
  }

  @override
  Future<String?> getNotification(String key) async {
    return await _storage.read(
      key: key, 
      iOptions: _getIOSOptions, 
      aOptions: _getAndroidOptions
    );
  }

  @override
  Future<void> saveNotificationModel(NotiModel notiModel) async {
    final value = await getNotification('noti_model');
    List<NotiModel> noti = [];
    
    if (value != null && value.isNotEmpty) {
      List responseJson = json.decode(value);
      noti = responseJson.map((m) => NotiModel.fromJson(m)).toList();
    }
    
    noti.add(notiModel);
    String jsonString = jsonEncode(noti);
    await saveNotification('noti_model', jsonString);
  }

  @override
  Future<List<NotiModel>> getNotificationModels() async {
    final value = await getNotification('noti_model');
    if (value != null && value.isNotEmpty) {
      List responseJson = json.decode(value);
      return responseJson.map((m) => NotiModel.fromJson(m)).toList();
    }
    return [];
  }
}

// 3. Local Notification Service Repository
abstract class LocalNotificationRepository {
  Future<void> initialize();
  Future<void> requestPermissions();
  Future<bool> areNotificationsEnabled();
  Future<void> showNotification(int id, String title, String body, {String? payload});
  Future<void> showImageNotification(int id, String title, String body, String imageUrl);
  Stream<String?> get notificationTapStream;
}

class LocalNotificationRepositoryImpl implements LocalNotificationRepository {
  final FlutterLocalNotificationsPlugin _plugin;
  final StreamController<String?> _selectNotificationStream = StreamController<String?>.broadcast();
  
  LocalNotificationRepositoryImpl(this._plugin);

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'roobai',
    'High Importance Notifications',
    importance: Importance.high,
  );

  @override
  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_stat_roobai_logo');
    const initSettings = InitializationSettings(android: androidSettings);
    
    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _selectNotificationStream.add(response.payload);
      },
    );
  }

  @override
  Future<void> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await _plugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (Platform.isAndroid) {
      final androidImplementation = _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      await androidImplementation?.requestNotificationsPermission();
    }
  }

  @override
  Future<bool> areNotificationsEnabled() async {
    if (Platform.isAndroid) {
      return await _plugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
    }
    return true;
  }

  @override
  Future<void> showNotification(int id, String title, String body, {String? payload}) async {
    const androidDetails = AndroidNotificationDetails(
      'roobai',
      'High Importance Notifications',
      showWhen: true,
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
      enableLights: true,
      styleInformation: DefaultStyleInformation(true, true),
    );
    
    const details = NotificationDetails(android: androidDetails);
    await _plugin.show(id, title, body, details, payload: payload);
  }

  @override
  Future<void> showImageNotification(int id, String title, String body, String imageUrl) async {
    final largeIcon = ByteArrayAndroidBitmap(
      await _getByteArrayFromUrl('https://roobai.com/assets/images/android/android-icon-48x48.png')
    );
    final bigPicture = ByteArrayAndroidBitmap(await _getByteArrayFromUrl(imageUrl));

    final bigPictureStyle = BigPictureStyleInformation(
      bigPicture,
      largeIcon: largeIcon,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );

    final androidDetails = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: body,
      showWhen: true,
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
      enableLights: true,
      styleInformation: bigPictureStyle,
    );

    final details = NotificationDetails(android: androidDetails);
    await _plugin.show(id, title, body, details);
  }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  @override
  Stream<String?> get notificationTapStream => _selectNotificationStream.stream;

  void dispose() {
    _selectNotificationStream.close();
  }
}

// 4. Firebase Messaging Repository
abstract class FirebaseMessagingRepository {
  Stream<RemoteMessage> get onMessage;
  Future<void> setupBackgroundMessageHandler();
}

class FirebaseMessagingRepositoryImpl implements FirebaseMessagingRepository {
  @override
  Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;

  @override
  Future<void> setupBackgroundMessageHandler() async {
    // Set up background message handler if needed
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}