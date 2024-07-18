import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';

import '../../../catalog/domain/entities/category_entity.dart';
import '../../domain/entities/item_entity.dart';

class ItemView {
  final Item item;
  final Category? category;
  final PurchaseOrder? order;
  final Contact? supplier;

  ItemView({required this.item, this.category, this.order, this.supplier});
}
