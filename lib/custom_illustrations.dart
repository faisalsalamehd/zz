import 'package:flutter/material.dart';

class CustomIllustrations {
  
  // Shopping Cart Illustration
  static Widget shoppingCartIllustration({required Color color}) {
    return CustomPaint(
      size: Size(120, 120),
      painter: ShoppingCartPainter(color: color),
    );
  }
  
  // Trends/Gallery Illustration
  static Widget trendsIllustration({required Color color}) {
    return CustomPaint(
      size: Size(120, 120),
      painter: TrendsPainter(color: color),
    );
  }
  
  // Gift Box Illustration
  static Widget giftIllustration({required Color color}) {
    return CustomPaint(
      size: Size(120, 120),
      painter: GiftPainter(color: color),
    );
  }
  
  // Profile/Heart Illustration
  static Widget profileIllustration({required Color color}) {
    return CustomPaint(
      size: Size(120, 120),
      painter: ProfilePainter(color: color),
    );
  }
  
  // Search/Discovery Illustration
  static Widget searchIllustration({required Color color}) {
    return CustomPaint(
      size: Size(120, 120),
      painter: SearchPainter(color: color),
    );
  }
}

class ShoppingCartPainter extends CustomPainter {
  final Color color;
  
  ShoppingCartPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final strokePaint = Paint()
      ..color = color.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    
    // Cart body
    final cartRect = RRect.fromLTRBR(
      size.width * 0.2, size.height * 0.3,
      size.width * 0.8, size.height * 0.7,
      Radius.circular(8)
    );
    canvas.drawRRect(cartRect, strokePaint);
    
    // Cart handle
    final handlePath = Path()
      ..moveTo(size.width * 0.15, size.height * 0.25)
      ..lineTo(size.width * 0.15, size.height * 0.45)
      ..lineTo(size.width * 0.25, size.height * 0.45);
    canvas.drawPath(handlePath, strokePaint);
    
    // Cart wheels
    canvas.drawCircle(
      Offset(size.width * 0.35, size.height * 0.8),
      6, paint
    );
    canvas.drawCircle(
      Offset(size.width * 0.65, size.height * 0.8),
      6, paint
    );
    
