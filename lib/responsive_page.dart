import 'package:ariston/responsive.dart';
import 'package:flutter/material.dart';

class ResponsivePage extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double maxContentWidth;
  final EdgeInsetsGeometry? padding;
  final Widget? bottomNavigationBar;

  const ResponsivePage({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.maxContentWidth = 480,
    this.padding,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.horizontalPadding(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar == null
          ? null
          : Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: bottomNavigationBar,
              ),
            ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: padding ??
              EdgeInsets.symmetric(horizontal: hPad, vertical: 24),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}