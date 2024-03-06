import 'package:flutter/material.dart';
import 'package:test_task/domain/api_client.dart';
import 'package:test_task/domain/data_provider.dart';
import 'package:test_task/domain/entity/data.dart';
import 'package:test_task/ui/navigation/main_navigation.dart';

class HomeScreenModel extends ChangeNotifier {
  final controllerUrl = TextEditingController();
  bool isCorrectedUrl = true;
  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  void onPressed(BuildContext context) {
    final url = controllerUrl.text;
    String? oldErrorMassage = _errorMassage;
    _errorMassage = null;
    _validateAddress(url);
    if (_errorMassage != oldErrorMassage) {
      notifyListeners();
    }
    if (_errorMassage != null) return;

    _saveToStorage();
    _getDataFromServer();
    _goToNextScreen(context);
  }

  void _goToNextScreen(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteName.process);
  }

  void _validateAddress(String url) {
    if (url.isEmpty || url == '') {
      _errorMassage = 'Fill field';
    } else if (url != 'https://flutter.webspark.dev/flutter/api') {
      _errorMassage = 'Invalid url address';
    }
  }

  void _getDataFromServer() async {
    List<Data> list = await ApiClient().getData();
    for (var element in list) {
      debugPrint('$element\n');
    }
  }

  void _saveToStorage() async {
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
