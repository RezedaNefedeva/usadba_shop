
import 'package:firebase_app/features/home/widgets/button-design.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/theme/theme.dart';
import '../../first_page/first_page.dart';
import '../../first_page/widgets/widgets.dart';
import '../../recepts/recepts.dart';

class receptCard extends StatefulWidget {
  const receptCard({super.key, required this.img, required this.recept_name});
  final String img;
  final String recept_name;

  @override
  State<receptCard> createState() => _receptCardState();
}

class _receptCardState extends State<receptCard> {

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.white,
      shadowColor: Colors.black87,
      elevation: 5,
      child: SizedBox(
        width: 200,
        child: InkWell(
          onTap: (){
            setState(() {
              ReceptPage.recept_title = widget.recept_name;
              streamController.add(20);
              streamControllerBottom.add(3);
              ReceptPage.backFrom = true;
            });
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: SizedBox(
                    width: 124,
                    height: 124,
                    child:
                    Image(image: NetworkImage(widget.img),
                        fit: BoxFit.cover,
                        frameBuilder: (context, child, frame,
                            wasSynchronouslyLoaded) {
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
                    ),
                  ),
                ),
              ),
              Flexible(child: Text(widget.recept_name, style: textTheme.textTheme.bodyLarge, textAlign: TextAlign.center,)),
              const buttonDesign(widthBtn: 120, heightBtn: 48, btnText: 'В рецепт', indexNav: 3, fontSize: 16, fontFamily: 'Roboto',)
            ],
          ),
        ),
      ),
    );
  }
}
