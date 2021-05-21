import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Authentication/login.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';

import 'authenication.dart';



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}



class _RegisterState extends State<Register> {

  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // String userImageUrl = "";
  // File _imageFile;

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
            SizedBox(height: 10.0,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    child: CustomTextField(
                      controller: _nameTextEditingController,
                      data: Icons.person,
                      hintText: "Name",
                      isObsecure: false,
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: CustomTextField(
                      controller: _emailTextEditingController,
                      data: Icons.email,
                      hintText: "Email",
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
                  Card(
                    elevation: 5,
                    child: CustomTextField(
                      controller: _confirmPasswordTextEditingController,
                      data: Icons.lock,
                      hintText: "Confirm password",
                      isObsecure: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            RaisedButton(
              onPressed: () {uploadAndSaveImage();},
              color: Colors.red,
              child: Text(
                "Register",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Colors.black,
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }


  Future<void> uploadAndSaveImage() async {
    if (
    _passwordTextEditingController.text ==_confirmPasswordTextEditingController.text ) {
      _emailTextEditingController.text.isNotEmpty &&
          _passwordTextEditingController.text.isNotEmpty &&
          _confirmPasswordTextEditingController.text.isNotEmpty &&
          _nameTextEditingController.text.isNotEmpty ? uploadToStorage()

          : displayDialog("Please fill all the required fields..");
          

    }
    else{
      displayDialog("password do not match.");
    }
  }

  displayDialog(String msg){
    showDialog(
      context :context,
      builder: (c){
        return ErrorAlertDialog(message: msg,);
      }

    );
  }


  uploadToStorage() async{
    showDialog(
      context: context,
      builder: (c){
        return LoadingAlertDialog(message: "Registering, please wait......");
      }
    );
    _registerUser();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async {
    FirebaseUser firebaseUser;
    await _auth.createUserWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    ).then((auth){
      firebaseUser = auth.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(message: error.message.toString(),);
        }
      );
    });

    if (firebaseUser!=null){
      saveUserInfoToFireStore(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => AuthenticScreen());
        Navigator.pushReplacement(context, route);
      });
    }
  }
   Future saveUserInfoToFireStore(FirebaseUser fUser) async {
       Firestore.instance.collection("users").document(fUser.uid).setData({
       "uid":fUser.uid,
         "email":fUser.email,
         "name": _nameTextEditingController.text.trim(),
         EcommerceApp.userCartList: ["garbageValue"]
       });

       await EcommerceApp.sharedPreferences.setString("uid",fUser.uid);
       await EcommerceApp.sharedPreferences.setString("email",fUser.email);
       await EcommerceApp.sharedPreferences.setString("name",_nameTextEditingController.text);
       await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList,["garbageValue"]);
      }
    }


