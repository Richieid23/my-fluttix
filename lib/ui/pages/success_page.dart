part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final FlutixTransaction transaction;
  const SuccessPage(
      {Key key, @required this.ticket, @required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Scaffold(
        body: FutureBuilder(
          future: ticket != null
              ? processingTicketOrder(context)
              : processingTopUp(context),
          builder: (context, snapshot) =>
              (snapshot.connectionState == ConnectionState.done)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          margin: const EdgeInsets.only(bottom: 70),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(ticket == null
                                ? 'assets/top_up_done.png'
                                : 'assets/ticket_done.png'),
                          )),
                        ),
                        Text(
                          (ticket == null) ? 'Emmm Yummy' : 'Happy Watching!',
                          style: blackTextFont.copyWith(fontSize: 20),
                        ),
                        Text(
                          (ticket == null)
                              ? 'You have successfully\ntop up the wallet'
                              : 'You have successfully\nbooked the ticket',
                          textAlign: TextAlign.center,
                          style: blackTextFont.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Container(
                          height: 45,
                          width: 250,
                          margin: const EdgeInsets.only(top: 70, bottom: 20),
                          child: RaisedButton(
                            elevation: 0,
                            color: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                                (ticket == null) ? 'My Wallet' : 'My Ticket',
                                style: whiteTextFont.copyWith(fontSize: 16)),
                            onPressed: () {},
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Discover new movie? ',
                              style: greyTextFont.copyWith(
                                  fontWeight: FontWeight.w400),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.bloc<PageBloc>().add(GoToMainPage());
                              },
                              child: Text(
                                'Back to Home',
                                style: purpleTextFont,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  : Center(
                      child: SpinKitFadingCircle(
                        color: mainColor,
                        size: 50,
                      ),
                    ),
        ),
      ),
    );
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    context.bloc<UserBloc>().add(Purchase(ticket.totalPrice));
    context.bloc<TicketBloc>().add(BuyTicket(ticket, transaction.userId));

    await FlutixTransactionServices.saveTransaction(transaction);
  }

  Future<void> processingTopUp(BuildContext context) async {
    context.bloc<UserBloc>().add(TopUp(transaction.amount));

    await FlutixTransactionServices.saveTransaction(transaction);
  }
}
