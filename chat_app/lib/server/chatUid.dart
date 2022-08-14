String createChatId(currentUserName, friendName) {
  if (currentUserName.toString().substring(0, 1).codeUnitAt(0) >
      friendName.toString().substring(0, 1).codeUnitAt(0)) {
    return '$currentUserName\_$friendName';
  } else {
    return '$friendName\_$currentUserName';
  }
}
