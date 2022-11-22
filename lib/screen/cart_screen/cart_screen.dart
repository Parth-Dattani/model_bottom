import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:model_bottom/controller/cart_controller.dart';

class CartScreen extends GetView<CartController>{
   static const pageId = '/CartScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Cart Page"),
        leading: IconButton(onPressed: (){Get.back();},icon: Icon(Icons.arrow_back_ios_new)),
        actions: [],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('cart').snapshots(),
          builder:  (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){
              controller.getCartData = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(itemBuilder: (context, index) {

                      return Card(
                        margin: EdgeInsets.only(top: 20),

                        elevation: 5,
                        color: Colors.grey[200],
                        child: ListTile(
                          leading: ClipRRect(
                            child:  Image.network(
                              controller.getCartData[index]
                                  .get("imageUrl")
                                  .toString(),
                            )
                          ),
                          title: Text("${controller.getCartData[index]['productName']}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                          subtitle: Text("Price : ${controller.getCartData[index]['price']}"),
                          trailing: TextButton(
                            child:  const Icon(Icons.delete),
                            onPressed: (){
                              controller.deleteCart(context, controller.getCartData[index]);
                              //FirebaseFirestore.instance.collection('cart').doc(controller.getCartData[index].get("cartID").delete());
                            },
                          ),
                        ),
                      );
                    },
                      itemCount:controller.getCartData.length,
                    ),
                  ),
                  const Divider(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("data", style: Theme.of(context).textTheme.headline2,)),

                ],
              );
            }

            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text("no data"),
                  CircularProgressIndicator()
                ],
              ),
            );

          },
        ),
      ),
    );
  }
}


