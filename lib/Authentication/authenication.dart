import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'package:e_shop/Config/config.dart';

class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // flexibleSpace: Container(
          //   // padding: EdgeInsets.all(1.0),
          //   decoration: new BoxDecoration(
          //     color: Colors.white,
          //   ),
          // ),

          title: Column(
            children: [
              SizedBox(
                height: 11.0,
              ),
              new Image(

                  image:  new ExactAssetImage("images/welcome.png"),
                  height: 200.0,
                  width: 150.0,
                  alignment: FractionalOffset.center),
            ],
          ),
          centerTitle: true,
          bottom: PreferredSize(
        child: Container(
        color: Colors.red,
          height: 80.0,
          child: TabBar(
            labelStyle: TextStyle(fontSize: 15.0),
            labelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.lock,color: Colors.white,),
                text: "Login",
              ),
              Tab(
                icon: Icon(Icons.perm_contact_calendar,color: Colors.white,),
                text: "Register",
              )
            ],
            // indicatorColor: Colors.black12,
            // indicatorWeight: 5.0,
          ),
        ),
          preferredSize: Size.fromHeight(100.0)),

        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: TabBarView(
            children: [
              Login(),
              Register(),
            ],
          ),
        ),
      ),

    );
  }
}
