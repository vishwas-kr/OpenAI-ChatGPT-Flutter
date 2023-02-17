import 'package:flutter/cupertino.dart';

import '../models/chat_model.dart';
import '../services/api_services.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getchatList => chatList;

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> botMessage(
      {required String msg, required String modelID}) async {
    chatList.addAll(await ApiServices.sendMessage(
      msg: msg,
      modelId: modelID,
    ));
    notifyListeners();
  }
}
