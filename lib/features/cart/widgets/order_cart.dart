
import 'package:firebase_app/features/cart/view/cart.dart';
import 'package:firebase_app/features/catalog/catalog.dart';
import 'package:firebase_app/features/first_page/first_page.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';

class orderCart {

  void tapOnCart(int index){
    productPage.product_title = Cart.cartOrders.cartItemsList[index].productTitle;
    streamController.add(12);
    streamControllerBottom.add(1);
    productPage.backFrom = true;
  }

}