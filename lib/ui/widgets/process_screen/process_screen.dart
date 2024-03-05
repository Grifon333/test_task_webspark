import 'package:flutter/material.dart';

class ProcessScreen extends StatelessWidget {
  const ProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process screen'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: _BodyWidget(),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: SizedBox()),
        const Text(
          'All calculation has finished, you can send your result to server',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        const Text(
          '100%',
          style: TextStyle(fontSize: 20),
        ),
        const Divider(),
        const SizedBox(width: 100, height: 100, child: CircularProgressIndicator(value: 1,)),
        const Expanded(child: SizedBox()),
        ElevatedButton(
          onPressed: () {},
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Send results to server',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
