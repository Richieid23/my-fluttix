part of 'pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) => (state is UserLoaded)
                  ? Text(state.user.name)
                  : const SizedBox(),
            ),
            RaisedButton(
              child: const Text('Sign Out'),
              onPressed: () {
                AuthServices.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
