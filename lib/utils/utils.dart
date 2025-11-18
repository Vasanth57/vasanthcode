import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  // Show snackbar
  void showSnackBar(BuildContext context, String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  // Google Font Style
  static TextStyle googleFontStyle(
    int fontFamily,
    double fontSize,
    FontStyle fontStyle,
    Color color,
    FontWeight fontWeight,
  ) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontStyle: fontStyle,
      color: color,
      fontWeight: fontWeight,
    );
  }

  // Back icon
  static Widget backIcon() {
    return const Icon(Icons.arrow_back, color: Colors.white);
  }

  // Save user credentials
  static Future<void> saveUserCreds({
    String? userID,
    String? channeId,
    String? channelName,
    String? fullName,
    String? email,
    String? mobileNumber,
    String? countrycode,
    String? countryname,
    String? image,
    String? coverImg,
    String? deviceType,
    String? deviceToken,
    String? userIsBuy,
    String? isAdsFree,
    String? isDownload,
    String? isCreator,
    String? walletBalance,
  }) async {
    // Implement your save logic here
  }
}
