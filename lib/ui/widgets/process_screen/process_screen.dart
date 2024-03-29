import 'package:flutter/material.dart';
import 'package:test_task/ui/widgets/process_screen/process_screen_model.dart';

class ProcessScreen extends StatelessWidget {
  const ProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ProcessScreenModel();
    model.startProcess();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process screen'),
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
    return const Column(
      children: [
        SizedBox(height: 200),
        _ProgressWidget(),
        Divider(),
        _ProgressSendWidget(),
        Expanded(child: SizedBox()),
        _SendDataWidget(),
      ],
    );
  }
}

class _ProgressWidget extends StatelessWidget {
  const _ProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch(context);
    if (model == null) return const SizedBox.shrink();
    final text = model.textForLoading;
    final progress = model.progress;
    return Column(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        Text(
          '$progress%',
          style: const TextStyle(fontSize: 20),
        )
      ],
    );
  }
}

class _ProgressSendWidget extends StatelessWidget {
  const _ProgressSendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch(context);
    if (model == null) return const SizedBox.shrink();
    final isDataSending = model.isDataSending;

    return isDataSending
        ? const SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          )
        : const SizedBox();
  }
}

class _SendDataWidget extends StatelessWidget {
  const _SendDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch(context);
    if (model == null) return const SizedBox.shrink();
    final isDataSending = model.isDataSending;
    final isCalculating = model.isCalculating;
    if (isDataSending) return const SizedBox();
    return ElevatedButton(
      onPressed: isCalculating ? null : () => model.sendResultToServer(context),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Send results to server',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
