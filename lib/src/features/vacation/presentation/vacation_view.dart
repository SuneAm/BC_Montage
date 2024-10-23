import 'package:flutter/material.dart';
import 'package:ordrestyring_common/ordrestyring_common.dart';
import 'package:ordrestyring_montage/src/features/vacation/presentation/request_vacation_container.dart';

part 'vacation_controller.dart';

class VacationView extends HookConsumerWidget {
  const VacationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProfile = useState<User?>(null);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const TitleLarge(
            'Ferie Registrering',
            color: Colors.white,
            textAlign: TextAlign.center,
            fontSize: 24,
          ),
          const TitleLarge(
            'Ferie koordineres med værkforer og anmodes\n senest 3 uger for afholdelse.',
            color: Colors.white,
            textAlign: TextAlign.center,
            fontSize: 12,
          ),
          const SizedBox(height: 16),
          AppContainer(
            width: 600,
            borderRadius: Constant.setBorderRadius(20),
            betweenTilePadding: const EdgeInsets.symmetric(horizontal: 12),
            color: Theme.of(context).colorScheme.onInverseSurface,
            child: CommonAsyncWidget(
              asyncValue: ref.watch(_getApprovedRequestProvider),
              data: (vacations) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TitleLarge('Anmod om ferie'),
                    const SizedBox(height: 16),
                    Consumer(
                      builder: (_, WidgetRef ref, __) {
                        final users = ref.watch(usersProvider);

                        return DropdownButton<User?>(
                          hint: const Text('Select Profile'),
                          value: selectedProfile.value,
                          isExpanded: true,
                          onChanged: (User? user) =>
                              selectedProfile.value = user,
                          items: users
                              .map(
                                (user) => DropdownMenuItem<User>(
                                  value: user,
                                  child: Text(user.fullName),
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                    if (selectedProfile.value != null)
                      ...() {
                        final user = selectedProfile.value!;
                        final userVacations = vacations
                            .where((e) => e.user.id == user.id)
                            .toList();
                        return [
                          ...userVacations.map(
                            (userVacation) => RequestVacationContainer(
                              key: Key(userVacation.id),
                              vacation: userVacation,
                            ),
                          ),
                          RequestVacationContainer(
                            onCreateVacation: (dateTimeRange) async {
                              final startDate = dateTimeRange.start;
                              final endDate = dateTimeRange.end;

                              final isValid = userVacations.isVacationValid(
                                startDate,
                                endDate,
                              );

                              if (!isValid) {
                                context.showSnackBar(
                                    'Vacation request overlaps with an existing vacation');
                                return;
                              }

                              // saving request now
                              final vacation = Vacation(
                                createdAt: DateTime.now(),
                                user: user,
                                startDate: dateTimeRange.start,
                                endDate: dateTimeRange.end,
                              );

                              await ref
                                  .read(vacationRepoProvider)
                                  .createVacationRequest(vacation);

                              if (context.mounted) {
                                context.showSnackBar(
                                    'Vacation Request Send For ${user.fullName}');
                                selectedProfile.value = null;
                              }
                            },
                          ),
                        ];
                      }()
                    // ...vacations.map((vacation) => )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
