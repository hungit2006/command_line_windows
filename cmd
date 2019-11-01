Get serial number: wmic/node:do5mkt357 bios get serialnumber

Get list software: wmic/node:do5mkt357 /output:c:\soft.txt product get name,version

Get systeminfo: systeminfo /S 172.26.45.69 /U DO5ACC02\administrator /P "YmVn@ IT" /FO CSV >> c:\test.csv

Rename computer: 
  netdom renamecomputer do5mkt90067.yamaha-motor.com.vn /newname do5mkt90311 /userd:yamaha-motor\yus90196 /passwordd:s90196!
  WMIC /node:“CurrentSystemName” /user:Admin /password:AdminPassword computersystem call rename “NewSystemName”
