import 'package:flutter/material.dart';
// import 'dart:math';

void main() {
  runApp(const MagicCounterApp());
}

class MagicCounterApp extends StatelessWidget {
  const MagicCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MagicCounter(),
    );
  }
}

class MagicCounter extends StatefulWidget {
  const MagicCounter({super.key});

  @override
  State<MagicCounter> createState() => _MagicCounterState();
}

class _MagicCounterState extends State<MagicCounter>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  final TextEditingController _controller = TextEditingController();
  late final AnimationController _animController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    // _animController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 1),
    // );
    _colorAnimation = ColorTween(
      begin: Colors.deepPurple,
      end: const Color.fromARGB(255, 78, 13, 191),
    ).animate(_animController);
  }

  void _castSpell(String text) {
    if (text.trim().toLowerCase() == 'avada kedavra') {
      setState(() => _counter = 0);
      _playAnimation();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('💀 Avada Kedavra! Counter reset to 0.')),
      );
    } else if (int.tryParse(text) != null) {
      setState(() => _counter += int.parse(text));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('➕ Added ${int.parse(text)} to counter.')),
      );
    } else {
      _playAnimation();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✨ A magical effect occurred!')),
      );
    }
    _controller.clear();
  }

  void _playAnimation() {
    _animController.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, _) => Scaffold(
        backgroundColor: _colorAnimation.value,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '🧙‍♂️ Magic Counter',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    '$_counter',
                    key: ValueKey<int>(_counter),
                    style: const TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Enter a number or a spell...',
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onSubmitted: _castSpell,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => _castSpell(_controller.text),
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('Cast!'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
