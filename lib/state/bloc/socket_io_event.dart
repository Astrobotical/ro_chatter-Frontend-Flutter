part of 'socket_io_bloc.dart';

// socket_io_state.dart



abstract class SocketIoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Connect extends SocketIoEvent {}

class Disconnect extends SocketIoEvent {}

class SendMessage extends SocketIoEvent {
  final String event;
  final dynamic data;

  SendMessage(this.event, this.data);

  @override
  List<Object> get props => [event, data];
}

class ReceiveMessage extends SocketIoEvent {
  final dynamic data;

  ReceiveMessage(this.data);

  @override
  List<Object> get props => [data];
}