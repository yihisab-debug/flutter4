import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _messaging = FirebaseMessaging.instance;
  static final _local = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _messaging.requestPermission();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _local.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((msg) {
      final n = msg.notification;
      if (n != null) _showLocal(n.title ?? '', n.body ?? '');
    });
  }

  static Future<String?> getToken() => _messaging.getToken();

  static Future<void> _showLocal(String title, String body) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'shopping_channel',
        'Shopping',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await _local.show(0, title, body, details);
  }

  static Future<void> scheduleReminder(
    String title,
    String body,
    int delayMinutes,
  ) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'shopping_reminder',
        'Reminders',
        importance: Importance.high,
      ),
    );
    await _local.show(1, title, body, details);
  }
}
