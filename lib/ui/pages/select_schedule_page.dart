part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;
  const SelectSchedulePage({Key key, @required this.movieDetail})
      : super(key: key);

  @override
  State<SelectSchedulePage> createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates;
  DateTime selectedDate;
  int selectedTime;
  Theater selectedTheater;
  bool isValid = false;

  @override
  void initState() {
    super.initState();

    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMovieDetailPage(widget.movieDetail));
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
                // Note: Back Button
                Row(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: defaultMargin),
                      padding: const EdgeInsets.all(1),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .bloc<PageBloc>()
                              .add(GoToMovieDetailPage(widget.movieDetail));
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                // Note: Choose Date
                Container(
                  margin: const EdgeInsets.fromLTRB(
                      defaultMargin, 20, defaultMargin, 16),
                  child: Text(
                    'Choose Date',
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dates.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(
                        left: (index == 0) ? defaultMargin : 0,
                        right: (index < dates.length - 1) ? 16 : defaultMargin,
                      ),
                      child: DateCard(
                        date: dates[index],
                        isSelected: selectedDate == dates[index],
                        onTap: () {
                          setState(() {
                            selectedDate = dates[index];
                          });
                        },
                      ),
                    ),
                  ),
                ),

                // Note: Choose Time
                generateTimeTable(),

                // Note: Next Button
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) {
                    return FloatingActionButton(
                      elevation: 0,
                      backgroundColor:
                          isValid ? mainColor : const Color(0xffe4e4e4),
                      child: Icon(
                        Icons.arrow_forward,
                        color: isValid ? Colors.white : const Color(0xffbebebe),
                      ),
                      onPressed: () {
                        if (isValid) {
                          context.bloc<PageBloc>().add(
                                GoToSelectSeatPage(
                                  Ticket(
                                    movieDetail: widget.movieDetail,
                                    theater: selectedTheater,
                                    time: DateTime(
                                        selectedDate.year,
                                        selectedDate.month,
                                        selectedDate.day,
                                        selectedTime),
                                    bookingCode:
                                        randomAlphaNumeric(12).toUpperCase(),
                                    seats: null,
                                    name: (userState as UserLoaded).user.name,
                                    totalPrice: null,
                                  ),
                                ),
                              );
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (var theater in dummyTheater) {
      widgets.add(Container(
        margin: const EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
        child: Text(
          theater.name,
          style: blackTextFont.copyWith(fontSize: 20),
        ),
      ));

      widgets.add(Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 20),
        child: ListView.builder(
          itemCount: schedule.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.only(
              left: (index == 0) ? defaultMargin : 0,
              right: (index < schedule.length - 1) ? 16 : defaultMargin,
            ),
            child: SelectableBox(
              text: '${schedule[index]}:00',
              height: 50,
              isSelected:
                  selectedTheater == theater && selectedTime == schedule[index],
              isEnable: schedule[index] > DateTime.now().hour ||
                  selectedDate.day != DateTime.now().day,
              onTap: () {
                setState(() {
                  selectedTheater = theater;
                  selectedTime = schedule[index];
                  isValid = true;
                });
              },
            ),
          ),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
