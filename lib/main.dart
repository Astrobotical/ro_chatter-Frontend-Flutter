import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ro_chatter/Models/chat_model.dart';
import 'package:ro_chatter/state/bloc/socket_io_bloc.dart';
import 'package:ro_chatter/state/chat_lobby_cubit.dart';
import 'package:ro_chatter/state/internet_state_cubit.dart';
import 'package:ro_chatter/state/notifications_cubit.dart';
import 'package:ro_chatter/widgets/chatListWidget.dart';

void main() {
  Bloc.observer = const AppBlocObserver();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<InternetStateCubit>(
        create: (context) => InternetStateCubit(),
      ),
      BlocProvider<SocketIoBloc>(
        create: (context) => SocketIoBloc(),
      ),
      BlocProvider<ChatLobbyCubit>(create: (context) => ChatLobbyCubit()),
      BlocProvider<NotificationsCubit>(create: (context) => NotificationsCubit()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Ro Chatter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final chatLobby = BlocProvider.of<ChatLobbyCubit>(context);
    final InternetStateCubit internetStateCubit =
        BlocProvider.of<InternetStateCubit>(context);
    internetStateCubit.context = context;
    internetStateCubit.watchingConnection(context);
    final notificationobject = context.read<NotificationsCubit>();
    notificationobject.context = context;
    notificationobject.notificationSocketConnect();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title),
            Gap(10),
            Align(
              alignment: Alignment.topRight,
              child: Stack(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.add_alert))
                ],
              ),
            )
          ],
        ),
      ),
      body: chatLobby.chatLogs.isEmpty
          ? const Center(
              child: Text("No Previous Chats Found",
                  style: TextStyle(fontSize: 20)))
          : SingleChildScrollView(
              child: FutureBuilder<List<ChatModel>>(
                  future: null,
                  builder: (context, snapshot) {
                    return ListView.builder(itemBuilder: (context, index) {
                      return chatListWidget(chatData: snapshot.data![index]);
                    });
                  })
              /*BlocBuilder<SocketIoBloc, SocketIoState>(
          builder: (context, state) {
            if (state is SocketIoInitial) {
              return const Text('Connecting...');
            }
            if (state is SocketIoConnected) {
              return const Text('Connected');
            } else if (state is SocketIoDisconnected) {
              return const Text('Disconnected');
            } else if (state is SocketIoError) {
              return Text('Error: ${state.message}');
            } else if (state is SocketIoDataReceived) {
              return Text('Data: ${state.data}');
            }
            return const Text('Unknown state');
          },
        ),
        */
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<SocketIoBloc>(context)
              .sendMessage('message', 'Hello from Flutter');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
