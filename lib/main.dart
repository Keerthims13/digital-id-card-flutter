import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MaterialApp(
      home: IDCardApp(),
      debugShowCheckedModeBanner: false,
    ));

class IDCardApp extends StatefulWidget {
  const IDCardApp({super.key});

  @override
  State<IDCardApp> createState() => _IDCardAppState();
}

class _IDCardAppState extends State<IDCardApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  void _flipCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: Center(
          child: GestureDetector(
            onTap: _flipCard,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final angle = _controller.value * pi;
                final isBackVisible = _controller.value >= 0.5;

                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle),
                  alignment: Alignment.center,
                  child: isBackVisible
                      ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(pi),
                          child: const BackSide(),
                        )
                      : const FrontSide(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class FrontSide extends StatelessWidget {
  const FrontSide({super.key});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("NMAM INSTITUTE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1.2)),
                  Text("OF TECHNOLOGY",
                      style: TextStyle(fontSize: 14, letterSpacing: 1)),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: 100,
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black87),
                        image: const DecorationImage(
                          image: AssetImage('assets/keerthi.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "KEERTHI M S",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(height: 12),
                  detailRow("College", "NMAMIT"),
                  detailRow("Course", "MCA"),
                  detailRow("USN", "NNM24MC067"),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("NNM24MC067",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Image.asset("assets/barcode.jpg", width: 100, height: 40),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 80,
              child: Text("$label:",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black87))),
          Expanded(
              child: Text(value,
                  style: const TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }
}

class BackSide extends StatelessWidget {
  const BackSide({super.key});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(14),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Year of Adm.  :  2024-2025"),
                Text("Date of Birth :  13.11.2003"),
                Text("Blood Group  :  B+VE"),
                Text("Address         :"),
                SizedBox(height: 4),
                Text("CRYSTAL APARTMENT D. NO :106"),
                Text("BHAGAVATHI NAGAR, KODIALGUTTHU"),
                Text("KODIALBAIL WEST -575003"),
                Text("MANGALORE D.K."),
                Text("KARNATAKA"),
                SizedBox(height: 10),
                Text("If found, please return to:"),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("NITTE | NMAM INSTITUTE OF TECHNOLOGY",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Off-Campus Centre of Nitte (DU)"),
                  SizedBox(height: 6),
                  Text("Nitte - 574 110, Karkala Taluk"),
                  Text("Udupi District, Karnataka, India"),
                  Text("W : nnamit.nitte.edu.in"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardContainer extends StatelessWidget {
  final Widget child;
  const CardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 420,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, blurRadius: 12, offset: Offset(4, 6)),
        ],
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(14), child: child),
    );
  }
}

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..repeat(reverse: true);

    _color1 = ColorTween(begin: Colors.blue[200], end: Colors.purple[100])
        .animate(_controller);
    _color2 = ColorTween(begin: Colors.teal[100], end: Colors.pink[100])
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_color1.value ?? Colors.white, _color2.value ?? Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
