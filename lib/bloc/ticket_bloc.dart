import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_fluttix/models/models.dart';
import 'package:my_fluttix/services/services.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  @override
  TicketState get initialState => const TicketState([]);

  @override
  Stream<TicketState> mapEventToState(TicketEvent event) async* {
    if (event is BuyTicket) {
      await TicketServices.saveTicket(event.userId, event.ticket);

      List<Ticket> tickets = state.tickets + [event.ticket];

      yield TicketState(tickets);
    } else if (event is GetTickets) {
      List<Ticket> tickets = await TicketServices.getTickets(event.userId);

      yield TicketState(tickets);
    }
  }
}
