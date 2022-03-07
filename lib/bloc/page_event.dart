part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object> get props => [];
}

class GoToSplashPage extends PageEvent {}

class GoToLoginPage extends PageEvent {}

class GoToMainPage extends PageEvent {}

class GoToRegistrationPage extends PageEvent {
  final RegistrationData registrationData;

  const GoToRegistrationPage(this.registrationData);
}

class GoTOPreferencePage extends PageEvent {
  final RegistrationData registrationData;

  const GoTOPreferencePage(this.registrationData);
}

class GoToAccountConfirmationPage extends PageEvent {
  final RegistrationData registrationData;

  const GoToAccountConfirmationPage(this.registrationData);
}

class GoToMovieDetailPage extends PageEvent {
  final Movie movie;

  const GoToMovieDetailPage(this.movie);
}

class GoToSelectSchedulePage extends PageEvent {
  final MovieDetail movieDetail;

  const GoToSelectSchedulePage(this.movieDetail);
}

class GoToSelectSeatPage extends PageEvent {
  final Ticket ticket;

  const GoToSelectSeatPage(this.ticket);
}

class GoToCheckoutPage extends PageEvent {
  final Ticket ticket;

  const GoToCheckoutPage(this.ticket);
}

class GoToSuccessPage extends PageEvent {
  final Ticket ticket;
  final FlutixTransaction transaction;

  const GoToSuccessPage(this.ticket, this.transaction);
}

class GoToTicketDetailPage extends PageEvent {
  final Ticket ticket;

  const GoToTicketDetailPage(this.ticket);
}

class GoToProfilePage extends PageEvent {}

class GoToTopupPage extends PageEvent {
  final PageEvent pageEvent;

  const GoToTopupPage(this.pageEvent);
}
