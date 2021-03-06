part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;
  const SelectSeatPage({Key key, @required this.ticket}) : super(key: key);

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToSelectSchedulePage(widget.ticket.movieDetail));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: accentColor1,
            ),
            SafeArea(
              child: Container(
                color: Colors.white,
              ),
            ),
            ListView(
              children: [
                Column(
                  children: [
                    // Note: Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: defaultMargin),
                          padding: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(
                                  GoToSelectSchedulePage(
                                      widget.ticket.movieDetail));
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: defaultMargin),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 16),
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  widget.ticket.movieDetail.title,
                                  style: blackTextFont.copyWith(fontSize: 20),
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      imageBaseUrl +
                                          'w154' +
                                          widget.ticket.movieDetail.posterPath,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Note: Cinema Screen
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: 277,
                      height: 84,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/screen.png'),
                        ),
                      ),
                    ),

                    // Note: Seats
                    generateSeat(),

                    // Note: Next Button
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.topCenter,
                      child: FloatingActionButton(
                        elevation: 0,
                        backgroundColor: (selectedSeats.isNotEmpty)
                            ? mainColor
                            : const Color(0xffe4e4e4),
                        child: Icon(
                          Icons.arrow_forward,
                          color: (selectedSeats.isNotEmpty)
                              ? Colors.white
                              : const Color(0xffbebebe),
                        ),
                        onPressed: selectedSeats.isNotEmpty
                            ? () {
                                context.bloc<PageBloc>().add(GoToCheckoutPage(
                                    widget.ticket
                                        .copyWith(seats: selectedSeats)));
                              }
                            : null,
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column generateSeat() {
    List<int> numberofSeats = [3, 5, 5, 5, 5];
    List<Widget> widgets = [];

    for (int i = 0; i < numberofSeats.length; i++) {
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          numberofSeats[i],
          (index) => Padding(
            padding: EdgeInsets.only(
                right: (index < numberofSeats[i] - 1) ? 16 : 0, bottom: 16),
            child: SelectableBox(
              text: '${String.fromCharCode(i + 65)}${index + 1}',
              width: 40,
              height: 40,
              textStyle: whiteNumberFont.copyWith(color: Colors.black),
              isSelected: selectedSeats
                  .contains('${String.fromCharCode(i + 65)}${index + 1}'),
              onTap: () {
                String seatNumber =
                    '${String.fromCharCode(i + 65)}${index + 1}';

                setState(() {
                  if (selectedSeats.contains(seatNumber)) {
                    selectedSeats.remove(seatNumber);
                  } else {
                    selectedSeats.add(seatNumber);
                  }
                });
              },
              isEnable: index != 0,
            ),
          ),
        ),
      ));
    }

    return Column(
      children: widgets,
    );
  }
}
