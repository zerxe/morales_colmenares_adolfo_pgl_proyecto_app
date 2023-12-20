import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/auth_provider.dart';
import 'provider/tab_index_provider.dart';

import 'tabs/tab_0_main.dart';
import 'tabs/tab_1_list_character.dart';
import 'tabs/tab_2_data_character.dart';

class FlutTab extends StatelessWidget {
  const FlutTab({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userEmail = authProvider.getUserEmail() ?? 'Usuario';
    final tabIndexProvider = Provider.of<TabIndexProvider>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(userEmail),
          bottom: TabBar(
            onTap: (index) {
              tabIndexProvider.setTabIndex(index);
            },
            tabs: const [
              Tab(text: 'Principal'),
              Tab(text: 'Fichas'),
              Tab(text: 'Datos Ficha'),
            ],
          ),
        ),
        body: Consumer<TabIndexProvider>(
          builder: (context, provider, child) {
            return IndexedStack(
              index: provider.selectedIndex,
              children: const [
                Page1(),
                Page2(),
                Page3(),
              ],
            );
          },
        ),
      ),
    );
  }
}
