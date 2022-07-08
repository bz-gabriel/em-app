import 'package:emapp/routes/login_page.dart';
import 'package:emapp/routes/testToken.dart';
import 'package:emapp/services/users_auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UsersAuthApi(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