    // Items in cart
    canvas.drawCircle(
      Offset(size.width * 0.4, size.height * 0.45),
      8, Paint()
        ..color = color.withOpacity(0.6)
        ..style = PaintingStyle.fill
    );
    canvas.drawCircle(
      Offset(size.width * 0.6, size.height * 0.5),
      6, Paint()
        ..color = color.withOpacity(0.8)
        ..style = PaintingStyle.fill
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TrendsPainter extends CustomPainter {
  final Color color;
  
  TrendsPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final strokePaint = Paint()
      ..color = color.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    // Gallery frames
    final frame1 = RRect.fromLTRBR(
      size.width * 0.1, size.height * 0.2,
      size.width * 0.45, size.height * 0.55,
      Radius.circular(6)
    );
    canvas.drawRRect(frame1, strokePaint);
    
    final frame2 = RRect.fromLTRBR(
      size.width * 0.55, size.height * 0.15,
      size.width * 0.9, size.height * 0.5,
      Radius.circular(6)
    );
    canvas.drawRRect(frame2, strokePaint);
    
    final frame3 = RRect.fromLTRBR(
      size.width * 0.2, size.height * 0.6,
      size.width * 0.8, size.height * 0.85,
      Radius.circular(6)
    );
    canvas.drawRRect(frame3, strokePaint);
    
    // Trend arrow
    final arrowPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.4)
      ..lineTo(size.width * 0.7, size.height * 0.3)
      ..lineTo(size.width * 0.65, size.height * 0.25)
      ..moveTo(size.width * 0.7, size.height * 0.3)
      ..lineTo(size.width * 0.65, size.height * 0.35);
    canvas.drawPath(arrowPath, strokePaint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GiftPainter extends CustomPainter {
  final Color color;
  
  GiftPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final strokePaint = Paint()
      ..color = color.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    
    // Gift box
    final giftRect = RRect.fromLTRBR(
      size.width * 0.25, size.height * 0.4,
      size.width * 0.75, size.height * 0.8,
      Radius.circular(4)
    );
    canvas.drawRRect(giftRect, strokePaint);
    
    // Ribbon vertical
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.2),
      Offset(size.width * 0.5, size.height * 0.8),
      strokePaint
    );
    
    // Ribbon horizontal
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.6),
      Offset(size.width * 0.8, size.height * 0.6),
      strokePaint
    );
    
    // Bow
    final bowPath = Path()
      ..moveTo(size.width * 0.4, size.height * 0.25)
      ..quadraticBezierTo(
        size.width * 0.35, size.height * 0.15,
        size.width * 0.45, size.height * 0.2
      )
      ..quadraticBezierTo(
        size.width * 0.5, size.height * 0.15,
        size.width * 0.55, size.height * 0.2
      )
      ..quadraticBezierTo(
        size.width * 0.65, size.height * 0.15,
        size.width * 0.6, size.height * 0.25
      );
    canvas.drawPath(bowPath, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ProfilePainter extends CustomPainter {
  final Color color;
  
  ProfilePainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final strokePaint = Paint()
      ..color = color.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    
    // Heart shape
    final heartPath = Path();
    final heartSize = size.width * 0.3;
    final centerX = size.width * 0.5;
    final centerY = size.height * 0.45;
    
    heartPath.moveTo(centerX, centerY + heartSize * 0.3);
    
    // Left curve
    heartPath.cubicTo(
      centerX - heartSize * 0.6, centerY - heartSize * 0.1,
      centerX - heartSize * 0.6, centerY - heartSize * 0.6,
      centerX - heartSize * 0.2, centerY - heartSize * 0.4
    );
    
    // Right curve
    heartPath.cubicTo(
      centerX + heartSize * 0.2, centerY - heartSize * 0.6,
      centerX + heartSize * 0.6, centerY - heartSize * 0.6,
      centerX + heartSize * 0.6, centerY - heartSize * 0.1
    );
    
    heartPath.cubicTo(
      centerX + heartSize * 0.6, centerY + heartSize * 0.1,
      centerX, centerY + heartSize * 0.6,
      centerX, centerY + heartSize * 0.3
    );
    
    heartPath.close();
    canvas.drawPath(heartPath, paint);
    
    // Profile circle
    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.3),
      12, strokePaint
    );
    
    // Profile head
    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.27),
      4, paint
    );
    
    // Profile body
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width * 0.7, size.height * 0.32),
        radius: 6
      ),
      0, 3.14, false, strokePaint
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SearchPainter extends CustomPainter {
  final Color color;
  
  SearchPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final strokePaint = Paint()
      ..color = color.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    
    // Search circle
    canvas.drawCircle(
      Offset(size.width * 0.4, size.height * 0.4),
      size.width * 0.15,
      strokePaint
    );
    
    // Search handle
    canvas.drawLine(
      Offset(size.width * 0.52, size.height * 0.52),
      Offset(size.width * 0.65, size.height * 0.65),
      strokePaint
    );
    
    // Discovery elements
    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.25),
      6, Paint()
        ..color = color.withOpacity(0.6)
        ..style = PaintingStyle.fill
    );
    
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.4),
      4, Paint()
        ..color = color.withOpacity(0.8)
        ..style = PaintingStyle.fill
    );
    
    canvas.drawCircle(
      Offset(size.width * 0.25, size.height * 0.7),
      5, Paint()
        ..color = color.withOpacity(0.7)
        ..style = PaintingStyle.fill
    );
    
    // Connection lines
    canvas.drawLine(
      Offset(size.width * 0.4, size.height * 0.4),
      Offset(size.width * 0.7, size.height * 0.25),
      strokePaint..strokeWidth = 1
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}