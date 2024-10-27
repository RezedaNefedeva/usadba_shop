import 'package:firebase_app/features/cart/view/cart.dart';
import 'package:firebase_app/features/catalog/catalog.dart';
import 'package:firebase_app/features/checkoutt_page/checkoutPage.dart';
import 'package:firebase_app/features/finish_page/finish_page.dart';
import 'package:firebase_app/features/first_page/view/firstPage.dart';
import 'package:firebase_app/features/map_flutter/view/map_flutter.dart';
import 'package:firebase_app/features/profile/profile.dart';
import 'package:firebase_app/features/recepts/recepts.dart';
import 'package:firebase_app/features/recepts/view/add_recept.dart';


final routes = {
    '/': (context) => FirstPage(stream: streamController.stream, streamName: streamControllerUser.stream,),
    '/cart': (context) => const Cart(),
    '/catalog': (context) => const Catalog(),
    '/profile': (context) => const Profile(),
    '/recepts': (context) => const Recepts(),
    '/map': (context) => const Map_Flutter(),
    '/auth': (context) => const Auth(),
    '/reg': (context) => const Registration(),
    '/admin_profile': (context) => const AdminProfile(),
    '/add_product': (context) => const AddProduct(),
    '/all_users': (context) => const AllUsers(),
    '/category_page': (context) => const CategoryPage(),
    '/product_page': (context) => const productPage(),
    '/checkout_page': (context) => const checkoutPage(),
    '/checkout_page_pickup': (context) => const checkoutPagePickUp(),
    '/finish_page_delivery': (context) => const FinishPageDelivery(),
    '/finish_page_pickup': (context) => const FinishPagePickup(),
    '/my_orders' : (context) => const MyOrders(),
    '/my_data' : (context) => const MyData(),
    '/recept_page' : (context) => const ReceptPage(),
    '/add_recept' : (context) => const AddRecept(),
};