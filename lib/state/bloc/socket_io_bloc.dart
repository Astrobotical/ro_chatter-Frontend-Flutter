import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
part 'socket_io_event.dart';
part 'socket_io_state.dart';

class SocketIoBloc extends Bloc<SocketIoEvent, SocketIoState> {
  late IO.Socket _socket;

  SocketIoBloc() : super(SocketIoInitial()) {
    _initializeSocket();
    on<Connect>((event, emit) {
      print('A connection has been made');
      emit(SocketIoConnected());
    });
    on<Disconnect>(_onDisconnect);
    on<SendMessage>(_onSendMessage);
    on<ReceiveMessage>(_onReceiveMessage);
    _socket.on('connectionMade', (_) => add(Connect()));
    _socket.on('disconnect', (_) => add(Disconnect()));
    _socket.on('error', (data) => emit(SocketIoError(data.toString())));
    _socket.on('event_name', (data) => add(ReceiveMessage(data)));
    _socket.onConnectError((error) {
      print('Socket connection error: $error');

      /// add(SocketErrorEvent(error.toString()));
    });
  }
  void _initializeSocket() {
    _socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    _socket.onConnect(
      (_) {
        _socket.emit('connectionMade', 'Hello from Flutter');
        add(Connect());
      },
    );
  }

  void _onConnect(Connect event, Emitter<SocketIoState> emit) {
    print('initializing socket');
    _socket.onConnect(
      (_) {
        emit(SocketIoConnected());
        print(_socket.active);
      },
    );
  }

  void _onDisconnect(Disconnect event, Emitter<SocketIoState> emit) {
    _socket.disconnect();
   
    emit(SocketIoDisconnected());
   // emit(SocketTryingtoReconnect());
  }

  void _onSendMessage(SendMessage event, Emitter<SocketIoState> emit) {
    _socket.emit(event.event, event.data);
  }

  void _onReceiveMessage(ReceiveMessage event, Emitter<SocketIoState> emit) {
    emit(SocketIoDataReceived(event.data));
  }

  void sendMessage(String event, dynamic data) {
    _socket.emit(event, data);
  }

  @override
  Future<void> close() {
    _socket.dispose();
    return super.close();
  }
}
