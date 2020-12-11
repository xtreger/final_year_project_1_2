import 'package:final_year_project_1_2/config/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class ProviderButton extends StatefulWidget {
  final BuildContext context;
  final String signInType;

  const ProviderButton({Key key, this.context, this.signInType})
      : super(key: key);

  @override
  _ProviderButtonState createState() => _ProviderButtonState();
}

class _ProviderButtonState extends State<ProviderButton> {
  @override
  Widget build(BuildContext context) {
    switch (widget.signInType) {
      case "google":
        return InkWell(
          onTap: () => context.signInWithGoogle(),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Palette.dark)),
            child: LitAuthIcon.google(
              size: const Size(30, 30),
            ),
          ),
        );
        break;
      case "apple":
        return InkWell(
          onTap: () => context.signInWithApple(),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Palette.dark)),
            child: Transform.translate(
                offset: const Offset(-0.5, -1.2),
                child: LitAuthIcon.appleBlack(
                  size: const Size(30, 30),
                )),
          ),
        );
        break;
      case "twitter":
        return InkWell(
          onTap: () => context.signInWithTwitter(),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Palette.dark)),
            child: Transform.scale(
                scale: 1.4,
                child: LitAuthIcon.twitter(
                  size: const Size(30, 30),
                )),
          ),
        );
        break;
      default:
        return const Text("An unknown error has occurred.");
    }
  }
}
