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

  ProductResponse.fromMap(Map<String, dynamic>json){
    productName = json['productName'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    imageUrl = json['imageUrl'];
    productID = json['productID'];
    quantity = json['quantity'];
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