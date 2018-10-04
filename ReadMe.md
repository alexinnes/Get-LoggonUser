# Getting the Logged on User of a remote station

This script will be able to tell who is logged into a station.
It can be run against remote machine. It filters out some of the system users so that it gives you the correct user.

```powershell
Get-LoggedOnUser -ComputerName Some-Computer
```