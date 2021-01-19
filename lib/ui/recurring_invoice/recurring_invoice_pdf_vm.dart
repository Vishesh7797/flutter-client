import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_pdf_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class RecurringInvoicePdfScreen extends StatelessWidget {
  const RecurringInvoicePdfScreen({Key key}) : super(key: key);

  static const String route = '/recurring_invoice/pdf';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringInvoicePdfVM>(
      converter: (Store<AppState> store) {
        return RecurringInvoicePdfVM.fromStore(store);
      },
      builder: (context, vm) {
        return InvoicePdfView(
          key: ValueKey('__recurring_invoice_pdf_${vm.invoice.id}__'),
          viewModel: vm,
        );
      },
    );
  }
}

class RecurringInvoicePdfVM extends EntityPdfVM {
  RecurringInvoicePdfVM({
    AppState state,
    InvoiceEntity invoice,
  }) : super(
          state: state,
          invoice: invoice,
        );

  factory RecurringInvoicePdfVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final invoiceId = state.uiState.recurringInvoiceUIState.selectedId;
    final invoice = state.recurringInvoiceState.get(invoiceId);

    return RecurringInvoicePdfVM(
      state: state,
      invoice: invoice,
    );
  }
}