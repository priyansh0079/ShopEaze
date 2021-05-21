import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;


class UploadPage extends StatefulWidget
{
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with AutomaticKeepAliveClientMixin<UploadPage>
{
  bool get wantKeepAlive => true;
  File file;
  TextEditingController _descriptionTextEditingController = TextEditingController();
  TextEditingController _priceTextEditingController = TextEditingController();
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _shortInfoTextEditingController = TextEditingController();
  TextEditingController _shopNameTextEditingController = TextEditingController();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return file == null? displayAdminHomeScreen(): displayAdminUploadFormScreen();
  }

  displayAdminHomeScreen() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title:  new Image(

            image:  new ExactAssetImage("images/welcome1.png"),
            height: 100.0,
            width: 150.0,
            alignment: FractionalOffset.center),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.border_color,color: Colors.black),
          onPressed: () {
            Route route = MaterialPageRoute(builder: (c) => AdminShiftOrders());
            Navigator.pushReplacement(context,route);
          },
        ),
        actions: [
          FlatButton(
            child: Text("Logout",style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.bold),),
            onPressed: () {
              Route route = MaterialPageRoute(builder: (c) => SplashScreen());
              Navigator.pushReplacement(context,route);
            },
          ),
        ],
      ),
      body: getAdminHomeScreenBody(),
    );
  }

  getAdminHomeScreenBody(){
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shop_two, color: Colors.lightGreenAccent,size: 100.0,),
            Padding(
              padding: EdgeInsets.only(top:20.0),
              child: RaisedButton(
                color: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
                child: Text("Add Product",style: TextStyle(fontSize: 20.0,color: Colors.white),),
                onPressed: () => takeImage(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  takeImage(mContext){
    return showDialog(
      context: mContext,
      builder: (con) {
        return SimpleDialog(
          title: Text("Item Image",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          children: [

            SimpleDialogOption(
              child: Text(
                "Capture with Camera",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: capturePhotoWithCamera,
            ),

            SimpleDialogOption(
              child: Text(
                "Select from Gallery",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: pickPhotoFromGallery,
            ),

            SimpleDialogOption(
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),


          ],
        );
      }

    );
  }

  capturePhotoWithCamera() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 680.0,maxWidth: 970.0);

    setState(() {
      file = imageFile;
    });
  }


  pickPhotoFromGallery() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      file = imageFile;
    });
  }

  displayAdminUploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title:  Text("New Product",style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: uploading ? null : () => uploadImageAndSaveItemInfo(),
            child: Text("Add",style: TextStyle(fontSize: 16.0,color: Colors.black),),
          ),
        ],
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,
        ),
          onPressed: clearFormInfo,
        ),
      ),
      body: ListView(
       children: [
         uploading ? circularProgress() : Text(""),
         Container(
           height: 300.0,
           width: MediaQuery.of(context).size.width*0.8,
           child: Center(
             child: AspectRatio(
               aspectRatio: 2/2,
               child: Container(
                 decoration: BoxDecoration(image: DecorationImage(image: FileImage(file),fit: BoxFit.cover)),
               ),
             )
           ),
         ),
         Padding(
           padding: EdgeInsets.only(top:12.0),
         ),


         ListTile(
           leading: Icon(Icons.info,color: Colors.green,),
           title: Container(
             width: 250.0,
             child: TextField(
               style: TextStyle(color: Colors.black),
               controller: _shortInfoTextEditingController,
               decoration: InputDecoration(
                 hintText: "Short Info",
                 hintStyle: TextStyle(color: Colors.black),
                 border: InputBorder.none,
               ),
             ),
           ),
         ),
         Divider(color: Colors.red,),


         ListTile(
           leading: Icon(Icons.info,color: Colors.green,),
           title: Container(
             width: 250.0,
             child: TextField(
               style: TextStyle(color: Colors.black),
               controller: _titleTextEditingController,
               decoration: InputDecoration(
                 hintText: "Title",
                 hintStyle: TextStyle(color: Colors.black),
                 border: InputBorder.none,
               ),
             ),
           ),
         ),
         Divider(color: Colors.red,),


         ListTile(
           leading: Icon(Icons.info,color: Colors.green,),
           title: Container(
             width: 250.0,
             child: TextField(
               style: TextStyle(color: Colors.black),
               controller: _descriptionTextEditingController,
               decoration: InputDecoration(
                 hintText: "Description",
                 hintStyle: TextStyle(color: Colors.black),
                 border: InputBorder.none,
               ),
             ),
           ),
         ),
         Divider(color: Colors.red,),


         ListTile(
           leading: Icon(Icons.info,color: Colors.green,),
           title: Container(
             width: 250.0,
             child: TextField(
               keyboardType: TextInputType.number,
               style: TextStyle(color: Colors.black),
               controller: _priceTextEditingController,
               decoration: InputDecoration(
                 hintText: "Price",
                 hintStyle: TextStyle(color: Colors.black),
                 border: InputBorder.none,
               ),
             ),
           ),
         ),
         Divider(color: Colors.red,),

         ListTile(
           leading: Icon(Icons.info,color: Colors.green,),
           title: Container(
             width: 250.0,
             child: TextField(
               style: TextStyle(color: Colors.black),
               controller: _shopNameTextEditingController,
               decoration: InputDecoration(
                 hintText: "Shop Name",
                 hintStyle: TextStyle(color: Colors.black),
                 border: InputBorder.none,
               ),
             ),
           ),
         ),
         Divider(color: Colors.red,),
       ],
      ),
    );
  }

  clearFormInfo(){
    setState(() {
      file = null;
      _descriptionTextEditingController.clear();
      _priceTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      _titleTextEditingController.clear();
      _shopNameTextEditingController.clear();
    });
  }

  uploadImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl = await uploadItemImage(file);

    saveItemInfo(imageDownloadUrl);
  }

  Future<String> uploadItemImage(mFileImage) async {
    final StorageReference storageReference = FirebaseStorage.instance.ref().child("Items");
    StorageUploadTask uploadTask = storageReference.child("product_$productId.jpg").putFile(mFileImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  saveItemInfo(String downloadUrl){
    final itemRef = Firestore.instance.collection("items");
    itemRef.document(productId).setData({
      "shortInfo": _shortInfoTextEditingController.text.trim(),
      "longDescription": _descriptionTextEditingController.text.trim(),
      "price":int.parse( _priceTextEditingController.text),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
      "title": _titleTextEditingController.text.trim(),
      "shopName":_shopNameTextEditingController.text.trim(),
    });

    setState(() {
      file = null;
      uploading = false;
      productId = DateTime.now().millisecondsSinceEpoch.toString();
      _titleTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      _priceTextEditingController.clear();
      _shopNameTextEditingController.clear();
      _descriptionTextEditingController.clear();
    });
  }
}
