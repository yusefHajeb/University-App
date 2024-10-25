import 'package:socket_io_client/socket_io_client.dart';

abstract class NetworkInfoSocket {
  Future<bool> get conected;
}

class SocketInfoImpl implements NetworkInfoSocket {
  final Socket socket;

  SocketInfoImpl({required this.socket});
  @override
  // TODO: implement conected
  Future<bool> get conected async {
    return socket.connected;
  }
}
