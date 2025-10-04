import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/add_customer_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomersListScreen extends StatefulWidget {
  const CustomersListScreen({Key? key}) : super(key: key);

  @override
  State<CustomersListScreen> createState() => _CustomersListScreenState();
}

class _CustomersListScreenState extends State<CustomersListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  bool _loading = true;

  List<Map<String, dynamic>> _all = [];
  List<Map<String, dynamic>> _sellers = [];
  List<Map<String, dynamic>> _purchasers = [];
  String _q = '';

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final sellersRes =
          await ApiService.post('/customers/list', {"type": "Seller"});
      final purchasersRes =
          await ApiService.post('/customers/list', {"type": "Purchaser"});

      final sellers =
          List<Map<String, dynamic>>.from(sellersRes.data['items'] ?? []);
      final purchasers =
          List<Map<String, dynamic>>.from(purchasersRes.data['items'] ?? []);
      setState(() {
        _sellers = sellers;
        _purchasers = purchasers;
        _all = [...sellers, ...purchasers];
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load customers\n$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red.shade900,
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _addCustomerFlow() async {
    final type = await _selectCustomerType(context);
    if (type == null) return;
    final saved = await Get.to(() => AddCustomerScreen(customerType: type));
    if (saved != null) _load();
  }

  Future<String?> _selectCustomerType(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('select_customer_type'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: Colors.green),
              title:  Text('seller'.tr),
              onTap: () => Navigator.pop(ctx, 'Seller'),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
              title: Text('purchaser'.tr),
              onTap: () => Navigator.pop(ctx, 'Purchaser'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteCustomer(Map<String, dynamic> c) async {
    final id = c['id'] ?? c['code'];
    if (id == null) return;

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('delete_customer'.tr),
        content: Text('Delete "${c['name'] ?? ''}"? ${'cannot_undo'.tr}'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text('cancel'.tr)),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('delete'.tr, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (ok != true) return;

    try {
      await ApiService.post(
          '/deleteCustomer', {'id': id}); // adjust for your API
      setState(() {
        bool match(Map e) =>
            ((e['id'] ?? e['code']).toString() == id.toString());
        _all.removeWhere(match);
        _sellers.removeWhere(match);
        _purchasers.removeWhere(match);
      });
      Get.snackbar(
        'Deleted',
        'Customer removed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade50,
        colorText: Colors.green.shade900,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete\n$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red.shade900,
      );
    }
  }

  List<Map<String, dynamic>> _filter(List<Map<String, dynamic>> src) {
    final q = _q.trim().toLowerCase();
    if (q.isEmpty) return src;
    return src.where((e) {
      final name = (e['name'] ?? '').toString().toLowerCase();
      final phone = (e['phone'] ?? '').toString().toLowerCase();
      final code = (e['code'] ?? '').toString().toLowerCase();
      return name.contains(q) || phone.contains(q) || code.contains(q);
    }).toList();
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('all_customers'.tr),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _load),
          IconButton(icon: const Icon(Icons.print), onPressed: () {}),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addCustomerFlow,
        icon: const Icon(Icons.add),
        label: Text('add'.tr),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Segmented tabs (scrollable + compact badges)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceVariant, // safer across themes
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TabBar(
                  controller: _tab,
                  isScrollable: true, // ✅ prevents overflow
                  tabAlignment: TabAlignment
                      .start, // ✅ keeps tabs left-aligned when scrolling
                  labelPadding: const EdgeInsets.symmetric(
                    // ✅ tighter spacing
                    horizontal: 30,
                    vertical: 2,
                  ),
                  labelStyle: const TextStyle(
                    // ✅ compact text
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor:
                      Theme.of(context).colorScheme.onSurfaceVariant,
                  tabs: [
                    _TabWithBadge.tab(label: 'all'.tr, count: _all.length),
                    _TabWithBadge.tab(label: 'sellers'.tr, count: _sellers.length),
                    _TabWithBadge.tab(label: 'buyers'.tr, count: _purchasers.length), // ← renamed
                  ],
                ),
              ),
            ),

            // Info line
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'sellers_info'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(color: cs.onSurfaceVariant),
              ),
            ),

            // Search
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: TextField(
                onChanged: (v) => setState(() => _q = v),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'search_hint'.tr,
                  prefixIcon: const Icon(Icons.search),
                  isDense: true, // compact height
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : TabBarView(
                      controller: _tab,
                      children: [
                        _ListTab(
                            data: _filter(_all), onDelete: _deleteCustomer),
                        _ListTab(
                            data: _filter(_sellers), onDelete: _deleteCustomer),
                        _ListTab(
                            data: _filter(_purchasers),
                            onDelete: _deleteCustomer),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact badge tab label
class _TabWithBadge extends StatelessWidget {
  final String label;
  final int count;
  const _TabWithBadge({required this.label, required this.count});

  static Tab tab({required String label, required int count}) =>
      Tab(child: _TabWithBadge(label: label, count: count));

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min, // ✅ keeps it compact
      children: [
        Text(
          label,
          overflow: TextOverflow.fade,
          softWrap: false,
        ),
        const SizedBox(width: 6),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 22),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.center,
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 12,
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Mobile-friendly list with swipe-to-delete and menu
class _ListTab extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final Future<void> Function(Map<String, dynamic> c)? onDelete;

  const _ListTab({Key? key, required this.data, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.contacts_outlined,
                size: 56, color: Colors.grey.shade500),
            const SizedBox(height: 12),
             Text('no_records'.tr,
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text('tap_to_add_customer'.tr,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ]),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 100),
      itemCount: data.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (ctx, i) {
        final c = data[i];
        final code = (c['code'] ?? '').toString();
        final name = (c['name'] ?? '').toString();
        final phone = (c['phone'] ?? '').toString();
        final initial =
            (name.isNotEmpty ? name[0] : (code.isNotEmpty ? code[0] : '?'))
                .toUpperCase();

        return Dismissible(
          key: ValueKey((c['id'] ?? c['code']).toString() + i.toString()),
          direction: onDelete == null
              ? DismissDirection.none
              : DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.delete_outline, color: Colors.red),
          ),
          confirmDismiss: (_) async {
            if (onDelete == null) return false;
            await onDelete!(c);
            // return false so the item doesn't animate out; list updates from parent setState
            return false;
          },
          child: Card(
            elevation: 0.5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              leading: CircleAvatar(
                radius: 20,
                child: Text(initial,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
              title: Text(name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              subtitle: Text(
                (phone != null && phone.toString().trim().isNotEmpty)
                    ? phone   
                    : 'Code: $code',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (v) async {
                  if (v == 'delete' && onDelete != null) await onDelete!(c);
                },
                itemBuilder: (ctx) => [
                  PopupMenuItem(value: 'delete', child: Text('delete'.tr)),
                ],
                icon: const Icon(Icons.more_vert),
              ),
            ),
          ),
        );
      },
    );
  }
}
