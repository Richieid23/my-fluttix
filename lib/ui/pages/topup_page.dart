part of 'pages.dart';

class TopupPage extends StatefulWidget {
  final PageEvent pageEvent;
  const TopupPage({Key key, @required this.pageEvent}) : super(key: key);

  @override
  State<TopupPage> createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  TextEditingController amountController = TextEditingController();
  int selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    context.bloc<ThemeBloc>().add(ChangeTheme(
        ThemeData().copyWith(primaryColor: const Color(0xffe4e4e4))));

    double cardWidth =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 40) / 3;
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(widget.pageEvent);
        return;
      },
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                // Note: Back Arrow
                SafeArea(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, left: defaultMargin),
                    child: GestureDetector(
                      onTap: () {
                        context.bloc<PageBloc>().add(widget.pageEvent);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                // Note: Content
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Top Up',
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        onChanged: (text) {
                          String temp = '';

                          for (var i = 0; i < text.length; i++) {
                            temp += text.isDigit(i) ? text[i] : '';
                          }

                          setState(() {
                            selectedAmount = int.parse(temp) ?? 0;
                          });

                          amountController.text = NumberFormat.currency(
                            locale: 'id_ID',
                            symbol: 'IDR ',
                            decimalDigits: 0,
                          ).format(selectedAmount);

                          amountController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: amountController.text.length));
                        },
                        controller: amountController,
                        decoration: InputDecoration(
                          labelStyle: greyTextFont,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Amount',
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 14),
                          child: Text(
                            'Choose by Template',
                            style: blackTextFont,
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: [
                          makeMoneyCard(amount: 50000, width: cardWidth),
                          makeMoneyCard(amount: 100000, width: cardWidth),
                          makeMoneyCard(amount: 150000, width: cardWidth),
                          makeMoneyCard(amount: 200000, width: cardWidth),
                          makeMoneyCard(amount: 250000, width: cardWidth),
                          makeMoneyCard(amount: 500000, width: cardWidth),
                          makeMoneyCard(amount: 1000000, width: cardWidth),
                          makeMoneyCard(amount: 2500000, width: cardWidth),
                          makeMoneyCard(amount: 5000000, width: cardWidth),
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      SizedBox(
                        height: 46,
                        width: 250,
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (context, userState) => RaisedButton(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Top Up My Wallet',
                                style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color: (selectedAmount > 0)
                                        ? Colors.white
                                        : const Color(0xffbebebe)),
                              ),
                              disabledColor: const Color(0xffE4E4E4),
                              color: const Color(0xff3e9d9d),
                              onPressed: (selectedAmount > 0)
                                  ? () {
                                      context
                                          .bloc<PageBloc>()
                                          .add(GoToSuccessPage(
                                              null,
                                              FlutixTransaction(
                                                userId:
                                                    (userState as UserLoaded)
                                                        .user
                                                        .id,
                                                title: 'Top Up Wallet',
                                                amount: selectedAmount,
                                                subtitle:
                                                    '${DateTime.now().dayName}, ${DateTime.now().day} ${DateTime.now().monthName} ${DateTime.now().year}',
                                                time: DateTime.now(),
                                              )));
                                    }
                                  : null),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  MoneyCard makeMoneyCard({int amount, double width}) {
    return MoneyCard(
      amount: amount,
      width: width,
      isSelected: amount == selectedAmount,
      onTap: () {
        setState(() {
          if (selectedAmount != amount) {
            selectedAmount = amount;
          } else {
            selectedAmount = 0;
          }

          amountController.text = NumberFormat.currency(
            locale: 'id_ID',
            symbol: 'IDR ',
            decimalDigits: 0,
          ).format(selectedAmount);

          amountController.selection = TextSelection.fromPosition(
              TextPosition(offset: amountController.text.length));
        });
      },
    );
  }
}
