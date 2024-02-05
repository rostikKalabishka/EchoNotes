import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/futures/account_settings/bloc/account_settings_bloc.dart';
import 'package:note_app/core/ui/widgets/widget.dart';

@RoutePage()
class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AccountSettingsBloc, AccountSettingsState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('EchoNotes'),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  child: Text(
                    'Settings',
                    style: theme.textTheme.labelLarge,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ColumnSettings(
                  state: state,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ColumnSettings extends StatelessWidget {
  const ColumnSettings({super.key, required this.state});
  final AccountSettingsState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SettingsInfoWidget(
            state: state,
          ),
        ],
      ),
    );
  }
}

class SettingsInfoWidget extends StatefulWidget {
  const SettingsInfoWidget({
    super.key,
    required this.state,
  });
  final AccountSettingsState state;
  @override
  State<SettingsInfoWidget> createState() => _SettingsInfoWidgetState();
}

class _SettingsInfoWidgetState extends State<SettingsInfoWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomBoxShadowContainer(
      cardColor: theme.cardColor,
      cardInfo: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dark Mode',
              style: theme.textTheme.labelMedium,
            ),
            Transform.scale(
              scale: 0.8,
              child: Switch.adaptive(
                  value: widget.state.switchBoolTheme,
                  onChanged: (value) {
                    value
                        ? context
                            .read<AccountSettingsBloc>()
                            .add(SwitchThemeOnEvent())
                        : context
                            .read<AccountSettingsBloc>()
                            .add(SwitchThemeOffEvent());
                  }),
            )
          ],
        ),
      ),
    );
  }
}
