part of 'vpn_cubit.dart';

class VpnState extends Equatable {
  final VpnStatus? status;
  final String? stage;
  final bool granted;

  const VpnState({this.status, this.stage, this.granted = false});

  VpnState copyWith({VpnStatus? status, String? stage, bool? granted}) {
    return VpnState(
      status: status ?? this.status,
      stage: stage ?? this.stage,
      granted: granted ?? this.granted,
    );
  }

  @override
  List<Object> get props => [status ?? {}, stage ?? {}, granted];
}
