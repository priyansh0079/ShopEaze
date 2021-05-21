// import 'dart:html';
// import 'dart:ui';

import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/addAddress.dart';
import 'package:e_shop/Store/Search.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Drawer(
      child: ListView(
          children: [
            Container(
              color: Colors.red,
              padding: EdgeInsets.only(top:25.0,bottom: 10.0),
              child: Column(
                children: [
                    SizedBox(height: 10.0,),
                  Text("Hello, " +
                    EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,


                      // fontFamily: "Signatra",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.0,),
            Container(
              padding: EdgeInsets.only(top: 1.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                        Icons.home,
                      color: Colors.green[600],
                    ),
                    title: Text("Home",style: TextStyle(color: Colors.black,fontSize: 15.0,),
                    ),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) => StoreHome());
                      Navigator.pushReplacement(context,route);
                    },
                  ),
                  Divider(height: 10.0,color: Colors.black,thickness: 2.0,),

                  ListTile(
                    leading: Icon(
                      Icons.redeem_outlined,
                      color: Colors.green[600],
                    ),
                    title: Text("My Orders",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,),
                    ),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) => MyOrders());
                      Navigator.pushReplacement(context,route);
                    },
                  ),
                  Divider(height: 10.0,color: Colors.black,thickness: 2.0,),

                  ListTile(
                    leading: Icon(
                      Icons.shopping_cart,
                      color: Colors.green[600],
                    ),
                    title: Text("My Cart",style: TextStyle(color: Colors.black,fontSize: 15.0,),
                    ),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) => CartPage());
                      Navigator.pushReplacement(context,route);
                    },
                  ),
                  Divider(height: 10.0,color: Colors.black,thickness: 2.0,),

                  ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.green[600],
                    ),
                    title: Text("Search",style: TextStyle(color: Colors.black,fontSize: 15.0,),
                    ),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) => SearchProduct());
                      Navigator.pushReplacement(context,route);
                    },
                  ),
                  Divider(height: 10.0,color: Colors.black,thickness: 2.0,),

                  ListTile(
                    leading: Icon(
                      Icons.add_location_alt,
                      color: Colors.green[600],
                    ),
                    title: Text("Address",style: TextStyle(color: Colors.black,fontSize: 15.0,),
                    ),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) => AddAddress());
                      Navigator.pushReplacement(context,route);
                    },
                  ),
                  Divider(height: 10.0,color: Colors.black,thickness: 2.0,),

                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.green[600],
                    ),
                    title: Text("Logout",style: TextStyle(color: Colors.black,fontSize: 15.0,),
                    ),
                    onTap: () {
                     EcommerceApp.auth.signOut().then((c) {
                       Route route = MaterialPageRoute(builder: (c) => AuthenticScreen());
                       Navigator.pushReplacement(context,route);
                     });
                    },
                  ),
                  Divider(height: 10.0,color: Colors.black,thickness: 2.0,),
                ],
              ),
            ),
          ],
      ),
    );
  }
}
