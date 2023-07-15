  const String apiKey = '42c104c7ce8095343bad605dae6524b3'; // Replace with your actual API key
DateTime parseUnixTimestamp(int unixTimestamp) {
  return DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
}