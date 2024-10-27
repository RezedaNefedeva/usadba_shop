
import 'package:flutter/material.dart';

class CounterCartOrder extends StatefulWidget {
  const CounterCartOrder({super.key});

  @override
  State<CounterCartOrder> createState() => _CounterCartOrderState();
}

class _CounterCartOrderState extends State<CounterCartOrder> {

  int index = 1;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Container(
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
                  if(index>1) index--;
                });
              },
              icon: const Icon(Icons.remove, size: 28,)),
          const SizedBox(width: 2,),
          Text('$index', style: textTheme.textTheme.bodyLarge,),
          const SizedBox(width: 8,),
          IconButton(
              onPressed: (){
                setState(() {
                  index++;
                });
              },
              icon: const Icon(Icons.add, size: 28,)),
        ],
      ),
    );
  }
}