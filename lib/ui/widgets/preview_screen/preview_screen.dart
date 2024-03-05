import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview screen'),
      ),
      body: const _BodyWidget(),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width,
          child: const _GridWidget(),
        ),
        const Center(
          child: Text(
            '(0,3) -> (0,2) -> (0,1)',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}

class _GridWidget extends StatelessWidget {
  const _GridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: const [
        _GridTileWidget(x: 0, y: 0),
        _GridTileWidget(x: 1, y: 0),
        _GridTileWidget(x: 2, y: 0),
        _GridTileWidget(x: 3, y: 0),
        _GridTileWidget(x: 0, y: 1),
        _GridTileWidget(x: 1, y: 1),
        _GridTileWidget(x: 2, y: 1),
        _GridTileWidget(x: 3, y: 1),
        _GridTileWidget(x: 0, y: 2),
        _GridTileWidget(x: 1, y: 2),
        _GridTileWidget(x: 2, y: 2),
        _GridTileWidget(x: 3, y: 2),
        _GridTileWidget(x: 0, y: 3),
        _GridTileWidget(x: 1, y: 3),
        _GridTileWidget(x: 2, y: 3),
        _GridTileWidget(x: 3, y: 3),
      ],
    );
  }
}

class _GridTileWidget extends StatelessWidget {
  final int x;
  final int y;

  const _GridTileWidget({
    super.key,
    required this.x,
    required this.y,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: GridTile(
        child: Center(
          child: Text('($x, $y)'),
        ),
      ),
    );
  }
}
