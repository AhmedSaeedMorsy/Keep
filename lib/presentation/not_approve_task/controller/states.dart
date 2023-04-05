abstract class NotApproveTaskStates {}

class NotApproveTaskInitState extends NotApproveTaskStates {}

class ApproveTaskLoadingstate extends NotApproveTaskStates {}

class ApproveTaskSuccessstate extends NotApproveTaskStates {}

class ApproveTaskErrorstate extends NotApproveTaskStates {}

class RejectTaskLoadingstate extends NotApproveTaskStates {}

class RejectTaskSuccessstate extends NotApproveTaskStates {}

class RejectTaskErrorstate extends NotApproveTaskStates {}
