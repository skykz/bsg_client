
import 'package:bsg/core/views/home/home_views.dart';
import 'package:bsg/resources/components/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/models/mqtt_model.dart';
import 'core/views/auth/tab_view.dart';


class MyApp extends StatefulWidget {

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 

 @override
  void initState() {  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
          providers: [
            ChangeNotifierProvider<MQTTAppState>(
                  create: (_) => MQTTAppState(),
            ),                     
           ],
             child:  MaterialApp(
                debugShowCheckedModeBanner: false,            
                theme: ThemeData(
                  fontFamily: "Rubik",    
                  platform: TargetPlatform.iOS,   
                  primarySwatch: Colors.deepPurple,       
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home:FutureBuilder(
                        future: SharedPreferences.getInstance(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) 
                            return Scaffold(
                                body: LoadingWidget()
                            ); 
                          String accessToken = snapshot.data.getString('access_token');                          
                          if(accessToken != null)         
                            return HomeScreen();

                          return AuthTabView();
                        }))
              );
  }
}
