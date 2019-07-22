import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ComingSoonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () => _launchURL(),
            child: Container(
              width: 100,
              height: 100,
              child: Image.asset(
                "assets/images/github_logo.png",
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            height: 20,
          ),
          Text(
            "This feature is not implemented yet,\nstay tuned.",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'https://github.com/KarimElghamry/cryptoholic';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
