import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyAppBar extends StatelessWidget with PreferredSizeWidget
{
  final PreferredSizeWidget bottom;
  MyAppBar({this.bottom});


  @override
  Widget build(BuildContext context) {
      return AppBar(
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: new Image(

            image:  new ExactAssetImage("images/welcome1.png"),
            height: 100.0,
            width: 150.0,
            alignment: FractionalOffset.center),
        bottom: bottom,
        actions: [
          Stack(
            children: [
              IconButton(icon: Icon(Icons.shopping_cart , color: Colors.black,size: 30.0,),
                onPressed: () {
                  Route route = MaterialPageRoute(builder: (c) => CartPage());
                  Navigator.pushReplacement(context,route);
                },
              ),
              Positioned(
                child: Stack(
                  children: [
                    Icon(
                      Icons.brightness_1,
                      size: 20.0,
                      color: Colors.red,
                    ),
                    // Positioned(
                    //   top: 3.0,
                    //   bottom: 4.0,
                    //   left: 6.0,
                    //   child: Consumer<CartItemCounter>(
                    //     builder: (context,counter,_){
                    //       return Text(
                    //         (EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length-1).toString(),
                    //         style: TextStyle(
                    //           color: Colors.white ,
                    //           fontSize: 12.0,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          )
        ],
      );
  }


  Size get preferredSize => bottom==null?Size(56,AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);
}
