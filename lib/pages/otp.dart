import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import 'package:giglz/pages/bottombar.dart';
import 'package:giglz/provider/generalprovider.dart';
import 'package:giglz/utils/dimens.dart';
import 'package:giglz/utils/color.dart';
import 'package:giglz/utils/sharedpre.dart';
import 'package:giglz/utils/utils.dart';
import 'package:giglz/widget/myimage.dart';
import 'package:giglz/widget/mytext.dart';

class Otp extends StatefulWidget {
  final String fullnumber, countrycode, countryName, number;
  final String? deviceType;
  final String? deviceToken;

  const Otp({
    super.key,
    required this.fullnumber,
    required this.countrycode,
    required this.countryName,
    required this.number,
    this.deviceType,
    this.deviceToken,
  });

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  // Static OTP as requested
  static const String staticOtp = "123456";

  late GeneralProvider generalProvider;
  SharedPre sharedPre = SharedPre();
  final pinPutController = TextEditingController();

  bool isLoad = false;

  @override
  void initState() {
    log('OTP Page init for ${widget.fullnumber}');
    log('Device Type: ${widget.deviceType}');
    log('Device Token: ${widget.deviceToken}');
    super.initState();
    generalProvider = Provider.of<GeneralProvider>(context, listen: false);

    // Immediately "send" code (we just show a message and set local state)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      codeSend(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appbgcolor,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.35,
                        alignment: Alignment.bottomCenter,
                        child: MyImage(
                            width: MediaQuery.of(context).size.width * 0.60,
                            height: MediaQuery.of(context).size.height * 0.25,
                            imagePath: "appicon.png"),
                      ),
                      MyText(
                          color: white,
                          text: "pleaseenteryourotp",
                          textalign: TextAlign.center,
                          fontsizeNormal: Dimens.textlargeBig,
                          multilanguage: true,
                          inter: false,
                          maxline: 1,
                          fontwaight: FontWeight.w800,
                          overflow: TextOverflow.ellipsis,
                          fontstyle: FontStyle.normal),
                      const SizedBox(height: 5),
                      MyText(
                          color: white,
                          text: "we have sent an otp to your number",
                          textalign: TextAlign.center,
                          multilanguage: true,
                          fontsizeNormal: Dimens.textDesc,
                          inter: false,
                          maxline: 2,
                          fontwaight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          fontstyle: FontStyle.normal),
                      const SizedBox(height: 15),
                      MyText(
                          color: white,
                          text: widget.fullnumber.toString(),
                          textalign: TextAlign.center,
                          fontsizeNormal: 14,
                          inter: false,
                          multilanguage: false,
                          maxline: 2,
                          fontwaight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                          fontstyle: FontStyle.normal),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 55,
                        child: Pinput(
                          length: 6,
                          keyboardType: TextInputType.number,
                          controller: pinPutController,
                          textInputAction: TextInputAction.done,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          onCompleted: (value) {
                            if (pinPutController.text.toString().isEmpty) {
                              Utils().showSnackBar(context, "pleaseenterotp", true);
                              return;
                            }
                            generalProvider.setLoading(true);
                            _checkOTPAndLogin();
                          },
                          defaultPinTheme: PinTheme(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              border: Border.all(color: colorPrimary, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            textStyle: GoogleFonts.roboto(
                              color: white,
                              fontSize: Dimens.textBig,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          codeSend(true);
                        },
                        child: Container(
                          constraints: const BoxConstraints(minWidth: 70),
                          padding: const EdgeInsets.all(5),
                          child: MyText(
                            color: white,
                            text: "resend",
                            multilanguage: true,
                            fontsizeNormal: Dimens.textTitle,
                            fontwaight: FontWeight.w600,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      InkWell(
                        onTap: () {
                          if (pinPutController.text.toString().isEmpty) {
                            Utils().showSnackBar(context, "pleaseenterotp", true);
                            return;
                          }
                          generalProvider.setLoading(true);
                          _checkOTPAndLogin();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.06,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Consumer<GeneralProvider>(
                              builder: (context, generalprovider, child) {
                            if (generalprovider.isProgressLoading) {
                              return CircularProgressIndicator(
                                color: white,
                                strokeWidth: 0.8,
                              );
                            } else {
                              return MyText(
                                  color: colorAccent,
                                  text: "login",
                                  multilanguage: true,
                                  textalign: TextAlign.center,
                                  fontsizeNormal: Dimens.textTitle,
                                  inter: false,
                                  maxline: 1,
                                  fontwaight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                  fontstyle: FontStyle.normal);
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Utils.backIcon(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  /// "Send" code: for static OTP we just update local state and show a toast/snackbar.
  codeSend(bool isResend) async {
    generalProvider.setLoading(true);
    log("================>>Code send (static) <<<============");
    // Simulate network / send delay
    await Future.delayed(const Duration(milliseconds: 300));
    Utils().showSnackBar(context,
        "OTP is static for this build: $staticOtp - replace with real flow for production",
        false);
    if (!mounted) return;
    generalProvider.setLoading(false);
  }

  /// Validate OTP (static) and call login
  /// This method receives the device token that was retrieved in the Login page
  _checkOTPAndLogin() async {
    final entered = pinPutController.text.trim();
    if (entered == staticOtp) {
      // Proceed to login - supply device info that was captured in Login and passed into this widget
      log("OTP validated successfully");
      log("Device Type being sent: ${widget.deviceType ?? 'null'}");
      log("Device Token being sent: ${widget.deviceToken ?? 'null'}");
      
      _login(
        widget.number.toString(),
        widget.deviceType ?? "",
        widget.deviceToken ?? "",
      );
    } else {
      generalProvider.setLoading(false);
      Utils().showSnackBar(context, "otpinvalid", true);
      return;
    }
  }

  /// Login with mobile number and device information
  /// The device token retrieved from Pusher Beams is passed here
  _login(String mobile, String deviceType, String deviceToken) async {
    log("click on Submit mobile =====> $mobile");
    log("click on Submit deviceType => $deviceType");
    log("click on Submit deviceToken => $deviceToken");
    final gp = Provider.of<GeneralProvider>(context, listen: false);
    gp.setLoading(true);

    // Use the existing login API signature: type "1" for mobile login.
    await gp.login("1", "", mobile, deviceType, deviceToken, widget.countrycode, widget.countryName);

    if (!gp.loading) {
      if (!mounted) return;
      gp.setLoading(false);
      if (gp.loginModel.status == 200) {
        /* Save Users Credentials */
        Utils.saveUserCreds(
          userID: gp.loginModel.result?[0].id.toString(),
          channeId: gp.loginModel.result?[0].channelId.toString(),
          channelName: gp.loginModel.result?[0].channelName.toString(),
          fullName: gp.loginModel.result?[0].fullName.toString(),
          email: gp.loginModel.result?[0].email.toString(),
          mobileNumber: gp.loginModel.result?[0].mobileNumber.toString(),
          countrycode: gp.loginModel.result?[0].countryCode.toString(),
          countryname: gp.loginModel.result?[0].channelName.toString(),
          image: gp.loginModel.result?[0].image.toString(),
          coverImg: gp.loginModel.result?[0].coverImg.toString(),
          deviceType: gp.loginModel.result?[0].deviceType.toString(),
          deviceToken: gp.loginModel.result?[0].deviceToken.toString(),
          userIsBuy: gp.loginModel.result?[0].isBuy.toString(),
          isAdsFree: gp.loginModel.result?[0].adsFree.toString(),
          isDownload: gp.loginModel.result?[0].isDownload.toString(),
          isCreator: gp.loginModel.result?[0].isCreator.toString(),
          walletBalance: gp.loginModel.result?[0].walletBalance.toString(),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const Bottombar()),
          (Route<dynamic> route) => false,
        );
      } else {
        gp.setLoading(false);
        Utils().showSnackBar(context, "Error", false);
      }
    }
  }
}
