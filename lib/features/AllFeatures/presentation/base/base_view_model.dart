abstract class BaseVMInputs {
  void start();
  void dispose();
  Sink get inputState;
}

abstract class BaseVMOutputs {
// later
  // Stream<FlowState> get outputState;
}

abstract class BaseVM extends BaseVMInputs with BaseVMOutputs {}
