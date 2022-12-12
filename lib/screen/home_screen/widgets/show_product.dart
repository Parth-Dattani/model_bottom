// import 'package:flutter/material.dart';
//
// import '../../../model/model.dart';
//
// class ShowProduct extends StatefulWidget {
//   //String? mae;
//   List<ProductResponse> list;
//    ShowProduct({Key? key,required this.list!}) : super(key: key);
//
//   @override
//   State<ShowProduct> createState() => _ShowProductState();
// }
//
// class _ShowProductState extends State<ShowProduct> {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         itemBuilder: (context, index) {
//           return Column(
//             children: [
//               list.isEmpty
//                   ? const Text("No data")
//                   : Expanded(
//
//                 child: GestureDetector(
//                   onTap: () {
//
//                     productView(context, list[index]);
//                   },
//                   child: Card(
//                     elevation: 5,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         SizedBox(
//                             width: 200,
//                             height: 150,
//                             child: Stack(
//                               children: [
//                                 ClipRRect(
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(15)),
//                                     child: Center(
//                                       child: Image.network(
//                                         list[index].imageUrl.toString(),
//                                       ),
//                                     )),
//                                 Positioned(
//                                   right: -1,
//                                   top: -15,
//                                   child: FavoriteButton(
//
//                                       ifIsFavorite:(){
//                                         controller.favorite(
//                                           productId: list[index].productID,
//                                           productCategory: list[index].category,
//                                           productRate: "2",
//                                           productOldPrice: "200",
//                                           productPrice: list[index].price,
//                                           productImage: list[index].imageUrl,
//                                           productFavorite: true,
//                                           productName: list[index].productName,
//                                         );
//                                       } ,ifIsNotFavorite:(){
//                                     print("product out");
//                                     controller.deleteFavorite(
//                                         productId: list[index].productID.toString());
//                                   }  ),),
//                                 controller.role.value == "admin"
//                                     ? Positioned(
//                                   bottom: -4,
//                                   right: 45,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     children: [
//                                       IconButton(
//                                           onPressed: () {
//                                             Get.toNamed(
//                                                 ProductScreen
//                                                     .pageId,
//                                                 arguments: {
//                                                   'editProduct':
//                                                   controller
//                                                       .isEdit
//                                                       .value =
//                                                   true,
//                                                   'productId': list[
//                                                   index]
//                                                       .productID,
//                                                   'proImage':
//                                                   list[index]
//                                                       .imageUrl,
//                                                   'proName': list[
//                                                   index]
//                                                       .productName,
//                                                   'proPrice':
//                                                   list[index]
//                                                       .price,
//                                                   'proQuantity':
//                                                   list[index]
//                                                       .quantity,
//                                                   'proCategory':
//                                                   list[index]
//                                                       .category,
//                                                   'proDescription':
//                                                   list[index]
//                                                       .description,
//                                                 });
//                                             //productView(context, getProduct[index]);
//                                           },
//                                           icon: const Icon(
//                                             Icons.edit,
//                                             color: Colors.green,
//                                           )),
//                                       IconButton(
//                                           onPressed: () {
//                                             showDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 return AlertDialog(
//                                                   title: Container(
//                                                       color: Colors
//                                                           .blue,
//                                                       child: const Text(
//                                                           "Flutter Product!!")),
//                                                   content: const Text(
//                                                       "Are You Sure Product delete ? "),
//                                                   actions: [
//                                                     ElevatedButton(
//                                                         onPressed:
//                                                             () {
//                                                           Get.back();
//                                                         },
//                                                         child: const Text(
//                                                             "Cancel")),
//                                                     ElevatedButton(
//                                                         onPressed:
//                                                             () {
//                                                           controller.deleteProduct(
//                                                               context,
//                                                               getProduct[
//                                                               index]);
//                                                           ScaffoldMessenger.of(
//                                                               context)
//                                                               .showSnackBar(const SnackBar(
//                                                               content: Text(
//                                                                 "Product delete Successfully",
//                                                               )));
//                                                         },
//                                                         child: const Text(
//                                                             "Delete")),
//                                                   ],
//                                                 );
//                                               },
//                                             );
//                                           },
//                                           icon: const Icon(
//                                             Icons.delete,
//                                             color: Colors.red,
//                                           )),
//                                     ],
//                                   ),
//                                 )
//                                     : const SizedBox(
//                                   width: 0,
//                                 ),
//                               ],
//                             )),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         dataList("Name : ", list[index].productName),
//                         dataList(
//                             "Price : ", list[index].price.toString()),
//                         dataList("Category : ", list[index].category),
//                         dataList(
//                             "Qty : ", list[index].quantity.toString()),
//                         dataList("", ""),
//                         /*Text(
//                                   "Description : ${getProduct[index].get("description")}",
//                                   style: const TextStyle(
//                                       overflow: TextOverflow.ellipsis,
//                                       fontWeight: FontWeight.w500),
//                                 ),*/
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 15,
//             mainAxisSpacing: 18,
//             childAspectRatio: 0.65),
//         itemCount: list.length,
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//       );
//
//   }
// }
