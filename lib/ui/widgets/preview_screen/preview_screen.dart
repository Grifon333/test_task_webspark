import 'package:flutter/material.dart';
import 'package:test_task/domain/entity/point.dart';
import 'package:test_task/domain/entity/way.dart';
import 'package:test_task/ui/widgets/preview_screen/preview_screen_model.dart';

class PreviewScreen extends StatelessWidget {
  final Way way;

  const PreviewScreen({
    super.key,
    required this.way,
  });

  @override
  Widget build(BuildContext context) {
    final model = PreviewScreenModel();
    model.way = way;
    model.coloredBox();
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
    final model = NotifierProvider.read(context);
    if (model == null) return const SizedBox();
    final path = model.way.result.path;
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
    final model = NotifierProvider.read(context);
    if (model == null) return const SizedBox();

    return GridView.count(
      // crossAxisCount: model.way.result,
      crossAxisCount: 4,
      children: [
        for (int i = 0; i < 4; i++)
          for (int j = 0; j < 4; j++)
            _GridTileWidget(
              point: Point(j, i),
            ),

        // _GridTileWidget(x: 0, y: 0),
        // _GridTileWidget(x: 1, y: 0),
        // _GridTileWidget(x: 2, y: 0),
        // _GridTileWidget(x: 3, y: 0),
        // _GridTileWidget(x: 0, y: 1),
        // _GridTileWidget(x: 1, y: 1),
        // _GridTileWidget(x: 2, y: 1),
        // _GridTileWidget(x: 3, y: 1),
        // _GridTileWidget(x: 0, y: 2),
        // _GridTileWidget(x: 1, y: 2),
        // _GridTileWidget(x: 2, y: 2),
        // _GridTileWidget(x: 3, y: 2),
        // _GridTileWidget(x: 0, y: 3),
        // _GridTileWidget(x: 1, y: 3),
        // _GridTileWidget(x: 2, y: 3),
        // _GridTileWidget(x: 3, y: 3),
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
    final color = model.map[point];

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: color,
      ),
      child: GridTile(
        child: Center(
          child: Text(point.toString()),
        ),
      ),
    );
  }
}
