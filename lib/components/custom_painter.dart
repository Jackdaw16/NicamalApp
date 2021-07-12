import 'package:flutter/widgets.dart';

class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 245, 245, 245)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;


    Path path_0 = Path();
    path_0.moveTo(size.width*0.0000200,size.height*0.5004200);
    path_0.quadraticBezierTo(size.width*0.2996000,size.height*0.4570800,size.width*0.5000800,size.height*0.4567200);
    path_0.quadraticBezierTo(size.width*0.6998400,size.height*0.4572200,size.width,size.height*0.5008000);
    path_0.lineTo(size.width*0.9993800,size.height);
    path_0.lineTo(size.width*0.0004400,size.height*0.9986200);
    path_0.lineTo(size.width*0.0000200,size.height*0.5004200);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
