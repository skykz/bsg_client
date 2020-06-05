import 'package:bsg/core/models/base_provider.dart';
import 'package:bsg/core/models/history_model.dart';
import 'package:bsg/core/views/history/balance_view.dart';
import 'package:bsg/core/views/history/history_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class HistoryMainView extends StatefulWidget{

  @override
  _AuthTabViewState createState() => _AuthTabViewState();
}

class _AuthTabViewState extends State<HistoryMainView>  with TickerProviderStateMixin{
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
    
    return BaseProvider<HistoryModel>(
        model: HistoryModel(),
        builder: (context, model, child) => SafeArea(
          child: Scaffold(
        resizeToAvoidBottomPadding: true,      
        appBar: AppBar(        
          elevation: 1,
          iconTheme: IconThemeData(),
          title: Text("История",style: TextStyle(
            color:Colors.black,
            fontSize: 20
          ),),
          centerTitle: true,        
          backgroundColor: Colors.white,
          bottom: TabBar(          
            
            indicatorSize: TabBarIndicatorSize.label,          
            indicatorColor: Colors.purple[300],          
            labelPadding: EdgeInsets.symmetric(horizontal: 10),
            indicator: BoxDecoration(                  
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey),
            labelStyle: TextStyle(
              color:Colors.green
            ),
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,          
            tabs: [
              Tab(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("Заправка",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold),),
              ),),
              Tab(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("Баланс",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold),),
              ),),
            ],
            controller: _tabController,
          ),
        ),
        body:Column(
          children: <Widget>[
            SizedBox(  
              height: MediaQuery.of(context).size.height * 0.7,        
                child: TabBarView(          
                  children: [     
                    HistoryView(model: model,),
                    BalanceView(model: model)
                  ],
                  dragStartBehavior: DragStartBehavior.start,
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                ),
            ),
            Expanded(
              flex: 1,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FlatButton(
                        shape:  RoundedRectangleBorder(
                            borderRadius:  BorderRadius.circular(10.0)),
                          color: Colors.grey,
                          splashColor: Colors.white,
                          child:Container(
                            padding: const EdgeInsets.all(13),
                            width: MediaQuery.of(context).size.width*0.6,
                            child: const Text(
                            "Закрыть",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context)
                      ),
                    ),                    
            ),
            SizedBox(height: 10,)
          ],
        ),    
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