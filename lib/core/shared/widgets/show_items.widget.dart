// import 'package:app/core/extension/alertdialog.extenstion.dart';
// import 'package:app/core/extension/validator.extension.dart';
// import 'package:app/core/shared/widget/space.widget.dart';
// import 'package:flutter/material.dart';

// class ShowItems extends StatelessWidget {
//   ShowItems({
//     super.key,
//     required List<Widget> items,
//     required String title,
//     required void Function(String) onAdd,
//   })  : _items = items,
//         _title = title,
//         _onAdd = onAdd;

//   final List<Widget> _items;
//   final String _title;
//   final void Function(String) _onAdd;
//   final TextEditingController _controller = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(_title), centerTitle: true),
//       body: _buildBody(_items),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => context.showAlertDialog(
//           title: 'Add $_title',
//           content: Form(
//             key: _formKey,
//             child: TextFormField(
//               controller: _controller,
//               validator: (value) => value.isString,
//               decoration:
//                   const InputDecoration(hintText: 'Enter item name'),
//             ),
//           ),
//           confirmText: 'Add',
//           onConfirm: (back) {
//             if (_formKey.currentState?.validate() == true) {
//               _onAdd(_controller.text);
//               _controller.clear();
//               back();
//             }
//           },
//           cancelText: 'Cancel',
//           onCancel: (back) => back(),
//         ),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   SingleChildScrollView _buildBody(List<Widget> items) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: items
//             .map((item) => Column(children: [height(20) ,item]))
//             .toList(),
//       ),
//     );
//   }
// }
