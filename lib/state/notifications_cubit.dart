import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());
  late IO.Socket _socket;
  late BuildContext context;
  void notificationSocketConnect() {
      _socket = IO.io('http://localhost:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });
      _socket.onConnect(
            (_) {
              _socket.on('Notification', (onsocket){
                showQuickbar(onsocket);
              });
          //add(Connect());
        },
      );
  }
  void showQuickbar(String message){
    ScaffoldMessenger.of(context)
        .showSnackBar( SnackBar(content: Text('$message'),backgroundColor: Colors.green,));
  }
}
