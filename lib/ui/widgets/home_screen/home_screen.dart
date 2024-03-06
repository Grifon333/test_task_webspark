import 'package:flutter/material.dart';
import 'package:test_task/ui/widgets/home_screen/home_screen_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = HomeScreenModel();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Home screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: NotifierProvider(model: model, child: const _BodyWidget()),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Set valid API base URL in order to continue',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Row(
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
              child: _FormWidget(),
            )
          ],
        ),
        SizedBox(height: 30),
        _ErrorWidget(),
        Expanded(child: SizedBox()),
        _ButtonWidget(),
      ],
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch(context);
    if (model == null) return const SizedBox.shrink();

    return ElevatedButton(
      onPressed: () => model.onPressed(context),
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
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read(context);
    if (model == null) return const SizedBox.shrink();
    return TextField(
      controller: model.controllerUrl,
    );
  }
}


class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch(context);
    String? errorMassage = model?.errorMassage;
    if (errorMassage == null) return const SizedBox.shrink();

    return Column(
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7),
              topRight: Radius.circular(7),
            ),
            // border: Border(
            //   top: BorderSide(color: Colors.black),
            //   left: BorderSide(color: Colors.black),
            //   right: BorderSide(color: Colors.black),
            // ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  'There was a problem',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(7),
              bottomRight: Radius.circular(7),
            ),
            // border: Border(
            //   bottom: BorderSide(color: Colors.black),
            //   left: BorderSide(color: Colors.black),
            //   right: BorderSide(color: Colors.black),
            // ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  ' - $errorMassage',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
