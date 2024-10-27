
import 'package:flutter/cupertino.dart';

class lines extends StatelessWidget {
  const lines({super.key, required this.title_text});
  final String title_text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Image (image: AssetImage ('assets/up_lines.png')),
        const Padding(padding: EdgeInsets.only(top: 4)),
        Text(title_text, style: const TextStyle(fontFamily: 'OrelegaOne', fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xff730909))),
        const Padding(padding: EdgeInsets.only(top: 4)),
        const Image(image: AssetImage ('assets/down_lines.png')),
      ],
    );
  }
}


// Column lines (String text){
//     return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Image (image: AssetImage ('assets/up_lines.png')),
//             const Padding(padding: EdgeInsets.only(top: 4)),
//             Text(text, style: TextStyle(fontFamily: 'OrelegaOne', fontSize: 32, fontWeight: FontWeight.w700, color: Color(0xff730909))),
//             const Padding(padding: EdgeInsets.only(top: 4)),
//             const Image(image: AssetImage ('assets/down_lines.png')),
//           ],
//         );
//   }
