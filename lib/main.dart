import 'package:flutter/material.dart';
import 'package:my_fluttix/services/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                  child: Text('Sign Up'),
                  onPressed: () async {
                    SignInSignUpResult result = await AuthServices.signUp(
                        'lisa@blackpink.com',
                        '12345678',
                        'Lalisa',
                        ['Action', 'Horror', 'Music', 'Drama'],
                        'Korean');

                    if (result.user == null) {
                      print(result.message);
                    } else {
                      print(result.user.toString());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
