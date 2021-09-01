import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/app_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kcLightPurple,
      ),
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: <Widget>[
            AppText.heading1('Heading 1'),
            SizedBox(height: 10),
            AppText.heading2('Heading 2'),
            SizedBox(height: 10),
            AppText.heading3('Heading 3'),
            SizedBox(height: 10),
            AppText.headline('Headline'),
            SizedBox(height: 10),
            AppText.subheading('Subheading'),
            SizedBox(height: 10),
            AppText.caption('Caption'),
            SizedBox(height: 10),
            AppText.body('Body', color: Colors.black),
            SizedBox(height: 10),
            AppTextField(placeholder: 'Text Field'),
            SizedBox(height: 10),
            AppButton(
              title: 'title',
              action: () {},
            ),
            SizedBox(height: 10),
            AppButton.outlined(
              title: 'Outlined',
              action: () {},
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
