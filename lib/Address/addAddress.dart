import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Models/address.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final cName = TextEditingController();
  final cPhoneNumber = TextEditingController();
  final cHomeNumber = TextEditingController();
  final cCity =  TextEditingController();
  final cState = TextEditingController();
  final cPinCode = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
              if(formKey.currentState.validate()){
                final model = AddressModel(
                  
                  name: cName.text.trim(),
                  state: cState.text.trim(),
                  pincode: cPinCode.text,
                  phoneNumber: cPhoneNumber.text,
                  flatNumber: cHomeNumber.text,
                  city: cCity.text.trim(),
                  
                ).toJson();
                
                EcommerceApp.firestore.collection(EcommerceApp.collectionUser).document(
                  EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID)
                ).collection(EcommerceApp.subCollectionAddress).document(DateTime.now().millisecondsSinceEpoch.toString()).setData(model).then((value){
                  final snack = SnackBar(content: Text("New Address added successfully."),);
                  scaffoldKey.currentState.showSnackBar(snack);
                  FocusScope.of(context).requestFocus(FocusNode());
                  formKey.currentState.reset();
                });
              }
          },
          backgroundColor: Colors.red,
          icon: Icon(Icons.check),
          label: Text("Save"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Add new Address",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: MyTextField(
                          hint: "Name",
                          controller: cName,
                        ),
                      )
                    ),

                    Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: MyTextField(
                            hint: "Phone Number",
                            controller: cPhoneNumber,
                          ),
                        )
                    ),

                    Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child:  MyTextField(
                            hint: "Full Address",
                            controller: cHomeNumber,
                          ),
                        )
                    ),

                    Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child:  MyTextField(
                            hint: "city",
                            controller: cCity,
                          ),
                        )
                    ),

                    Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child:   MyTextField(
                            hint: "State",
                            controller: cState,
                          ),
                        )
                    ),

                    Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child:  MyTextField(
                            hint: "Pin Code",
                            controller: cPinCode,
                          ),
                        )
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
    final String hint;
    final TextEditingController controller;

    MyTextField({Key key, this.hint,this.controller,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration.collapsed(hintText: hint),
        validator: (val) => val.isEmpty ?
        "Fields can not be empty ." : null,
      ),
    );
  }
}
