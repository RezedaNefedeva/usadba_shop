
import 'package:firebase_app/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_app/cart.dart';
import 'package:firebase_app/features/cart/widgets/order_cart.dart';
import 'package:firebase_app/features/first_page/view/view.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:firebase_app/features/home/widgets/lines.dart';
import 'package:firebase_app/features/profile/widgets/btn_firebase.dart';
import 'package:firebase_app/models/order_models/item_order_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:googleapis/chat/v1.dart';
import '../../../models/models.dart';
import '../../appBar/app_bar.dart';
import '../../profile/widgets/shared_data.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  static CartOrderModel? cartOrder;

  static var cartOrders = FlutterCart();

  static void removeItemFromCart(CartOrderModel item){
    cartOrders.removeItem(item.productId);
  }

  static late OrderModel orderModel;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  int quantity = 1;

  late double total;

  late ItemOrderModel _orderModel;

  final List<String> _items_order = [];

  @override
  void initState() {
    total = Cart.cartOrders.discount;
    super.initState();
    SharedData.initName();
  }

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context);

    IconData icon = Icons.check_box_outline_blank;

    return
      Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
        height: 184,
        child: Column(
          children: [
            SizedBox(height: 100,),
            lines(title_text: 'Корзина'),
            SizedBox(height: 6,),
          ],
        ),
      ),
        body: Stack(
          children: [
            if(Cart.cartOrders.cartLength == 0) const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('В корзине пока ничего нет')]),
            ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: Cart.cartOrders.cartLength,
              itemBuilder: (context, index) =>
                  InkWell(
                      onTap: (){
                      setState(() {
                        orderCart().tapOnCart(index);
                      });
                    },
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.white,
                      shadowColor: Colors.black87,
                      elevation: 5,
                      child: SizedBox(
                          height: 120,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(padding: EdgeInsets.all(8.0)),
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child:
                                    CachedNetworkImage(
                                      imageUrl: Cart.cartOrders.cartItemsList[index].producImage!,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          Center(
                                            child: CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                              color: bordo(),
                                              strokeWidth: 2,),
                                          ),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.only(right: 8)),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 240,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(child: Text(Cart.cartOrders.cartItemsList[index].productTitle, style: textTheme.textTheme.displaySmall,)),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                Cart.removeItemFromCart(Cart.cartOrders.cartItemsList[index]);
                                                total = Cart.cartOrders.discount;
                                              });
                                            },
                                            child: const Icon(Icons.delete_outline, size: 28,),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 240,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(Cart.cartOrders.cartItemsList[index].productWeight, style: textTheme.textTheme.labelSmall,),
                                              Text('${Cart.cartOrders.cartItemsList[index].productPrice} руб', style: textTheme.textTheme.displaySmall,),
                                            ],
                                          ),
                                          Container(
                                              height: 48,
                                              width: 120,
                                              decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                                              border: Border.all(color: Colors.black, width: 2)
                                              ),
                                            child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                                IconButton(
                                                      onPressed: (){
                                                      setState(() {
                                                        quantity = Cart.cartOrders.cartItemsList[index].quantity;
                                                        if(Cart.cartOrders.cartItemsList[index].quantity>1) quantity--;
                                                        Cart.cartOrders.updateQuantity(Cart.cartOrders.cartItemsList[index].productId, quantity);
                                                        total = Cart.cartOrders.discount;
                                                        });
                                                      },
                                                    icon: const Icon(Icons.remove, size: 28,)),
                                                const SizedBox(width: 2,),
                                                Text('${Cart.cartOrders.cartItemsList[index].quantity}', style: textTheme.textTheme.bodyLarge,),
                                                const SizedBox(width: 8,),
                                                IconButton(
                                                    onPressed: (){
                                                      setState(() {
                                                        quantity = Cart.cartOrders.cartItemsList[index].quantity;
                                                        quantity++;
                                                        Cart.cartOrders.updateQuantity(Cart.cartOrders.cartItemsList[index].productId, quantity);
                                                        total = Cart.cartOrders.discount;
                                                      });
                                                      },
                                                       icon: const Icon(Icons.add, size: 28,)),
                                                ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],

                                ),
                              ]
                          )
                      ),
                    ),
                  ),
              ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white,
                child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Итого: ', style: textTheme.textTheme.labelLarge,),
                            Text('$total руб', style: textTheme.textTheme.labelLarge,)
                          ]),
                      InkWell(
                        onTap: (){
                          setState(() {
                            if(Cart.cartOrders.cartLength == 0) {
                              Fluttertoast.showToast(
                                  msg: "Мы не можем оформить пустую корзину. Предлагают добавить в нее вкусностей",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: bordo(),
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            } else {
                              if(SharedData.showAlertDialog == ''){
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text (
                                          '"Усадьба мясника" это магазин домашней продукции.'
                                              '\nМы не можем сделать четкий определенный вес на некоторые позиции (колбасы, мясо, купаты и т.п.), '
                                              'поэтому сумма заказа в корзине является примерной. '
                                              'Точную сумму мы Вам сообщим, когда заказ будет собран. '
                                              '\nСпасибо за понимание', style: textTheme.textTheme.titleMedium,),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  Navigator.pop(context);
                                                },
                                                child: const buttonFirebase(
                                                    widthBtn: 110,
                                                    heightBtn: 40,
                                                    btnText: 'Отмена',
                                                    fontFamily: 'Roboto',
                                                    fontSize: 10),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  for (int i = 0; i <
                                                      Cart.cartOrders.cartLength; i++) {
                                                    _orderModel = ItemOrderModel(
                                                        i+1,
                                                        Cart.cartOrders.cartItemsList[i]
                                                            .productTitle,
                                                        Cart.cartOrders.cartItemsList[i].quantity,
                                                        Cart.cartOrders.cartItemsList[i].price);
                                                    _items_order.add(_orderModel.itemToString());
                                                  }
                                                  Cart.orderModel = OrderModel(
                                                      orderList: _items_order, total: total);
                                                  streamController.add(13);
                                                  streamControllerBottom.add(2);

                                                  Navigator.pop(context);
                                                },
                                                child: const buttonFirebase(
                                                    widthBtn: 110,
                                                    heightBtn: 40,
                                                    btnText: 'Я понимаю',
                                                    fontFamily: 'Roboto',
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  for (int i = 0; i <
                                                      Cart.cartOrders.cartLength; i++) {
                                                    _orderModel = ItemOrderModel(
                                                        i+1,
                                                        Cart.cartOrders.cartItemsList[i]
                                                            .productTitle,
                                                        Cart.cartOrders.cartItemsList[i].quantity,
                                                        Cart.cartOrders.cartItemsList[i].price);
                                                    _items_order.add(_orderModel.itemToString());
                                                  }
                                                  Cart.orderModel = OrderModel(
                                                      orderList: _items_order, total: total);

                                                  SharedData.setShowAD('showAD');

                                                  streamController.add(13);
                                                  streamControllerBottom.add(2);

                                                  Navigator.pop(context);
                                                },
                                                child: const buttonFirebase(
                                                    widthBtn: 220,
                                                    heightBtn: 40,
                                                    btnText: 'Больше не показывать',
                                                    fontFamily: 'Roboto',
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                for (int i = 0; i <
                                    Cart.cartOrders.cartLength; i++) {
                                  _orderModel = ItemOrderModel(
                                      i+1,
                                      Cart.cartOrders.cartItemsList[i]
                                          .productTitle,
                                      Cart.cartOrders.cartItemsList[i].quantity,
                                      Cart.cartOrders.cartItemsList[i].price);
                                  _items_order.add(_orderModel.itemToString());
                                }
                                Cart.orderModel = OrderModel(
                                    orderList: _items_order, total: total);
                                streamController.add(13);
                                streamControllerBottom.add(2);
                              }
                            }
                          });

                        },
                        child: const buttonFirebase(widthBtn: 300, heightBtn: 48, btnText: 'Оформить заказ', fontFamily: 'Roboto', fontSize: 16)),
                    ]
                            ),
              )
            )
          ]
        )
      );
  }
}
