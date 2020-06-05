import 'package:bsg/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AccountSettingsView extends StatefulWidget{


  @override
  _AccountSettingsViewState createState() => _AccountSettingsViewState();
}

class _AccountSettingsViewState extends State<AccountSettingsView> {

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _tagynameController = TextEditingController();
  final _emailController = TextEditingController();

  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(),
              backgroundColor: Colors.white,
              title: Text("Профиль",
                style: TextStyle(
                  color:Colors.black
                ),),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.exit_to_app), 
                  onPressed: ()=> exitApp(context))
              ],
            ),            
            body: SingleChildScrollView(
                          child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10,top:15),
                        child: Text("Логин / Номер телефона",style: TextStyle(
                          fontSize: 15
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25,top:0),
                        child: Text("+7 123-456-78-90",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                      FlatButton(
                        shape:  RoundedRectangleBorder(
                            borderRadius:  BorderRadius.circular(8.0)),
                          color: Colors.grey,
                          splashColor: Colors.white,
                          child:Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width*0.65,
                            child: const Text(
                            "Изменить логин / номер \nтелефона",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () => {}
                      ),
                       Padding(
                         padding: const EdgeInsets.only(top:10,bottom: 10),
                         child: FlatButton(
                          shape:  RoundedRectangleBorder(
                              borderRadius:  BorderRadius.circular(8.0)),
                            color: Colors.grey,
                            splashColor: Colors.white,
                            child:Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width*0.65,
                              child: const Text(
                              "Изменить пароль",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onPressed: () => {}
                        ),
                      ),
                      Padding(
                      padding: const EdgeInsets.only(bottom: 5,top:5),
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 14.0,
                              color:Colors.black,
                            ),
                            children:<TextSpan>[
                                    TextSpan(text: 'Компания: ',
                                          style: TextStyle(fontSize: 17 )),
                                    TextSpan(
                                        text: 'ТОО Ромашка',
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),                           
                                  ]
                                ),
                      ),
                      ),                      
                      Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 14.0,
                              color:Colors.black,
                            ),
                            children:<TextSpan>[
                                    TextSpan(text: 'Филиал: ',
                                          style: TextStyle(fontSize: 17 )),
                                    TextSpan(
                                        text: 'Название',
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),                           
                                  ]
                                ),
                          ),
                      ), 
                      Text("Бухгалтер филиала",style: TextStyle(fontSize: 18 )),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _surnameController,
                        decoration: InputDecoration(
                            border:  OutlineInputBorder(
                                borderSide:  BorderSide(color: Colors.teal)),
                            // hintText: '',
                            labelText: 'Фамилия',                                                        
                            suffixIcon: IconButton(
                              icon: Icon(Icons.cancel), 
                              onPressed:() => _remove('surname')),                        
                            suffixStyle: const TextStyle(color: Colors.green)),                      
                      ),
                      SizedBox(
                        height: 20,
                      ),
                       TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            border:  OutlineInputBorder(
                                borderSide:  BorderSide(color: Colors.teal)),
                            // hintText: '',
                            labelText: 'Имя',                            
                            suffixIcon: IconButton(
                              icon: Icon(Icons.cancel), 
                              onPressed: () => _remove('name')),                        
                            suffixStyle: const TextStyle(color: Colors.green)),                      
                      ),
                      SizedBox(
                        height: 20,
                      ),
                       TextField(
                         controller: _tagynameController,
                        decoration: InputDecoration(
                            border:  OutlineInputBorder(
                                borderSide:  BorderSide(color: Colors.teal)),
                            // hintText: '',
                            labelText: 'Отчество',                            
                            suffixIcon: IconButton(
                              icon: Icon(Icons.cancel), 
                              onPressed: () => _remove('tagyname')),                        
                            suffixStyle: const TextStyle(color: Colors.green)),                      
                      ),                          
                      Padding(                       
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child:Text("Дата рождения",style: TextStyle(fontSize: 18 ))
                      ),    
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                             child:InkWell(
                                 onTap: () => _selectDateTime(),
                                 child:  TextField(                            
                              controller: _dayController,      
                              enabled: false,                                                      
                              decoration: InputDecoration(                               
                                  border:  OutlineInputBorder(
                                      borderSide:  BorderSide(color: Colors.teal)),
                                  labelText: 'День',                                                                                    
                                  suffixStyle: const TextStyle(color: Colors.green)),                      
                            ),
                          )),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 4,
                             child:InkWell(
                                 onTap: () => _selectDateTime(),
                                 child:  TextField(                           
                              controller: _monthController,
                              enabled: false,     
                              decoration: InputDecoration(
                                  border:  OutlineInputBorder(
                                      borderSide:  BorderSide(color: Colors.teal)),
                                  labelText: 'Месяц',                                                                                
                                  suffixStyle: const TextStyle(color: Colors.green)),                      
                            )),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                             child: InkWell(
                                 onTap: () => _selectDateTime(),
                                 child: TextField(                            
                                controller: _yearController,
                                enabled: false,     
                                decoration: InputDecoration(
                                    border:  OutlineInputBorder(
                                        borderSide:  BorderSide(color: Colors.teal)),
                                    labelText: 'Год',                                                                                     
                                    suffixStyle: const TextStyle(color: Colors.green)),                      
                            ),
                             ),
                          ),
                          
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                       TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            border:  OutlineInputBorder(
                                borderSide:  BorderSide(color: Colors.teal)),
                            labelText: 'Email почта',                            
                            suffixIcon: IconButton(
                              icon: Icon(Icons.cancel), 
                              onPressed:() => _remove('email')),                        
                            suffixStyle: const TextStyle(color: Colors.green)),                      
                      ),   
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: FlatButton(
                            shape:  RoundedRectangleBorder(
                                borderRadius:  BorderRadius.circular(8.0)),
                              color: Colors.green[300],
                              splashColor: Colors.greenAccent,
                              child:Container(
                                padding: const EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width*0.65,
                                child: const Text(
                                "Сохранить изменения",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: () => {}
                          ),
                      ),                                       
                    ],
                  ),
                ),
              ),
            )
      ),
    );
  }

  _selectDateTime(){
      Map<int,String> listOfMonth = {
        1:'Январь',
        2:'Февраль',
        3:'Март',
        4:'Апрель',
        5:'Май',
        6:'Июнь',
        7:'Июль',
        8:'Август',
        9:'Октябрь',
        10:'Сентябрь',
        11:'Ноябрь',
        12:'Декабрь',                
      };
      DatePicker.showDatePicker(context,      
      showTitleActions: true,
      minTime: DateTime(1960, 3, 5),            
      maxTime: DateTime(2020,12, 7), onChanged: (date) {
        print('change $date');       
      }, onConfirm: (date) {
        String month;
        for (var item in listOfMonth.entries) {
            if(item.key == date.month)
              month = item.value;
        }
        setState(() {
          _dayController.text = date.day.toString();
          _monthController.text = month;
          _yearController.text = date.year.toString();           
        });
      }, currentTime: DateTime.now(), locale: LocaleType.ru);
  }
  void _remove(String value){

        switch (value) {
          case 'name':
            _nameController.clear();
            break;
           case 'surname':
            _surnameController.clear();
            
            break;
             case 'tagyname':
            _tagynameController.clear();
              break;           
             case 'email':
            _emailController.clear();
            break;
          default:
        }
    }
}