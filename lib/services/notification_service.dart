import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static final onNotifications = BehaviorSubject<String>();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
        enableVibration: true,
        priority: Priority.high,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    tz.initializeTimeZones();
    final android = AndroidInitializationSettings('@drawable/habistic_logo');
    final iOS = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(settings,
        onSelectNotification: ((payload) async {
      onNotifications.add(payload);
    }));
  }

  static Future showScheduledNotification({
    int id = 0,
    String title,
    String body,
    // DateTime scheduleDate,
    Time time,
  }) async =>
      _notifications.zonedSchedule(
        id,
        title,
        body,
        _scheduleDaily(time),
        await _notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    return scheduleDate.isBefore(now)
        ? scheduleDate.add(Duration(days: 1))
        : scheduleDate;
  }
}
