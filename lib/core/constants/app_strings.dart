/// All UI copy (static Russian, taken verbatim from the Figma design).
abstract final class AppStrings {
  // QR scan
  static const String qrTitle = 'Сканировать QR-код';

  // Car details
  static const String detailsTitle = 'Детали';
  static const String contactOwner = 'Связаться с владельцем';
  static const String carName = 'Onix';
  static const String ownerNote = 'Можете писать или звонить\nв любое время 😊';
  static const String ownerSocials = 'Социальные сети владельца:';
  static const String call1 = 'Позвонить 1';
  static const String call2 = 'Позвонить 2';
  static const String sendNotification = 'Отправить уведомление';

  // Notification picker
  static const String chooseNotification = 'Выберите текст уведомления';
  static const String send = 'Отправить';
  static const List<String> notifications = [
    'Вы перекрыли проезд, пожалуйста, проверьте автомобиль',
    'Похоже, дверь автомобиля не закрыта, обратите внимание',
    'У вас включены фары, возможно, вы забыли их выключить',
    'Вы продаёте машину? Интересует, свяжитесь, пожалуйста',
  ];

  // Chat
  static const String chatTitle = 'Переписка';
  static const String messageHint = 'Сообщение';
  static const String reply = 'Уже выхожу';
  static const String quickReply = 'Можете побыстрее?';
}
