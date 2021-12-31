import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskkey/services/theme_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Column(
          children: [
            Row(

              children: [
                Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children:[
                    Text((DateFormat.yMMMMd().format(DateTime.now()))),
                    Text("Today")
                  ]
                )
                )
              ],
            )
          ],
        )
    );
  }
}

_appBar(){
    return  AppBar(
      leading: GestureDetector (
        onTap: (){
          ThemeServices().switchTheme();
        },
        child: Icon(Icons.nightlight_round, size: 20,),
      ),
      actions: [
        Icon(Icons.person,
        size:20,),
        SizedBox(width: 20,),
      ],
    );
}


