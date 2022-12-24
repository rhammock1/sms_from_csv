# SMS from CSV

### Description
Use from a Mac to parse a CSV file of phone numbers and send an iMessage to each

### Note
* Make sure to have a newline at the end of the CSV file. Otherwise the last number will not be sent to. At least, until I figure out how to fix that.
* Create a txt file to use as the message. It will be sent to each number in the CSV file.

### Requires
* osascript

### Usage
```
./sms_from_csv.sh --csv example_input.csv --message example_message.txt
```
