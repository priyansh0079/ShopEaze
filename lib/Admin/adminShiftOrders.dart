import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminOrderCard.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/orderCard.dart';

class AdminShiftOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}


class _MyOrdersState extends State<AdminShiftOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [

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
                        Route route = MaterialPageRoute(builder: (c) => UploadPage());
                        Navigator.pushReplacement(context,route);
                      },
                    ),
                    Divider(height: 10.0,color: Colors.black,thickness: 2.0,),



                  ],
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.red,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text("My Orders",style: TextStyle(color: Colors.black,),),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_drop_down_circle,color: Colors.black,),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("orders")
              .snapshots(),

          builder: (c,snapshot){
            return snapshot.hasData
                ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (c,index){
                return FutureBuilder<QuerySnapshot>(
                  future : Firestore.instance
                      .collection("items")
                      .where("shortInfo",whereIn: snapshot.data.documents[index].data[EcommerceApp.productID])
                      .getDocuments(),

                  builder: (c,snap){
                    return snap.hasData
                        ?AdminOrderCard(
                      itemCount: snap.data.documents.length,
                      data: snap.data.documents,
                      orderID: snapshot.data.documents[index].documentID,
                      orderBy: snapshot.data.documents[index].data["orderBy"],
                      addressID: snapshot.data.documents[index].data["addressID"],
                    )
                        : Center(child: circularProgress(),);
                  },
                );
              },
            )
                : Center(child: circularProgress(),);
          },
        ),
      ),
    );
  }
}
