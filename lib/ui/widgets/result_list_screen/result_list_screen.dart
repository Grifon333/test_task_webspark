import 'package:flutter/material.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result list screen'),
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
    return ListView.separated(
      itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            debugPrint(index.toString());
          },
          child: const _ResultWidget()),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: 20,
    );
  }
}

class _ResultWidget extends StatelessWidget {
  const _ResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(14),
      child: Center(
        child: Text(
          '(0,3) -> (0,2) -> (0,1)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
