import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'login_cor_view.dart';
import 'login_priv_view.dart';

class AuthTabView extends StatefulWidget{

  @override
  _AuthTabViewState createState() => _AuthTabViewState();
}

class _AuthTabViewState extends State<AuthTabView>  with TickerProviderStateMixin{
  TabController _tabController;



   @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);    

    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
          child: Scaffold(
        resizeToAvoidBottomPadding: true,      
        appBar: AppBar(        
          title: _buildLogo(),
          centerTitle: true,        
          backgroundColor: Colors.white,
          bottom: TabBar(          
            indicatorSize: TabBarIndicatorSize.label,          
            indicatorColor: Colors.purple[300],          
            labelPadding: EdgeInsets.symmetric(horizontal: 10),
            indicator: BoxDecoration(                  
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurpleAccent),
            labelStyle: TextStyle(
              color:Colors.green
            ),
            unselectedLabelColor: Colors.purple[100],
            labelColor: Colors.white,          
            tabs: [
              Tab(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("Корпоративный \n Клиент",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold),),
              ),),
              Tab(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("Частный \n Клиент",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold),),
              ),),
            ],
            controller: _tabController,
          ),
        ),
        body:TabBarView(          
            children: [     
                LoginScreen(),
                RegisterScreen()
            ],
            dragStartBehavior: DragStartBehavior.start,
            controller: _tabController,
          ),    
      ),
    );
  }

  Widget _buildLogo(){
    return Padding(
       padding: const EdgeInsets.all(45),
       child: Image.asset("assets/images/logo.png",width: 200),       
    );
  }
}