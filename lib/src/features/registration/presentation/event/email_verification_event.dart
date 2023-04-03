abstract class EmailVerificationEvent {}

class CheckEmailInUse extends EmailVerificationEvent {}

class ContinueToTheNextRegistrationStep extends EmailVerificationEvent {}

class ReturnToAccess extends EmailVerificationEvent {}
