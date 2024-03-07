import 'package:flutter/material.dart';
import 'package:test_task/ui/widgets/result_list_screen/result_list_screen_model.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({super.key});

  Future<void> readData(ResultListScreenModel model) async {
    await model.readWaysFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    final model = ResultListScreenModel();
    readData(model);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result list screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: NotifierProvider(
          model: model,
          child: const _BodyWidget(),
        ),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch(context);
    if (model == null) return const SizedBox();
    if (model.ways.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.separated(
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => model.goToNextScreen(context, index),
        child: _ResultWidget(
          index: index,
        ),
      ),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: model.ways.length,
    );
  }
}

class _ResultWidget extends StatelessWidget {
  final int index;

  const _ResultWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read(context);
    if (model == null) return const SizedBox();
    final path = model.ways[index].result.path;

    return Padding(
      padding: const EdgeInsets.all(14),
      child: Center(
        child: Text(
          path,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
