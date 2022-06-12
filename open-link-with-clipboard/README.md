# Start-LinkIdClipboard

Programm open specific link provided in `link.txt`.
Before usage `link.txt` should be updated:

* row 1: link with `##change##` parameter which will be replaced by clipboard data
* row 2: min length of `##change##` value
* row 3: max length of `##change##` value (!do not set more than 10 to avoid XSS)

## Purpose

This app can later be set as a shortcut or link on dekstop - to open specific issue ticket or other link which is widely used by end users
