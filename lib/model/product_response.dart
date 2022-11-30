import 'package:cloud_firestore/cloud_firestore.dart';

class ProductResponse{
  String? productName;
  String? description;
  int? price;
  String? category;
  String? imageUrl;
  String? productID;
  int? quantity;

  ProductResponse({
    this.productName,
    this.description,
    this.price,
    this.category,
    this.imageUrl,
    this.productID,
    this.quantity
});

  // ProductResponse.fromMap(Map<String, dynamic>json){
  //   productName = json['productName'];
  //   description = json['description'];
  //   price = json['price'];
  //   category = json['category'];
  //   imageUrl = json['imageUrl'];
  //   productID = json['productID'];
  //   quantity = json['quantity'];
  // }

  ProductResponse.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : productName = doc.data()!["productName"],
        description = doc.data()!["description"],
        price = doc.data()!["price"],
        category = doc.data()!["category"],
        imageUrl = doc.data()!["imageUrl"],
        productID = doc.data()!["productID"],
        quantity = doc.data()!["quantity"];

  factory ProductResponse.fromDocument(DocumentSnapshot doc) {
    return ProductResponse(
      productName: doc['productName'],
      description: doc['description'],
      price: doc['price'],
      category: doc['category'],
      imageUrl: doc['imageUrl'],
      productID: doc['productID'],
      quantity: doc['quantity'],
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'productName' : productName,
      'description' : description,
      'price' : price,
      'category' : category,
      'imageUrl' : imageUrl,
      'productID' : productID,
      'quantity' : quantity,
    };
  }
}