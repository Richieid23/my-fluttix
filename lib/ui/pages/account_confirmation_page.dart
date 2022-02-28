part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  const AccountConfirmationPage({this.registrationData});

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigningUp = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoTOPreferencePage(widget.registrationData));
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 90),
                    height: 56,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () =>
                                context.bloc<PageBloc>().add(GoToSplashPage()),
                            child: const Icon(Icons.arrow_back,
                                color: Colors.black),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Confirm\n New Account",
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: (widget.registrationData.profilePicture != null)
                            ? FileImage(widget.registrationData.profilePicture)
                            : const AssetImage("assets/user_pic.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    'Welcome',
                    style: blackTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    widget.registrationData.name,
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 110,
                  ),
                  (isSigningUp)
                      ? SpinKitFadingCircle(
                          color: const Color(0xff3e9d9d),
                          size: 45,
                        )
                      : SizedBox(
                          width: 250,
                          height: 45,
                          child: RaisedButton(
                            color: const Color(0xff3e9d9d),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Create My Account",
                              style: whiteTextFont.copyWith(fontSize: 16),
                            ),
                            onPressed: () async {
                              setState(() {
                                isSigningUp = true;
                              });

                              imageFileToUpload =
                                  widget.registrationData.profilePicture;

                              SignInSignUpResult result =
                                  await AuthServices.signUp(
                                widget.registrationData.email,
                                widget.registrationData.password,
                                widget.registrationData.name,
                                widget.registrationData.selectedGenres,
                                widget.registrationData.selectedLanguage,
                              );

                              if (result.user == null) {
                                setState(() {
                                  isSigningUp = false;
                                });

                                Flushbar(
                                  duration: const Duration(seconds: 1500),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: const Color(0xffff5c83),
                                  message: result.message,
                                ).show(context);
                              }
                            },
                          ),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
