import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class SocketSubscription {
  final String topic;
  final Function(StompFrame frame) callback;
  void Function({Map<String, String>? unsubscribeHeaders})? unSubscribe;

  SocketSubscription({required this.topic, required this.callback});
}

class SocketService {
  final String url;
  late final StompClient stompClient;
  List<SocketSubscription> subscriptions = [];

  // Private constructor
  SocketService._({required this.url}) {
    stompClient = StompClient(
      config: StompConfig(
        url: url,
        onConnect: _onConnect,
        beforeConnect: () async {
          debugPrint('Waiting to connect...');
          await Future.delayed(const Duration(milliseconds: 200));
          debugPrint('Connecting...');
        },
        onWebSocketError: _onWebSocketError,
        onStompError: _onStompError,
      ),
    );
  }

  void _onStompError(StompFrame frame) => debugPrint(frame.body);

  // Singleton instance variable
  static SocketService? _instance;

  // Factory method to get the Singleton instance
  static SocketService instance({required String url}) {
    _instance ??= SocketService._(url: url);
    return _instance!;
  }

  init() => stompClient.activate();

  addSubscription(SocketSubscription subscription) {
    subscriptions.add(subscription);
    subscribe();
  }

  removeSubscription(SocketSubscription subscription) =>
      subscriptions.remove(subscription);

  subscribe() async {
    int retries = 1;
    while (!stompClient.connected && retries < 5) {
      debugPrint("Waiting for connection to subscribe...");
      await Future.delayed(Duration(milliseconds: (500 * retries)));
      retries++;
    }

    if (!stompClient.connected) {
      debugPrint("STOMP client was not connected");
      return;
    }

    for (var subscription in subscriptions) {
      debugPrint("Subscribing to topic ${subscription.topic}...");
      var unsubscribeCallback = stompClient.subscribe(
          destination: subscription.topic, callback: subscription.callback);
      subscription.unSubscribe = unsubscribeCallback;
    }
  }

  _onConnect(StompFrame frame) {
    debugPrint("Connected to STOMP $url");
  }

  _onWebSocketError(dynamic error) {
    if (error is String) {
      debugPrint(error);
    }
  }
}
