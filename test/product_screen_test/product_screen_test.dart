import 'package:flutter_test/flutter_test.dart';
import 'package:model_bottom/utill/utill.dart';

void main(){
  group("Product", () {
  test("productName is empty", () {
    String? result = Validator.isProductName("");

    expect(result, "please enter product name");
  });

  test("description is empty", () {
    String? result = Validator.isDescription("");

    expect(result, "please enter descrition");
  });

  test("product Quantity is empty", () {
    String? result = Validator.isQuantity("");

    expect(result, "please enter product Quantity");
  });

  test("product price is empty", () {
    String? result = Validator.isPrice("");

    expect(result, "please enter price");
  });
  });
}
