

import 'package:firebase_app/features/cart/cart.dart';
import 'package:firebase_app/features/cart/widgets/shared_order/shared_order.dart';
import 'package:firebase_app/features/catalog/catalog.dart';
import 'package:firebase_app/features/first_page/first_page.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:firebase_app/models/cart_order_model/cart_order_model.dart';
import 'package:firebase_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';

class productCard extends StatefulWidget {
  const productCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.weight,
    required this.price});
  final String imageUrl;
  final String title;
  final String weight;
  final String price;

  @override
  State<productCard> createState() => _productCardState();
}

class _productCardState extends State<productCard> {

  SharedOrderDataBase db = SharedOrderPrefs();
  late int counter;

  bool isFound = false;

  late CartOrderModel cartOrderModel;

  Future<void> loadImage(String imageUrl) async {
    try {
      // load network image example
      await precacheImage(NetworkImage(imageUrl), context);
    } catch (e) {
    }
  }


  @override
  Widget build(BuildContext context) {
    counter = 1;

    final textTheme = Theme.of(context);

    loadImage(widget.imageUrl);

    return InkWell(
      onTap: (){
        setState(() {
          productPage.product_title = widget.title;
          streamController.add(12);
          streamControllerBottom.add(1);
          productPage.backFrom = false;
        });
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        shadowColor: Colors.black87,
        elevation: 5,
        child: SizedBox(
          height: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.all(8.0)
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: SizedBox(
                  width: 124,
                  height: 124,
                  child:
                  CachedNetworkImage(
                    imageUrl: widget.imageUrl,
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
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                          child: Text(widget.title,
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            style: textTheme.textTheme.displayMedium,)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.weight, style: textTheme.textTheme.titleMedium,),
                              Text('${widget.price} руб', style: textTheme.textTheme.displayMedium,),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(right: 30)),
                          InkWell(
                            onTap: (){
                              cartOrderModel = CartOrderModel(
                                  productId: '${Cart.cartOrders.cartLength}',
                                  producImage: widget.imageUrl,
                                  productTitle: widget.title,
                                  productWeight: widget.weight,
                                  productPrice: widget.price,
                                  quantity: 1,
                                  price: double.tryParse(widget.price) ?? 0.0);
                              setState(() {
                                for(int i = 0; i < Cart.cartOrders.cartLength; i++ ){
                                  if(widget.title == Cart.cartOrders.cartItemsList[i].productTitle){
                                    isFound = true;
                                    Fluttertoast.showToast(
                                        msg: "Этот товар уже есть в корзине",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.white,
                                        textColor: bordo(),
                                        fontSize: 20.0);
                                  }
                                }
                                if(!isFound){
                                  Cart.cartOrders.addToCart(cartOrderModel: cartOrderModel);
                                  Fluttertoast.showToast(
                                      msg: "${widget.title} добавлен в корзину",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: bordo(),
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }
                              });
                              
                            },
                            child: const Image(image: AssetImage('assets/cart_btn.png'),),
                          )
                        ],
                      )
                    ],

                  ),
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
