import 'package:flutter/material.dart';
import 'package:test_task/domain/entity/point.dart';
import 'package:test_task/ui/widgets/preview_screen/preview_screen_model.dart';

class PreviewScreen extends StatelessWidget {
  final String idWay;

  const PreviewScreen({
    super.key,
    required this.idWay,
  });

  Future<void> initModel(PreviewScreenModel model) async {
    await model.getDataAndWayFromStorage(idWay);
    model.coloredBox();
  }

  @override
  Widget build(BuildContext context) {
    final model = PreviewScreenModel();
    initModel(model);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview screen'),
      ),
      body: NotifierProvider(
        model: model,
        child: const _BodyWidget(),
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
        SizedBox(
          height: MediaQuery.of(context).size.width,
          child: const _GridWidget(),
        ),
        const Center(
          child: _PathWidget(),
        ),
      ],
    );
  }
}

class _PathWidget extends StatelessWidget {
  const _PathWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch(context);
    if (model == null) return const SizedBox();
    if (model.way == null) return const SizedBox();
    final path = model.way!.result.path;
    return Text(
      path,
      style: const TextStyle(fontSize: 20),
    );
  }
}

class _GridWidget extends StatelessWidget {
  const _GridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch(context);
    if (model == null) return const SizedBox();
    final size = model.size;

    return GridView.count(
      crossAxisCount: size,
      children: [
        for (int i = 0; i < size; i++)
          for (int j = 0; j < size; j++)
            _GridTileWidget(
              point: Point(j, i),
            ),
      ],
    );
  }
}

class _GridTileWidget extends StatelessWidget {
  final Point point;

  const _GridTileWidget({
    super.key,
    required this.point,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read(context);
    if (model == null) return const SizedBox();
    final backgroundColor = model.map[Point(point.y, point.x)];

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: backgroundColor,
      ),
      child: GridTile(
        child: Center(
          child: Text(
            point.toString(),
            style: TextStyle(
                color: backgroundColor == Colors.black
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
    );
  }
}
