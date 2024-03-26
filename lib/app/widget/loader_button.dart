import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoaderButton extends StatefulWidget {
  final String btnText;
  final Color? textColor;
  final double? radius;
  final Color? borderSide;
  final Future<void> Function() onTap;
  final Color? color;
  final double? fontSize;
  final FontWeight? weight;

  const LoaderButton({
    super.key,
    required this.btnText,
    required this.onTap,
    this.color,
    this.textColor,
    this.fontSize,
    this.weight,
    this.radius,
    this.borderSide,
  });

  @override
  State<LoaderButton> createState() => _LoaderButtonState();
}

class _LoaderButtonState extends State<LoaderButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius ?? 20),
              border:
                  Border.all(color: widget.borderSide ?? Colors.transparent),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  offset: Offset(-1, 1),
                  blurRadius: 10,
                )
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: widget.color ?? const Color(0xff06B198),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 20),
                  side: BorderSide(
                      color: widget.borderSide ?? Colors.transparent),
                ),
                minimumSize: Size(MediaQuery.of(context).size.width, 45),
              ),
              onPressed: () async {
                if (mounted) {
                  setState(() => loading = true);
                }
                await widget.onTap();
                if (mounted) {
                  setState(() => loading = false);
                }
              },
              child: Text(
                widget.btnText,

                // style: Theme.of(context).textTheme.labelLarge?.copyWith(
                //       color: widget.textColor ?? Colors.white,
                //       fontSize: widget.fontSize ?? 15,
                //       letterSpacing: 0.9,
                //       fontWeight: widget.weight ?? FontWeight.w500,
                //     ),

                style: GoogleFonts.poppins(
                  color: widget.textColor ?? Colors.white,
                  fontSize: widget.fontSize ?? 15,
                  letterSpacing: 0.9,
                  fontWeight: widget.weight ?? FontWeight.w500,
                ),
              ),
            ),
          );
  }
}
