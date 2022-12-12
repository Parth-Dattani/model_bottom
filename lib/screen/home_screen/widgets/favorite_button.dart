import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/model/model.dart';

class FavoriteButton extends StatelessWidget {
  bool isFav;
  Function()? ifIsFavorite;
   Function()? ifIsNotFavorite;
   FavoriteButton({
     Key? key,
     required this.isFav,
     this.ifIsFavorite,
     this.ifIsNotFavorite
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    RxBool isFavorite=isFav.obs;

    return Obx(() {
        return IconButton(
          onPressed: () {
            //getProduct[index]
            isFavorite.value = !isFavorite.value;
             isFavorite.value ?
              ifIsFavorite!():ifIsNotFavorite!();
              // controller.favorite(
              //   productId: list[index].productID,
              //   productCategory: list[index].category,
              //   productRate: "2",
              //   productOldPrice: "200",
              //   productPrice: list[index].price,
              //   productImage: list[index].imageUrl,
              //   productFavorite: true,
              //   productName: list[index].productName,
              // );
          //  }
            // else if (isFavorite.value == false) {
            //   ifIsNotFavorite;
            //   // controller.deleteFavorite(
            //   //     productId: list[index].productID.toString());
            // }
          },
          icon:isFavorite.value ==
              false
              ? const Icon(Icons.favorite_border)
              : const Icon(
            Icons.favorite_sharp,
            color: Colors.pink,
          ),
        );
      }
    );
  }
}
