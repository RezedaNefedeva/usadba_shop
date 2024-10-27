
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/first_page/first_page.dart';
import 'package:firebase_app/features/profile/widgets/btn_firebase.dart';
import 'package:firebase_app/models/cart_order_model/cart_order_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_app/theme/theme.dart';
import '../../cart/cart.dart';
import '../../cart/widgets/shared_order/shared_order.dart';
import '../../profile/widgets/shared_data.dart';
import '../../recepts/widgets/widgets.dart';
import '../view/category_page.dart';

class productInfo extends StatefulWidget {
  const productInfo({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.weight,
    required this.price,
  });
  final String imageUrl;
  final String title;
  final String description;
  final String weight;
  final String price;

  @override
  State<productInfo> createState() => _productInfoState();
}

class _productInfoState extends State<productInfo> {

  SharedOrderDataBase db = SharedOrderPrefs();

  late int counter = 1;

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
  void initState() {
    SharedData.initName();
    super.initState();
  }

  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController weightController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context);

    descriptionController.text = widget.description;
    priceController.text = widget.price;
    weightController.text = widget.weight;

    loadImage(widget.imageUrl);
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 100,),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child:
                        widget.imageUrl != '' ?
                    Image(image: NetworkImage(widget.imageUrl),
                        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                          return child;
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: bordo(),
                                strokeWidth: 3,
                              ),
                            );
                          }
                        }
                    ):
                        Center(
                          child: CircularProgressIndicator(
                            color: bordo(),
                            strokeWidth: 3,
                          ),
                        ),
                  ),
                ),
                const SizedBox(height: 20,),
                Text(widget.title, style:  textTheme.textTheme.labelLarge,),
                const Image(image: AssetImage('assets/line.png')),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(child: Text(widget.description, style: textTheme.textTheme.titleMedium,))
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.weight, style: textTheme.textTheme.titleMedium,),
                    Text('${widget.price} руб', style: textTheme.textTheme.labelLarge,),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    cartOrderModel = CartOrderModel(
                        productId: '${Cart.cartOrders.cartLength}',
                        producImage: widget.imageUrl,
                        productTitle: widget.title,
                        productWeight: widget.weight,
                        productPrice: widget.price,
                        quantity: counter,
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
                  child: const buttonFirebase(widthBtn: 180, heightBtn: 54, btnText: 'Купить', fontFamily: 'Roboto', fontSize: 16),
                ),
                Container(
                // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
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
                          if(counter>1) {
                            counter--;
                          }
                        });
                        },
                        icon: const Icon(Icons.remove,)),
                        const SizedBox(width: 6,),
                        Text('$counter', style: textTheme.textTheme.titleLarge,),
                        const SizedBox(width: 6,),
                        IconButton(
                        onPressed: (){
                          setState(() {
                            counter++;
                          });
                        },
                            icon: const Icon(Icons.add,)),
                  ],
                  ),
                  ),
              ],
            ),
            SharedData.userPhone == '89279589087' || SharedData.userPhone == '89649624648'?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Редактировать товар'),
                                      content: SingleChildScrollView(
                                        child: Container(
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 20.0,),
                                              Text('Описание', style: textTheme.textTheme.displayMedium,),
                                              TextFieldRecept(
                                                hintText: 'Описание товара',
                                                controller: descriptionController,
                                                hintcolor: Colors.black,
                                              ),
                                              const SizedBox(height: 20.0,),
                                              Text('За какой вес цена', style: textTheme.textTheme.displayMedium,),
                                              TextFieldRecept(
                                                hintText: 'За какой вес цена',
                                                controller: weightController,
                                                hintcolor: Colors.black,
                                              ),
                                              const SizedBox(height: 20.0,),
                                              Text('Цена товара', style: textTheme.textTheme.displayMedium,),
                                              TextFieldRecept(
                                                hintText: 'Цена товара',
                                                controller: priceController,
                                                hintcolor: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                          child: const buttonFirebase(
                                              widthBtn: 100,
                                              heightBtn: 40,
                                              btnText: 'Отмена',
                                              fontFamily: 'Roboto',
                                              fontSize: 12),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            FirebaseFirestore.instance.collection(CategoryPage.category_name).doc(widget.title).update({

                                              'description' : descriptionController.text,
                                              'weight' : weightController.text,
                                              'price' : priceController.text,
                                            }
                                            );
                                            Navigator.pop(context);

                                          },
                                          child: const buttonFirebase(
                                              widthBtn: 100,
                                              heightBtn: 40,
                                              btnText: 'Сохранить',
                                              fontFamily: 'Roboto',
                                              fontSize: 12),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.edit)),
                        Text('Редактировать', style: textTheme.textTheme.titleMedium,)
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Товар будет удален безвозвратно.\nУдалить?'),
                                      actions: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                          child: const buttonFirebase(
                                              widthBtn: 100,
                                              heightBtn: 40,
                                              btnText: 'Отмена',
                                              fontFamily: 'Roboto',
                                              fontSize: 12),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            FirebaseFirestore.instance.collection(CategoryPage.category_name).doc(widget.title).delete();
                                            Navigator.pop(context);
                                            streamController.add(11);
                                          },
                                          child: const buttonFirebase(
                                              widthBtn: 100,
                                              heightBtn: 40,
                                              btnText: 'Удалить',
                                              fontFamily: 'Roboto',
                                              fontSize: 12),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.delete_outline)),
                        Text('Удалить', style: textTheme.textTheme.titleMedium,)
                      ],
                    ),

                  ],
                ) :
                Text('', style: textTheme.textTheme.labelSmall,)
          ]
        ),
      ),
    );
  }
}
