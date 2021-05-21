import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:flutter/material.dart';




class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        // flexibleSpace: Container(
        //   // padding: EdgeInsets.all(1.0),
        //   decoration: new BoxDecoration(
        //     color: Colors.white,
        //   ),
        // ),

        title: Column(
          children: [
            // SizedBox(
            //   height: 11.0,
            // ),
            new Image(

                image:  new ExactAssetImage("images/welcome1.png"),
                height: 100.0,
                width: 150.0,
                alignment: FractionalOffset.center),
          ],
        ),
        centerTitle: true,
      ),
      body: AdminSignInScreen(),
    );
  }
}


class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _adminIDTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery
        .of(context)
        .size
        .width,
        _screenHeight = MediaQuery
            .of(context)
            .size
            .height;

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "images/admin.png",
                height: 240.0,
                width: 240.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Admin Login",
                style: TextStyle(color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [

                  Card(
                    elevation: 5,
                    child: CustomTextField(
                      controller: _adminIDTextEditingController,
                      data: Icons.local_grocery_store,
                      hintText: "Shop name",
                      isObsecure: false,
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: CustomTextField(
                      controller: _passwordTextEditingController,
                      data: Icons.lock,
                      hintText: "Password",
                      isObsecure: true,
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            RaisedButton(
              onPressed: () {
                _adminIDTextEditingController.text.isNotEmpty &&
                    _passwordTextEditingController.text.isNotEmpty
                    ? loginAdmin()
                    : showDialog(
                    context: context,
                    builder: (c) {
                      return ErrorAlertDialog(
                        message: "Please enter your email and password !",
                      );
                    }
                );
              },
              color: Colors.red,
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Colors.black,
            ),
            SizedBox(
              height: 10.0,
            ),
            FlatButton.icon(
              onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => AuthenticScreen())),
              icon: (Icon(Icons.nature_people,color: Colors.red,)),
              label: Text("I'm not an admin",style: TextStyle(color: Colors.red),),
            ),
          ],
        ),
      ),
    );
  }

  loginAdmin() {
      Firestore.instance.collection("admins").getDocuments().then((snapshot){
          snapshot.documents.forEach((result) {
            if (result.data["id"] != _adminIDTextEditingController.text.trim()){
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("Enter correct shop name"),),);
            }
            else if (result.data["password"] != _passwordTextEditingController.text.trim()){
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Incorrect Password"),));
            }
            else {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Welcome to "+ _adminIDTextEditingController.text+" Eshop"),));

              setState(() {
                _adminIDTextEditingController.text ="";
                _passwordTextEditingController.text = "";
              });

              Route route = MaterialPageRoute(builder: (c) => UploadPage());
              Navigator.pushReplacement(context,route);
            }
          });
      });
  }
}
