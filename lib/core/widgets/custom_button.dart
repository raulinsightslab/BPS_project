// core/widgets/custom_button.dart
import 'package:flutter/material.dart';

// //tombol
// class NextButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final String text;
//   final Color backgroundColor;
//   final Color textColor;

//   const NextButton({
//     super.key,
//     required this.onPressed,
//     required this.text,
//     this.backgroundColor = Colors.orange,
//     this.textColor = Colors.white,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 50,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           elevation: 2,
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: textColor,
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }

// //card selection button
// class ProgramCard extends StatelessWidget {
//   final String title;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const ProgramCard({
//     super.key,
//     required this.title,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap, // tetap panggil fungsi dari parent (screen)
//       child: Container(
//         margin: EdgeInsets.only(bottom: 12),
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.green[100] : Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected ? Colors.green : Colors.grey.shade300,
//             width: 2,
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 18,
//                 color: isSelected ? Colors.green[800] : Colors.black87,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//             if (isSelected) const Icon(Icons.check_circle, color: Colors.green),
//           ],
//         ),
//       ),
//     );
//   }
// }

class OnboardingButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const OnboardingButton({Key? key, required this.text, this.onPressed})
    : super(key: key);

  @override
  _OnboardingButtonState createState() => _OnboardingButtonState();
}

class _OnboardingButtonState extends State<OnboardingButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFA726), Color(0xFFFFB74D)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
          border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
        ),
        child: Transform.scale(
          scale: _isPressed ? 0.98 : 1.0,
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
