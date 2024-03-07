import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_task/domain/api_client.dart';
import 'package:test_task/domain/box_manager.dart';
import 'package:test_task/domain/data_provider.dart';
import 'package:test_task/domain/entity/data.dart';
import 'package:test_task/ui/navigation/main_navigation.dart';

class HomeScreenModel extends ChangeNotifier {
  final _controllerUrl = TextEditingController();
  String? _errorMassage;
  bool _isSavingData = false;

  String? get errorMassage => _errorMassage;

  get controllerUrl => _controllerUrl;

  bool get isSavingData => _isSavingData;

  void onPressed(BuildContext context) async {
    final url = _controllerUrl.text;
    String? oldErrorMassage = _errorMassage;
    _errorMassage = null;
    _validateAddress(url);
    if (_errorMassage != oldErrorMassage) {
      notifyListeners();
    }
    if (_errorMassage != null) return;

    _isSavingData = true;
    notifyListeners();
    await _saveUrlToStorage();
    final data = await _getDataFromServer();
    await _saveDataToStorage(data);
    _isSavingData = false;
    notifyListeners();
    _goToNextScreen(context);
  }

  void _goToNextScreen(BuildContext context) {
    // debugPrint('navigation to Process screen');
    Navigator.of(context).pushNamed(MainNavigationRouteName.process);
  }

  void _validateAddress(String url) {
    String urlWithoutParameters = 'https://flutter.webspark.dev/flutter/api';
    int size = urlWithoutParameters.length;
    if (url.isEmpty || url == '') {
      _errorMassage = 'Fill field';
      return;
    }
    if (url.length < urlWithoutParameters.length ||
        url.substring(0, size) != urlWithoutParameters) {
      _errorMassage = 'Invalid url address';
      return;
    }

    if (url.length > size && !_isGetParameters(url.substring(size))) {
      _errorMassage = 'Incorrect entered get parameters';
      return;
    }
  }

  final RegExp _isGetParametersRegExp =
      RegExp(r'(\?)(\w+)(\=)(\w+)(((\&)(\w+)(\=)(\w+))*)');

  bool _isGetParameters(String str) => _isGetParametersRegExp.hasMatch(str);

  Future<List<Data>> _getDataFromServer() async {
    // debugPrint('getting Data from server');
    List<Data> list = await ApiClient().getData();
    return list;
  }

  Future<void> _saveUrlToStorage() async {
    // debugPrint('saving url to storage');
    await DataProvider().setUrl(_controllerUrl.text);
    final getUrl = await DataProvider().getUrl();
    // debugPrint(getUrl);
  }

  Future<void> _saveDataToStorage(List<Data> dataList) async {
    Box<Data> box = await BoxManager.instance.openDataBox();
    box.clear();
    for (var data in dataList) {
      await box.put(data.id, data);
    }
    // debugPrint('---------------Save Data To Storage----------------');
    // debugPrint(dataList.toString());
    await BoxManager.instance.closeBox<Data>(box);
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
