import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(AppTheme.overlay);
  runApp(const TaskUiApp());
}

class TaskUiApp extends StatelessWidget {
  const TaskUiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        title: 'Task UI',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        initialRoute: Routes.qr,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
