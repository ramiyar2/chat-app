import 'package:flutter/material.dart';

import '../../../data/color.dart';

getAligment(uid, {bool? isRow, bool? isColumn, currentUser}) {
  if (isRow == true) {
    if (uid == currentUser) {
      return MainAxisAlignment.end;
    } else {
      return MainAxisAlignment.start;
    }
  }
  if (isColumn == true) {
    if (uid == currentUser) {
      return CrossAxisAlignment.end;
    } else {
      return CrossAxisAlignment.start;
    }
  }
}

getBorderRadios(uid, currentUser) {
  if (uid == currentUser) {
    return const BorderRadius.only(
      topLeft: Radius.circular(14),
      topRight: Radius.circular(0),
      bottomLeft: Radius.circular(14),
      bottomRight: Radius.circular(14),
    );
  } else {
    return const BorderRadius.only(
      topLeft: Radius.circular(0),
      topRight: Radius.circular(14),
      bottomLeft: const Radius.circular(14),
      bottomRight: const Radius.circular(14),
    );
  }
}

getColor(uid, {bool? isBorder, bool? isBg, bool? isText, currentUser}) {
  if (isBorder == true) {
    if (uid == currentUser) {
      return dark_green;
    } else {
      return dark_blue;
    }
  }
  if (isBg == true) {
    if (uid == currentUser) {
      return dark_blue;
    } else {
      return dark_green;
    }
  }
  if (isText == true) {
    if (uid == currentUser) {
      return green_op;
    } else {
      return dark_blue;
    }
  }
}

getMargin(uid, currentUser) {
  if (uid == currentUser) {
    return const EdgeInsets.only(
      top: 10,
      right: 10,
      left: 0,
    );
  } else {
    return const EdgeInsets.only(
      top: 10,
      right: 0,
      left: 10,
    );
  }
}
