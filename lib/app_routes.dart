import 'package:flutter/material.dart';
import 'package:proti_box/screens/complete_account.dart';
import 'package:proti_box/screens/forgot_password.dart';
import 'package:proti_box/screens/sign_in.dart';
import 'package:proti_box/screens/signature.dart';
import 'package:proti_box/screens/welcome.dart';

class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case WelcomeScreen.routeName:
        return _materialRoute(WelcomeScreen());

      case CompleteAccountScreen.routeName:
        return _materialRoute(CompleteAccountScreen());

      case SignatureScreen.routeName:
        return _materialRoute(SignatureScreen());

      case SignInScreen.routeName:
        return _materialRoute(SignInScreen());

      case ForgotPasswordScreen.routeName:
        return _materialRoute(ForgotPasswordScreen());

/*
      case ProductListingScreen.routeName:
        return _materialRoute(ProductListingScreen(
            productListing: settings.arguments as ProductListing));

      case QRScannerScreen.routeName:
        return _materialRoute(QRScannerScreen(
          qrTask: settings.arguments as QRTask,
        ));

      case TakePictureScreen.routeName:
        return _materialRoute(const TakePictureScreen());

      case AddProductListingScreen.routeName:
        return _materialRoute(const AddProductListingScreen());
*/

      default:
        return null;
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}