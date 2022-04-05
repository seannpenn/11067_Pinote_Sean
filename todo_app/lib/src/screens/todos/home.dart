



//   addTodo(String details) {
//     int index = 0;
//     if (todos.isEmpty) {
//       index = 1;
//     } else {
//       index = todos.last.id + 1;
//     }

//     if (mounted) {
//       setState(() {
//         todos.add(Todo(details: details, id: index));
//       });
//     }
//   }

//   removeTodo(int index) {
//     if (todos.isNotEmpty) {
//       for (int i = 0; i < todos.length; i++) {
//         if (index == todos[i].id) {
//           todos.removeAt(i);
//           setState(() {});
//         }
//       }
//     }
//   }

//   editTodo(String details, int index) {
//     _tc.text = details;
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Edit text"),
//         content: TextFormField(
//           // decoration: const InputDecoration(labelText: "Enter text"),
//           maxLines: 5,
//           controller: _tc,
//           focusNode: _fn,
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               if (mounted) {
//                 if (todos.isNotEmpty) {
//                   for (int i = 0; i < todos.length; i++) {
//                     if (index == todos[i].id) {
//                       setState(() {
//                         todos[i].details = _tc.text;
//                         _tc.text = '';
//                       });
//                     }
//                   }
//                 }
//               }
//               Navigator.of(context).pop();
//               _fn.unfocus();
//             },
//             child: const Text('Edit'),
//           )
//         ],
//       ),
//     );
//   }
// }




