part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class GetTickets extends TicketEvent {
  final String userId;

  const GetTickets(this.userId);
}

class BuyTicket extends TicketEvent {
  final Ticket ticket;
  final String userId;

  const BuyTicket(this.ticket, this.userId);
}
