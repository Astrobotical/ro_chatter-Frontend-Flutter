part of 'socket_io_bloc.dart';

abstract class SocketIoState extends Equatable {
  @override
  List<Object> get props => [];
}

class SocketIoInitial extends SocketIoState {}

class SocketIoConnected extends SocketIoState {}

class SocketIoDisconnected extends SocketIoState {}

class SocketIoError extends SocketIoState {
  final String message;

  SocketIoError(this.message);

  @override
  List<Object> get props => [message];
}

class SocketIoDataReceived extends SocketIoState {
  final dynamic data;

  SocketIoDataReceived(this.data);

  @override
  List<Object> get props => [data];
}
class SocketTryingtoReconnect extends SocketIoState {}