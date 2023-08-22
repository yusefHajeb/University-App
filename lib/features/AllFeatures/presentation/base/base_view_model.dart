abstract class BaseVMInputs {
  void start();
  void dispose();
  Sink get inputState;
}

abstract class BaseViewModelInputas {}

abstract class BaseVMOutputs {
  // Stream<FlowState> get outputState;

}

abstract class BaseVM extends BaseVMInputs with BaseVMOutputs {
  final StreamController _inputSC = StreamController<FlowState>.broadcast();
}
