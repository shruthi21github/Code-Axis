# How to restroe db?

## download the dump file

download latest dump of mysql code_axis_db from dumps folder.

## restore using windows terminal

Caution:

1. The dump file has drop existing database sql code, so it will drop the database code_axis_db if you have and this might erase any datau might have inserted into.

```PowerShell
cmd /c "mysql -u root -pYour_root_password < ""dump_filepath"""
```

example:

1. cmd /c "mysql -u root -proot@123 < ""C:\Downloads\code_axis_db_full_backup_dump_20260518_150721.sql"""
