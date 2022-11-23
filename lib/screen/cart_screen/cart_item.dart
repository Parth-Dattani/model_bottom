// ignore_for_file: prefer_const_constructors, unnecessary_string_escapes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:model_bottom/widgets/common_button.dart';

class CartItem extends StatefulWidget {
  final String productImage;
  final String productName;
  final int productPrice;
  final int productQuantity;
  final String productCategory;
  final String productId;
  final String cartId;
  final int index;

  const CartItem({
    Key? key,
    required this.productId,
    required this.productCategory,
    required this.productImage,
    required this.productPrice,
    required this.productQuantity,
    required this.productName,
    required this.index,
    required this.cartId,
  }) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;

  void quantityUpdate() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(widget.cartId)
        .update({
      "quantity": quantity,
    });
  }


  Future deleteCart(context, cartId) async {
    await FirebaseFirestore.instance.collection("cart").doc(cartId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("cart").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if(snapshot.hasData){
          var getCartData = snapshot.data!.docs;
         return Container(
           margin: EdgeInsets.all(20.0),
           height: 150,
           width: double.infinity,
           decoration: BoxDecoration(
             color: Colors.white,
             boxShadow: [
               BoxShadow(
                 color: Colors.grey.withOpacity(0.5),
                 blurRadius: 7,
               )
             ],
           ),
           child: Stack(
             alignment: Alignment.topRight,
             children: [
               IconButton(
                 onPressed: () async {
                   print("Index of : ${widget.index}");
                   await deleteCart(context, widget.cartId);
                 },
                 icon: Icon(
                   Icons.delete,
                   color: Colors.red,
                 ),
               ),


               Row(
                 children: [
                   Expanded(
                     child: Container(
                       decoration: BoxDecoration(
                         image: DecorationImage(
                           fit: BoxFit.cover,
                           image: NetworkImage(widget.productImage),
                         ),
                       ),
                     ),
                   ),
                   Expanded(
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           Text(
                             widget.productName,
                             style: TextStyle(
                               fontSize: 18,
                             ),
                           ),
                           Text(
                             widget.productCategory,
                           ),
                           Text(

                             "\₹ ${widget.productPrice}",
                             style: TextStyle(
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                               CommonButton(
                                 color: Colors.grey[300],
                                 icon: Icons.remove,
                                 onPressed: () {
                                   if (quantity > 1) {
                                     setState(() {
                                       quantity--;
                                       quantityUpdate();
                                     });
                                   }
                                 },
                               ),
                               Text(
                                 getCartData[widget.index]['quantity'].toString(),
                                 //widget.productQuantity.toString(),
                                 style: TextStyle(
                                   fontSize: 18,
                                 ),
                               ),
                               CommonButton(
                                 color: Colors.grey[300],
                                 icon: Icons.add,
                                 onPressed: () {
                                   setState(() {
                                     quantity++;
                                     quantityUpdate();
                                   });
                                 },
                               ),
                             ],
                           )
                         ],
                       ),
                     ),
                   )
                 ],
               ),

             ],
           ),
         );
        }
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [Text("no data"), CircularProgressIndicator()],
        ),
      );

      },
      
      
    );
  }
}








