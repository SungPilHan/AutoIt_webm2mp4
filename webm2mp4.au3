#include <File.au3>

Local $Command_sleep = 5000

;�������� ��ġ�� ���� ��� ����
Local $FilePath = "C:\"

;VLC ���� ���� ��� ����
Local $VLCPath = "C:\Program Files\VideoLAN\VLC\vlc.exe"

;���� ����Ʈ ���
Local $FL = _FileListToArray($FilePath)

Func Window_wait($hWnd)
   WinWait($hWnd)
   Sleep(1000)
EndFunc

Func Send_key($key, $num=1)
   For $i = 1 To $num
	  Send($key)
	  Sleep(1000)
   Next
EndFunc

;���� ����Ʈ���� ���� ����
For $i = 1 To $FL[0]
   Local $FileName = $FL[$i]

   ;���� ��ȯ �� ����
   ;;VLC ����
   Local $PID = Run($VLCPath)
   Window_wait("VLC �̵�� �����")

   ;;���� ��ȯ â ����
   Send_key("^r")
   Window_wait("�̵�� ����")

   ;;��ȯ ���� �߰� �ϱ�
   Send_key("{TAB}", 3)
   Send_key("{ENTER}")
   ControlClick("�ϳ� �Ǵ� ���� ���� ����", "���", "ToolbarWindow323","left",1,15,15)
   Sleep($Command_sleep)
   Send_key($FilePath)
   Send_key("{ENTER}")
   ControlClick("�ϳ� �Ǵ� ���� ���� ����", "���", "Edit1")
   Sleep($Command_sleep)
   ControlSend("�ϳ� �Ǵ� ���� ���� ����", "���", "Edit1", $FileName)
   Sleep($Command_sleep)
   ControlClick("�ϳ� �Ǵ� ���� ���� ����", "���", "Button1")
   Sleep($Command_sleep)
   Send_key("!o", 2)
   Send_key("{ENTER}")

   ;;��ȯ ���� �ϱ�
   Local $MP4_name = StringSplit($FileName, ".")
   Send_key("{TAB}")
   Send_key("{ENTER}")
   ControlSend("���� ����...", "���", "Edit1", $MP4_name[1]&".mp4")
   Sleep($Command_sleep)
   ControlClick("���� ����...", "���", "Button2")
   Sleep($Command_sleep)
   Send_key("!s")

   ;;��ȯ ���
   Local $Replaced_FilePath = StringReplace($FilePath, "\", "/")&"/"
   Local $Title_Name = "Converting file:///"&$Replaced_FilePath&$FileName&" - VLC �̵�� �����"
   ConsoleWrite("start : "&$Title_Name&$i&"/"&$FL[0]&@CRLF)
   WinWaitClose($Title_Name)
   ConsoleWrite("done"&@CRLF)
   Sleep($Command_sleep * 2)

   ;;VLC �ݱ�
   ProcessClose($PID)
   Sleep($Command_sleep * 2)

Next