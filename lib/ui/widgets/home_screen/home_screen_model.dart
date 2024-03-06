import 'package:flutter/material.dart';
import 'package:test_task/domain/api_client.dart';
import 'package:test_task/domain/data_provider.dart';
import 'package:test_task/domain/entity/data.dart';
import 'package:test_task/ui/navigation/main_navigation.dart';

class HomeScreenModel extends ChangeNotifier {
  final controllerUrl = TextEditingController(text: 'https://flutter.webspark.dev/flutter/api');
  bool isCorrectedUrl = true;
  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  void onPressed(BuildContext context) async {
    final url = controllerUrl.text;
    String? oldErrorMassage = _errorMassage;
    _errorMassage = null;
    _validateAddress(url);
    if (_errorMassage != oldErrorMassage) {
      notifyListeners();
    }
    if (_errorMassage != null) return;

    _saveToStorage();
    final data = _getDataFromServer();
    _goToNextScreen(context, data);
  }

  void _goToNextScreen(BuildContext context, Future<List<Data>> data) {
    debugPrint('navigation to Process screen');
    Navigator.of(context).pushNamed(MainNavigationRouteName.process, arguments: data);
  }

  void _validateAddress(String url) {
    if (url.isEmpty || url == '') {
      _errorMassage = 'Fill field';
    } else if (url != 'https://flutter.webspark.dev/flutter/api') {
      _errorMassage = 'Invalid url address';
    }
  }

  Future<List<Data>> _getDataFromServer() async {
    debugPrint('getting Data from server');
    List<Data> list = await ApiClient().getData();
    return list;
  }

  void _saveToStorage() async {
    debugPrint('saving to storage');
    await DataProvider().setUrl(controllerUrl.text);

    final getUrl = await DataProvider().getUrl();
    debugPrint(getUrl);
  }
}

class NotifierProvider extends InheritedNotifier<HomeScreenModel> {
  final HomeScreenModel model;

  const NotifierProvider({
    super.key,
    required super.child,
    required this.model,
  }) : super(notifier: model);

  static HomeScreenModel? read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<NotifierProvider>()?.model;
  }

  static HomeScreenModel? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NotifierProvider>()
        ?.model;
  }
}
