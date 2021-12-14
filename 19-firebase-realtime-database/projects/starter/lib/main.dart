import 'package:flutter/material.dart';
import 'data/message_dao.dart';
import 'ui/message_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Add Firebase Initialization
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Add MultiProvider
    return MultiProvider(
        providers: [
        // TODO: Add ChangeNotifierProvider<UserDao> here
        Provider<MessageDao>(
        lazy: false,
        create: (_) => MessageDao(),
    ),
    ],
    child:
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RayChat',
      theme: ThemeData(primaryColor: const Color(0xFF3D814A)),
      // TODO: Add Consumer<UserDao> here
      home: const MessageList(),
      // TODO: Add closing parenthesis
    ),

    );
  }
}
