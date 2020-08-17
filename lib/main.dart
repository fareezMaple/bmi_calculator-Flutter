import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AppBody.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange.shade600,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                print('Pressed');
                if (bmiResult != null) {
                  Share.share('My BMI is $bmiResult');
                } else {
                  Fluttertoast.showToast(
                      msg: 'Calculate your BMI first',
                      backgroundColor: Colors.red);
                }
              },
              tooltip: 'Share your current BMI',
            ),
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                print('Info');
                showAboutDialog(
                    context: context,
                    applicationName: 'BMI Calculator Lite',
                    applicationVersion: '1.0.0+2',
                    applicationIcon: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/bmi-flutter-2e776.appspot.com/o/logounnamed%20(Custom).png?alt=media&token=b22b53f7-bfc6-4a9b-89f3-92e681d1fe6c',
                      width: 50,
                    ),
                    applicationLegalese: '©maplerr 2020',
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      aboutLinkButton(
                          title: "View on GitHub",
                          url:
                              'https://github.com/fareezMaple/bmi_calculator-Flutter'),
                      aboutLinkButton(
                          title: 'Follow me on Twitter',
                          url: 'https://twitter.com/iqfareez2'),
                      aboutLinkButton(
                          title: 'Open on web',
                          url: 'https://bmi-flutter-2e776.web.app/'),
                    ]);
              },
              tooltip: 'View some info',
            )
          ],
        ),
        body: AppBody(),
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget aboutLinkButton({String title, String url}) {
  return OutlineButton(
    child: Text(title),
    onPressed: () {
      _launchURL(url);
    },
  );
}
