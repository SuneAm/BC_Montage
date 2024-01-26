import 'package:flutter/foundation.dart';

import 'case_estimated_hour.dart';
import 'case_type.dart';
import 'economy.dart';
import 'hour_aggregate.dart';
import 'responsible_user.dart';
import 'status.dart';

@immutable
class Case {
  const Case({
    required this.caseNumber,
    required this.projectName,
    required this.economy,
    required this.responsibleUser,
    required this.caseType,
    required this.status,
    required this.estimatedTimer,
    this.estimatedHours,
    this.hourAggregate,
  });

  final int estimatedTimer;
  final String caseNumber;
  final String projectName;
  final Economy economy;
  final ResponsibleUser responsibleUser;
  final CaseType caseType;
  final Status status;

  final HourAggregate? hourAggregate;
  final CaseEstimatedHour? estimatedHours;

  factory Case.fromFirestore(Map<String, dynamic> json) {
    final estimatedHour = json['estimatedHours'];

    return Case(
      estimatedTimer: json['estimatedTimer'] ?? 0,
      caseNumber: json['caseNumber'] ?? '',
      projectName: json['projectName'] ?? '',
      economy: Economy.fromJson(json['economy'] ?? {}),
      responsibleUser: ResponsibleUser.fromJson(json['responsibleUser'] ?? {}),
      caseType: CaseType.fromJson(json['caseType'] ?? {}),
      status: Status.fromJson(json['status'] ?? {}),
      hourAggregate: HourAggregate.fromMap(json['hourAggregate']),
      estimatedHours: estimatedHour == null
          ? null
          : CaseEstimatedHour.fromJson(estimatedHour),
    );
  }
}
