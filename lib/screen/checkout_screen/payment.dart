
// ignore_for_file: prefer_const_constructors, avoid_print, unused_local_variable, unused_field, prefer_typing_uninitialized_variables, unnecessary_string_escapes


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../cart_screen/widget/cart_item.dart';
import 'cart_provider.dart';

class PaymentPage extends StatefulWidget {
  static const pageID ='/CheckOutScreen';
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': num.parse(totalPrice.toString()) * 100,
      'name': 'Parth Dattani',
      'description': 'Payment for some randonm product',
      'prefill': {
        'contact': '9512259792',
        'email': 'parthdattani58@gmail.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Susccess");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment error");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("EXTERNAL_WALLET ");
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();

    double subTotal = cartProvider.subTotal();

    double discount = 5;
    int shipping = 10;

    double discountValue = (subTotal * discount) / 100;

    double value = subTotal - discountValue;

    totalPrice = value += shipping;

    if (cartProvider.getCartList.isEmpty) {
      setState(() {
        totalPrice = 0.0;
      });
    }

    return Scaffold(
      appBar:AppBar(
        title: Text('Chekout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartProvider.getCartList.isEmpty
                ? Center(
              child: Text("No Product"),
            )
                : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: cartProvider.getCartList.length,
              itemBuilder: (ctx, index) {
                var data = cartProvider.cartList[index];
                return CartItem(
                  productId: data.productID!,
                  productCategory: data.category!,
                  productImage: data.imageUrl!,
                  productPrice: data.price!,
                  productQuantity: data.quantity!,
                  productName: data.productName!,
                  index:index, cartId: 'sds',
                );
              },
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  leading: Text("Sub Total"),
                  trailing: Text("\₹ subTotal"),
                ),
                ListTile(
                  leading: Text("Discount"),
                  trailing: Text("5%"),
                ),
                ListTile(
                  leading: Text("Shiping"),
                  trailing: Text("\₹10"),
                ),
                Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: Text("Total"),
                  trailing: Text("\₹ $totalPrice"),
                ),
                cartProvider.getCartList.isEmpty
                    ? Text("")
                    : ElevatedButton(
                  onPressed: () => openCheckout(),
                  child: Text("Buy"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


// // ignore_for_file: prefer_const_constructors, avoid_print, unused_local_variable, unused_field, prefer_typing_uninitialized_variables, unnecessary_string_escapes
//
//
// import 'package:flutter/material.dart';
// import 'package:model_bottom/screen/cart_screen/widget/cart_item.dart';
// import 'package:model_bottom/widgets/common_button.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// class PaymentPage extends StatefulWidget {
//   const PaymentPage({Key? key}) : super(key: key);
//
//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }
//
// class _PaymentPageState extends State<PaymentPage> {
//   late Razorpay _razorpay;
//   late double totalPrice;
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }
//
//   void openCheckout() async {
//     var options = {
//       'key': 'rzp_test_1DP5mmOlF5G5ag',
//       'amount': num.parse(totalPrice.toString()) * 100,
//       'name': 'Parth Dattani',
//       'description': 'Payment for some randonm product',
//       'prefill': {
//         'contact': '9512259792',
//         'email': 'parthdattani58@gmail.com',
//       },
//       'external': {
//         'wallets': ['paytm']
//       }
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     print("Payment Susccess");
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     print("Payment error");
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     print("EXTERNAL_WALLET ");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     CartProvider cartProvider = Provider.of<CartProvider>(context);
//     cartProvider.getCartData();
//
//     double subTotal = 120;
//
//     double discount = 5;
//     int shipping = 10;
//
//     double discountValue = (subTotal * discount) / 100;
//
//     double value = subTotal - discountValue;
//
//     totalPrice = value += shipping;
//
//     // if (cartProvider.getCartList.isEmpty) {
//     //   setState(() {
//     //     totalPrice = 0.0;
//     //   });
//     // }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chekout'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: cartProvider.getCartList.isEmpty
//                 ? Center(
//               child: Text("No Product"),
//             )
//                 : ListView.builder(
//               physics: BouncingScrollPhysics(),
//               itemCount: cartProvider.getCartList.length,
//               itemBuilder: (ctx, index) {
//                 var data = cartProvider.cartList[index];
//                 return CartItem(
//                   productId: data.productId,
//                   productCategory: data.productCategory,
//                   productImage: data.productImage,
//                   productPrice: data.productPrice,
//                   productQuantity: data.productQuantity,
//                   productName: data.productName,
//                   index: 1,
//                   cartId: "sd",
//                 );
//               },
//             ),
//           ),
//           Expanded(
//             child: Column(
//               children: [
//                 ListTile(
//                   leading: Text("Sub Total"),
//                   trailing: Text("\₹ subTotal"),
//                 ),
//                 ListTile(
//                   leading: Text("Discount"),
//                   trailing: Text("5%"),
//                 ),
//                 ListTile(
//                   leading: Text("Shiping"),
//                   trailing: Text("\₹10"),
//                 ),
//                 Divider(
//                   thickness: 2,
//                 ),
//                 ListTile(
//                   leading: Text("Total"),
//                   trailing: Text("\₹ $totalPrice"),
//                 ),
//                 cartProvider.getCartList.isEmpty
//                     ? Text("")
//                     : CommonButton(
//                   onPressed: () => openCheckout(),
//                   child: Text("Buy"),
//                   height: 18,
//                   color: Colors.red,
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
