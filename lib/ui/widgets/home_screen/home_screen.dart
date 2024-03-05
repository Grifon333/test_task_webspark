import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Home screen'),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Set valid API base URL in order to continue',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Flexible(
              flex: 1,
              child: Icon(
                Icons.compare_arrows,
                color: Colors.grey,
              ),
            ),
            Expanded(child: SizedBox()),
            Flexible(
              flex: 10,
              child: TextField(),
            )
          ],
        ),
        const Expanded(child: SizedBox()),
        ElevatedButton(
          onPressed: () {},
          // style: ButtonStyle(
          //   backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
          //   side: MaterialStateProperty.all(
          //     const BorderSide(color: Colors.blue),
          //   ),
          // ),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Start counting process',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
