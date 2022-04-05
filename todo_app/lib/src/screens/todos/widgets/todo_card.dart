import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/src/screens/todos/widgets/input_widget.dart';

import '../todo_model.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final Function()? onErase;
  final Function()? onTap;
  final Function()? onClick;
  final EdgeInsets? margin;
  final ScrollController _sc = ScrollController();

  TodoCard(
      {required this.todo,
      this.onTap,
      this.onClick,
      this.onErase,
      this.margin,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: const SlidableStrechActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        // GestureDetector(
        //   onTap: onTap,
        //   child: Container(
        //     margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
        //     width: 25,
        //     height: 100,
        //     decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(16),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.grey.withOpacity(0.5),
        //             spreadRadius: 2,
        //             blurRadius: 6,
        //             offset: const Offset(0, 3), // changes position of shadow
        //           ),
        //         ]),
        //     child: const Icon(
        //       Icons.check,
        //       color: Colors.blueAccent,
        //       size: 30,
        //     ),
        //   ),
        // ),
        GestureDetector(
          onTap: onClick,
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
            // padding: const EdgeInsets.fromLTRB(0, 0, 5,0),
            width: 20,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: IconButton(
              icon: const Icon(Icons.check),
              color: Colors.blueAccent,
              onPressed: onTap,
            ),
          ),
        ),
        GestureDetector(
          onTap: onClick,
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
            // padding: const EdgeInsets.fromLTRB(0, 0, 5,0),
            width: 20,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.blueAccent,
              onPressed: onClick,
            ),
          ),
        ),
        // Container(
        //   margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
        //   decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(16),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey.withOpacity(0.5),
        //           spreadRadius: 2,
        //           blurRadius: 6,
        //           offset: const Offset(0, 3), // changes position of shadow
        //         ),
        //       ]),
        //   child: IconSlideAction(
        //     caption: 'Edit',
        //     // color: Colors.red,
        //     icon: Icons.edit,
        //     onTap: onClick,
        //     closeOnTap: true,
        //   ),
        // ),
        // Container(
        //   margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
        //   decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: const BorderRadius.only(
        //               topLeft: Radius.circular(16),
        //               topRight: Radius.circular(16),
        //               bottomLeft: Radius.circular(16),
        //               bottomRight: Radius.circular(16)),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.grey.withOpacity(0.5),
        //               spreadRadius: 2,
        //               blurRadius: 6,
        //               offset: const Offset(0, 3), // changes position of shadow
        //             ),
        //           ]),
        //   child: IconSlideAction(
        //     caption: 'Done',
        //     // color: Colors.blue,
        //     icon: Icons.check,
        //     onTap: onTap,
        //     closeOnTap: false,
        //   ),
        // )
      ],
      child: Container(
        margin: margin,
        child: GestureDetector(
          // onTap: onTap,
          // onLongPress: onLongPress,
          child: AspectRatio(
            aspectRatio: 11 / 3,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
              decoration: BoxDecoration(
                  color: todo.done ? Colors.amber[100] : Colors.cyanAccent,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        todo.parsedDate,
                        style: TextStyle(
                            decoration:
                                todo.done ? TextDecoration.lineThrough : null),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.close),
                        iconSize: 20,
                        onPressed: onErase,
                      )
                    ],
                  ),
                  Expanded(
                    child: Scrollbar(
                      controller: _sc,
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                        controller: _sc,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          todo.details,
                          style: TextStyle(
                              decoration: todo.done
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
