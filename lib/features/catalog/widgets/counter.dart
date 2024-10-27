
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  int counter = 1;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Container(
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
                  if(counter>1) counter--;
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
    );
  }
}
