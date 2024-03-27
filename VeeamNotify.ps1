#    Veeam Agent Telegram notify script
#    Powershell script by Leprechaun
#
#    https://muninn.ovh
#    leprechaun@muninn.ovh
#    https://github.com/Leproide
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

Function Send-Telegram {
    Param([Parameter(Mandatory=$true)][String]$Message)
    $Telegramtoken = "CHANGE_ME"
    $Telegramchatid = "CHANGE_ME"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $Response = Invoke-RestMethod -Uri "https://api.telegram.org/bot$($Telegramtoken)/sendMessage" -Method POST -Body @{
        chat_id = $Telegramchatid
        text = $Message
        parse_mode = "HTML"  # Specify that the message text is in HTML format
    }
}

    # Custom string
    $CustomString = "CUSTOMER: Example"

# Get the last event with ID 190
$A = Get-WinEvent -MaxEvents 1 -FilterHashTable @{Logname = "Veeam Agent"; ID = 190, 191}
if ($A) {
    $Message = $A.Message
    $EventTime = $A.TimeCreated

    # Format the event date (not time)
    $FormattedEventDate = $EventTime.ToString("dd-MM-yyyy")

    # Check if the event message contains "Success", "Failed", or "Warning"
    if ($Message -match "finished with Success") {
        $CustomString = "&#x1F7E2; " + $CustomString  # Green circle emoji
    } elseif ($Message -match "finished with Failed") {
        $CustomString = "&#x1F534; " + $CustomString  # Red circle emoji
    } elseif ($Message -match "finished with Warning") {
        $CustomString = "&#x1F7E0; " + $CustomString  # Orange circle emoji
    }

    # Check if the event date is equal to the current date (Prevent notifications from the past)
    if ($FormattedEventDate -eq (Get-Date).ToString("dd-MM-yyyy")) {
        $EventTimeString = "Event Time: $($EventTime.ToString("dd-MM-yyyy HH:mm:ss"))"

        # Check if the event is older than 10 minutes (Prevents duplicate notifications, set this value according to your needs)
        $TimeDifference = (Get-Date) - $EventTime
        if ($TimeDifference.TotalMinutes -gt 10) {
            exit
        }

        # Concatenate custom string, event time, and message
        $MessageToSend = "$CustomString`r`n$EventTimeString`r`n$Message"

        # Send the message via Telegram
        Send-Telegram $MessageToSend
    } else {
        exit
    }
} else {
    exit
}
