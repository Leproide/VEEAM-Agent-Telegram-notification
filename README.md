# VEEAM Agent Telegram notification with Powershell

Use Telegram as notification service for Veeam Agent by powershell script

You need a bot token and chatid.

In the code you can set the max age of event registry entry for prevent duplicate notification.

Set a new scheduled activity like this:

![immagine](https://github.com/Leproide/VEEAM-Agent-Telegram-notification/assets/8448713/2fdcb158-a613-48a6-a0ea-7c0d15e03272)

And configure in this way:

1. Program: Powershell.exe
2. Argument: Script path (example C:\VeeamNotify.ps1)

![immagine](https://github.com/Leproide/VEEAM-Agent-Telegram-notification/assets/8448713/945c7cde-30f7-4bd2-8104-2199297aca70)

![immagine](https://github.com/Leproide/VEEAM-Agent-Telegram-notification/assets/8448713/c56ea9e7-5894-4b9a-a3c5-188c3ec56780)

Result:

![immagine](https://github.com/Leproide/VEEAM-Agent-Telegram-notification/assets/8448713/3d103a29-6db1-4f50-9809-74c8462bb408)
