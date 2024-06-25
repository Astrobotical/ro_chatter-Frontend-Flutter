import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ro_chatter/Models/chat_model.dart';

part 'chat_lobby_state.dart';

class ChatLobbyCubit extends Cubit<ChatLobbyState> {
  ChatLobbyCubit() : super(ChatLobbyInitial());
  List<ChatModel> chatLogs = [];
  Future<List<ChatModel>> getChatLogs() async{
    return chatLogs;
  }
}
