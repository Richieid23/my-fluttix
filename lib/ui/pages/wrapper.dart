part of 'pages.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    if (firebaseUser == null) {
      if (prevPageEvent is! GoToSplashPage) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (prevPageEvent is! GoToMainPage) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));

        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }

    return BlocBuilder<PageBloc, PageState>(
      builder: (_, pageState) {
        if (pageState is OnSplashPage) {
          return const SplashPage();
        } else if (pageState is OnLoginPage) {
          return const SignInPage();
        } else if (pageState is OnRegistrationPage) {
          return SignUpPage(pageState.registrationData);
        } else if (pageState is OnPreferencePage) {
          return PreferencePage(
            registrationData: pageState.registrationData,
          );
        } else if (pageState is OnAccountConfirmationPage) {
          return AccountConfirmationPage(
            registrationData: pageState.registrationData,
          );
        } else if (pageState is OnMovieDetailPage) {
          return MovieDetailPage(
            movie: pageState.movie,
          );
        } else if (pageState is OnSelectSchedulePage) {
          return SelectSchedulePage(
            movieDetail: pageState.movieDetail,
          );
        } else if (pageState is OnSelectSeatPage) {
          return SelectSeatPage(
            ticket: pageState.ticket,
          );
        } else if (pageState is OnCheckoutPage) {
          return CheckouPage(
            ticket: pageState.ticket,
          );
        } else if (pageState is OnSuccessPage) {
          return SuccessPage(
            ticket: pageState.ticket,
            transaction: pageState.transaction,
          );
        } else {
          return const MainPage();
        }
      },
    );
  }
}
