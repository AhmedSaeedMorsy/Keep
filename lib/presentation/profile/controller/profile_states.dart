abstract class ProfileStates {}

class ProfileInitState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {}

class ProfileErrorState extends ProfileStates {}

class AddContactSuccessState extends ProfileStates {}

class CreateAssignedLeadLoadingState extends ProfileStates {}

class CreateAssignedLeadSuccessState extends ProfileStates {}

class CreateAssignedLeadErrorState extends ProfileStates {}

class ChangeDropDownIconState extends ProfileStates {}

class ChangeDropDownValueState extends ProfileStates {}

class CreateUnAssignedLeadLoadingState extends ProfileStates {}

class CreateUnAssignedLeadSuccessState extends ProfileStates {}

class CreateUnAssignedLeadErrorState extends ProfileStates {}

class GetTaskLoadingState extends ProfileStates {}

class GetTaskSuccessState extends ProfileStates {}

class GetTaskErrorState extends ProfileStates {
  final String message;
  GetTaskErrorState(this.message);
}

class IsAssignedLeadLoadingState extends ProfileStates {}

class IsAssignedLeadSuccessState extends ProfileStates {}

class IsAssignedLeadErrorState extends ProfileStates {}
