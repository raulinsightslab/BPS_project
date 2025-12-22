import 'package:bps_e_learning/views/introduction/screens/program_selection_screen.dart';
import 'package:flutter/material.dart';

class ProgramCard extends StatefulWidget {
  final Program program;
  final bool isSelected;
  final VoidCallback onTap;

  const ProgramCard({
    Key? key,
    required this.program,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  _ProgramCardState createState() => _ProgramCardState();
}

class _ProgramCardState extends State<ProgramCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFE0B2), Color(0xFFFFFFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
            border: widget.isSelected
                ? Border.all(color: Color(0xFFFFA726), width: 2)
                : null,
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.program.icon,
                  color: Color(0xFFFFA726),
                  size: 28,
                ),
              ),
              SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.program.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF212121),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.program.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF616161),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              // Selection Indicator
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.isSelected ? Color(0xFFFFA726) : Colors.grey,
                    width: 2,
                  ),
                  color: widget.isSelected
                      ? Color(0xFFFFA726)
                      : Colors.transparent,
                ),
                child: widget.isSelected
                    ? Icon(Icons.check, size: 12, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
