import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chat_gpt/models/chat_model.dart';
import 'package:chat_gpt/models/openApiModel_model.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = "https://api.openai.com/v1";
const String _Api_key = "YOUR API KEY";

class ApiServices {
  static Future<List<OpenApiModel>> getModel() async {
    try {
      var response = await http.get(
        Uri.parse("$_BASE_URL/models"),
        headers: {"Authorization": "Bearer $_Api_key"},
      );
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse["error"] != null) {
        throw HttpException(jsonResponse["error"]["message"]);
      }
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
        //log("model: $value");
      }
      return OpenApiModel.modelsFromSnapshot(temp);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  static Future<List<ChatModel>> sendMessage(
      {required String msg, required String modelId}) async {
    try {
      var response = await http.post(Uri.parse("$_BASE_URL/completions"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $_Api_key"
          },
          body:
              jsonEncode({"model": modelId, "prompt": msg, "max_tokens": 100}));

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse["error"] != null) {
        throw HttpException(jsonResponse["error"]["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        //log("Message: ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
            msg: jsonResponse["choices"][index]["text"],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
