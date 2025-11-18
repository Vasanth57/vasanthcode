import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import 'package:giglz/pages/otp.dart';
import 'package:giglz/pages/bottombar.dart';
import 'package:giglz/provider/generalprovider.dart';
import 'package:giglz/utils/constant.dart';
import 'package:giglz/utils/dimens.dart';
import 'package:giglz/utils/color.dart';
import 'package:giglz/utils/sharedpre.dart';
import 'package:giglz/utils/utils.dart';
import 'package:giglz/widget/myimage.dart';
import 'package:giglz/widget/mytext.dart';

import '../webservice/socketmanager.dart';

// Import Pusher Beams for push notifications
import 'package:pusher_beams/pusher_beams.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late GeneralProvider generalProvider;
  SharedPre sharedPre = SharedPre();
  final numberController = TextEditingController();
  String mobilenumber = "", countrycode = "", countryname = "";
  String? strDeviceType, strDeviceToken;
  bool isagreeCondition = false;
  bool isLoad = false;
  final SocketManager socketManager = SocketManager();

  static const String staticOtp = "123456";

  @override
  void initState() {
    super.initState();
    generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    _initPusherBeams();
  }

  /// Initialize Pusher Beams and retrieve device token
  /// This method properly retrieves the device ID which serves as the device token
  Future<void> _initPusherBeams() async {
    try {
      // Your Pusher Beams instance ID
      const String beamsInstanceId = '262c7cd2-89a0-41f8-8d45-a3d7a9419f1d';
      final beams = PusherBeams.instance;

      // Start Pusher Beams with instance ID
      await beams.start(beamsInstanceId);
      log('✓ Pusher Beams started successfully');

      // IMPORTANT: Retrieve the device ID (this is your device token)
      // This is the key method to get the device token for push notifications
      String? deviceId;
      try {
        // Wait a moment for Pusher to fully initialize
        await Future.delayed(const Duration(milliseconds: 500));
        
        // Get the device ID - this is the device token you need
        deviceId = await beams.getDeviceId();
        log('✓ Device ID retrieved: $deviceId');
      } catch (e) {
        log('⚠ Failed to get device ID: $e');
        // Device ID might not be available immediately on some platforms
        // The app will continue, but device token will be null
      }

      // Set device type and token
      setState(() {
        if (Platform.isAndroid) {
          strDeviceType = "1";
        } else if (Platform.isIOS) {
          strDeviceType = "2";
        } else {
          strDeviceType = "0";
        }
        strDeviceToken = deviceId; // This is the actual device token
      });

      log("✓ Configured strDeviceType: $strDeviceType");
      log("✓ Configured strDeviceToken: $strDeviceToken");
      
      if (strDeviceToken == null) {
        log("⚠ Device token is null - push notifications may not work");
      }
    } catch (e) {
      log("✗ Pusher Beams initialization failed: $e");
      
      // Set default values even if Pusher fails
      setState(() {
        if (Platform.isAndroid) {
          strDeviceType = "1";
        } else if (Platform.isIOS) {
          strDeviceType = "2";
        } else {
          strDeviceType = "0";
        }
        // Device token will be null if initialization fails
        strDeviceToken = null;
      });
    }
  }

  /// Send static OTP and navigate to OTP page
  codeSend(bool isResend) async {
    generalProvider.setLoading(true);
    log("================>>Code send (static) <<<============");
    await Future.delayed(const Duration(milliseconds: 300));
    Utils().showSnackBar(
      context,
      "OTP is static for this build: $staticOtp - replace with real flow for production",
      false,
    );

    if (!mounted) return;
    generalProvider.setLoading(false);

    // Navigate to OTP page with the number, country info and device info
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Otp(
          fullnumber: mobilenumber,
          countrycode: countrycode,
          countryName: countryname,
          number: numberController.text.trim(),
          deviceType: strDeviceType,
          deviceToken: strDeviceToken,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {},
      child: Scaffold(
        backgroundColor: appbgcolor,
        body: Consumer<GeneralProvider>(builder: (context, generalprovider, child) {
          return AbsorbPointer(
            absorbing: isLoad,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: appbgcolor,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.35,
                                alignment: Alignment.bottomCenter,
                                child: MyImage(
                                  width: MediaQuery.of(context).size.width * 0.60,
                                  height: MediaQuery.of(context).size.height * 0.25,
                                  imagePath: "appicon.png",
                                ),
                              ),
                              MyText(
                                color: white,
                                text: "hello",
                                textalign: TextAlign.center,
                                fontsizeNormal: Dimens.textlargeBig,
                                multilanguage: true,
                                inter: false,
                                maxline: 1,
                                fontwaight: FontWeight.w800,
                                overflow: TextOverflow.ellipsis,
                                fontstyle: FontStyle.normal,
                              ),
                              const SizedBox(height: 5),
                              MyText(
                                color: white,
                                text: "loginyouraccount",
                                textalign: TextAlign.center,
                                fontsizeNormal: Dimens.textTitle,
                                multilanguage: true,
                                inter: false,
                                maxline: 1,
                                fontwaight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                                fontstyle: FontStyle.normal,
                              ),
                              const SizedBox(height: 20),
                              IntlPhoneField(
                                disableLengthCheck: true,
                                textAlignVertical: TextAlignVertical.center,
                                cursorColor: white,
                                autovalidateMode: AutovalidateMode.disabled,
                                controller: numberController,
                                style: Utils.googleFontStyle(
                                    4, Dimens.textTitle, FontStyle.normal, white, FontWeight.w500),
                                showCountryFlag: true,
                                showDropdownIcon: false,
                                initialCountryCode: Constant.initialCountryCode,
                                dropdownTextStyle: Utils.googleFontStyle(
                                    4, Dimens.textTitle, FontStyle.normal, white, FontWeight.w500),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: Utils.googleFontStyle(
                                      4, Dimens.textMedium, FontStyle.normal, white, FontWeight.w500),
                                  hintText: "Mobile Number",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: white, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: white, width: 1),
                                  ),
                                ),
                                onChanged: (phone) {
                                  mobilenumber = phone.completeNumber;
                                  countryname = phone.countryISOCode ?? "";
                                  countrycode = phone.countryCode ?? "";
                                  log("numberController==> ${numberController.text}");
                                  log('mobile number==> $mobilenumber');
                                  log('countryCode number==> $countryname');
                                  log('countryISOCode==> $countrycode');
                                },
                                onCountryChanged: (country) {
                                  countryname = country.code;
                                  countrycode = "+${country.dialCode}";
                                  log('countryname===> $countryname');
                                  log('countrycode===> $countrycode');
                                },
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      spacing: 5,
                                      runSpacing: 5,
                                      children: [
                                        MyText(
                                          color: white,
                                          text: "termconditionfirst",
                                          textalign: TextAlign.center,
                                          fontsizeNormal: 12,
                                          multilanguage: true,
                                          inter: false,
                                          maxline: 1,
                                          fontwaight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                          fontstyle: FontStyle.normal,
                                        ),
                                        MyText(
                                          color: colorPrimary,
                                          text: "terms",
                                          textalign: TextAlign.center,
                                          fontsizeNormal: 12,
                                          multilanguage: true,
                                          inter: false,
                                          maxline: 2,
                                          fontwaight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                          fontstyle: FontStyle.normal,
                                        ),
                                        MyText(
                                          color: colorPrimary,
                                          text: "condition",
                                          textalign: TextAlign.center,
                                          fontsizeNormal: 12,
                                          multilanguage: true,
                                          inter: false,
                                          maxline: 2,
                                          fontwaight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                          fontstyle: FontStyle.normal,
                                        ),
                                        MyText(
                                          color: colorPrimary,
                                          text: "privacy_policy",
                                          textalign: TextAlign.left,
                                          fontsizeNormal: 12,
                                          multilanguage: true,
                                          inter: false,
                                          maxline: 1,
                                          fontwaight: FontWeight.w400,
                                          overflow: TextOverflow.visible,
                                          fontstyle: FontStyle.normal,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              if (generalprovider.isProgressLoading)
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 55,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: colorPrimary,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: CircularProgressIndicator(
                                    color: colorAccent,
                                    strokeWidth: 2,
                                  ),
                                )
                              else
                                InkWell(
                                  onTap: () async {
                                    if (numberController.text.toString().isEmpty) {
                                      Utils().showSnackBar(context, "pleaseenteryourmobilenumber", true);
                                    } else {
                                      debugPrint("mobilenumber==> $mobilenumber");
                                      setState(() {
                                        isLoad = true;
                                      });
                                      await codeSend(false);
                                      setState(() {
                                        isLoad = false;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: colorPrimary,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: MyText(
                                        color: pureBlack,
                                        text: "continue",
                                        textalign: TextAlign.center,
                                        fontsizeNormal: Dimens.textTitle,
                                        inter: false,
                                        maxline: 1,
                                        multilanguage: true,
                                        fontwaight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                        fontstyle: FontStyle.normal),
                                  ),
                                ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.center,
                                child: MyText(
                                  color: white,
                                  text: "or",
                                  textalign: TextAlign.center,
                                  fontsizeNormal: 16,
                                  inter: false,
                                  multilanguage: true,
                                  maxline: 1,
                                  fontwaight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  fontstyle: FontStyle.normal,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                              Center(
                                child: MyText(
                                  color: white,
                                  text:
                                      "Note: This build uses a static OTP for testing. Replace with real verification flow for production.",
                                  fontsizeNormal: 12,
                                  multilanguage: false,
                                  inter: false,
                                  fontwaight: FontWeight.w400,
                                  textalign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const Bottombar(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(-1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(position: offsetAnimation, child: child);
                                },
                              ),
                              (Route route) => false,
                            );
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
                ),
                if (isLoad)
                  const Positioned.fill(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: colorPrimary,
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
