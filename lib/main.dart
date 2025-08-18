import 'package:flutter/material.dart';
import 'package:roobai/app/app.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   Logger().d(' Handling background message: ${message.messageId}');
// }

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    // RepositoryProvider(
    //   create: (_) => AuthRepository(),
    //   child: BlocProvider(
    //     create: (context) => LoginBloc(context.read<AuthRepository>())..add(LoginCheckStatus()),
    App(),
  );
  // ),
  // );
}
