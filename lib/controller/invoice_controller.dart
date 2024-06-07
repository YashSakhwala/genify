import 'package:get/get.dart';

class Item {
  String name;
  int quantity;
  double price;

  Item({
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class InvoiceController extends GetxController {
  var name = ''.obs;
  var address = ''.obs;
  var items = <Item>[].obs;

  void addItem() {
    items.add(Item(name: "", quantity: 0, price: 0.0));
  }

  void removeItem(int index) {
    items.removeAt(index);
  }

  void updateName(String value) {
    name.value = value;
  }

  void updateAddress(String value) {
    address.value = value;
  }
}
