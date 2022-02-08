part of 'pages.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Splash Page'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            context.bloc<PageBloc>().add(GoToLoginPage());
          },
          child: Text('Go to Sign In page'),
        ),
      ),
    );
  }
}
