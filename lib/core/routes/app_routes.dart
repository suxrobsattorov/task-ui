import 'package:flutter/material.dart';

import '../../features/car_details/presentation/pages/car_details_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/notification/presentation/pages/notification_picker_page.dart';
import '../../features/qr_scan/presentation/pages/qr_scan_page.dart';

abstract final class Routes {
  static const String qr = '/';
  static const String details = '/details';
  static const String notification = '/notification';
  static const String chat = '/chat';
}

abstract final class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      Routes.details => _page(
        (ctx) => CarDetailsPage(
          onSendNotification: () =>
              Navigator.pushNamed(ctx, Routes.notification),
        ),
      ),
      Routes.notification => _page(
        (ctx) => NotificationPickerPage(
          onSend: (msg) =>
              Navigator.pushNamed(ctx, Routes.chat, arguments: msg),
        ),
      ),
      Routes.chat => _page(
        (ctx) => ChatPage(firstMessage: settings.arguments as String?),
      ),
      _ => _page(
        (ctx) => QrScanPage(
          onScanned: () => Navigator.pushNamed(ctx, Routes.details),
        ),
      ),
    };
  }

  static MaterialPageRoute<dynamic> _page(WidgetBuilder builder) =>
      MaterialPageRoute<dynamic>(builder: builder);
}
