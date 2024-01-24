import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:note_app/ui/widgets/widget.dart';

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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('EchoNotes'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Text(
                'Settings',
                style: theme.textTheme.labelLarge,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: ColumnSettings(),
          )
        ],
      ),
    );
  }
}

class ColumnSettings extends StatefulWidget {
  const ColumnSettings({super.key});

  @override
  State<ColumnSettings> createState() => _ColumnSettingsState();
}

class _ColumnSettingsState extends State<ColumnSettings> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SettingsInfoWidget(),
          SizedBox(
            height: 20,
          ),
          SettingsInfoWidget(),
          SizedBox(
            height: 20,
          ),
          SettingsInfoWidget(),
          SizedBox(
            height: 20,
          ),
          SettingsInfoWidget()
        ],
      ),
    );
  }
}

class SettingsInfoWidget extends StatefulWidget {
  const SettingsInfoWidget({
    super.key,
  });

  @override
  State<SettingsInfoWidget> createState() => _SettingsInfoWidgetState();
}

class _SettingsInfoWidgetState extends State<SettingsInfoWidget> {
  bool switchValue = true;
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
                  value: switchValue,
                  onChanged: (value) {
                    switchValue = value;
                    setState(() {});
                  }),
            )
          ],
        ),
      ),
    );
  }
}
