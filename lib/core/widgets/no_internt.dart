import 'package:flutter/material.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
       context,
        text:  'No Internet',
        leading: false

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'No Internet Connection',
              style: TextStyle(fontSize: AppSize.defaultSize!*2),
            ),
            SizedBox(height:  AppSize.defaultSize!*2),

          ],
        ),
      ),
    );
  }
}
