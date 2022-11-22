class ProductResponse{
  String? productName;
  String? description;
  int? price;
  String? category;
  String? imageUrl;
  String? productID;

  ProductResponse({
    this.productName,
    this.description,
    this.price,
    this.category,
    this.imageUrl,
    this.productID
});

  ProductResponse.fromMap(Map<String, dynamic>json){
    productName = json['productName'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    imageUrl = json['imageUrl'];
    productID = json['productID'];
  }

  Map<String, dynamic> toMap(){
    return{
      'productName' : productName,
      'description' : description,
      'price' : price,
      'category' : category,
      'imageUrl' : imageUrl,
      'productID' : productID
    };
  }
}