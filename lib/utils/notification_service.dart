import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_stat_logo_notifica');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {},
    );
  }

  static Future<void> updateBacNotification({
    required double currentBac,
    required String targetTime,
    required bool isOverLimit,
    required String statusLabel, // <-- Stringa tradotta passata dalla UI
    required String channelName, // <-- Nome canale tradotto
  }) async {
    if (currentBac <= 0) {
      await _notificationsPlugin.cancel(id: 888);
      return;
    }

    String icon = isOverLimit ? "🔴" : "🟢";

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'bac_status_channel',
      channelName, // Nome del canale tradotto
      channelDescription: 'BAC Status Notification',
      importance: Importance.low,
      priority: Priority.low,
      ongoing: true,
      onlyAlertOnce: true,
      showWhen: false,
    );

    NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      id: 888,
      title: "$icon BAC: ${currentBac.toStringAsFixed(2)} g/l",
      body: "$statusLabel $targetTime",
      notificationDetails: platformDetails,
    );
  }
}