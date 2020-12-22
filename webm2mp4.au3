#include <File.au3>

Local $Command_sleep = 5000

;동영상이 위치한 파일 경로 삽입
Local $FilePath = "C:\"

;VLC 실행 파일 경로 삽입
Local $VLCPath = "C:\Program Files\VideoLAN\VLC\vlc.exe"

;파일 리스트 얻기
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

;파일 리스트에서 순차 실행
For $i = 1 To $FL[0]
   Local $FileName = $FL[$i]

   ;파일 변환 및 저장
   ;;VLC 실행
   Local $PID = Run($VLCPath)
   Window_wait("VLC 미디어 재생기")

   ;;파일 변환 창 열기
   Send_key("^r")
   Window_wait("미디어 열기")

   ;;변환 파일 추가 하기
   Send_key("{TAB}", 3)
   Send_key("{ENTER}")
   ControlClick("하나 또는 다중 파일 선택", "취소", "ToolbarWindow323","left",1,15,15)
   Sleep($Command_sleep)
   Send_key($FilePath)
   Send_key("{ENTER}")
   ControlClick("하나 또는 다중 파일 선택", "취소", "Edit1")
   Sleep($Command_sleep)
   ControlSend("하나 또는 다중 파일 선택", "취소", "Edit1", $FileName)
   Sleep($Command_sleep)
   ControlClick("하나 또는 다중 파일 선택", "취소", "Button1")
   Sleep($Command_sleep)
   Send_key("!o", 2)
   Send_key("{ENTER}")

   ;;변환 설정 하기
   Local $MP4_name = StringSplit($FileName, ".")
   Send_key("{TAB}")
   Send_key("{ENTER}")
   ControlSend("파일 저장...", "취소", "Edit1", $MP4_name[1]&".mp4")
   Sleep($Command_sleep)
   ControlClick("파일 저장...", "취소", "Button2")
   Sleep($Command_sleep)
   Send_key("!s")

   ;;변환 대기
   Local $Replaced_FilePath = StringReplace($FilePath, "\", "/")&"/"
   Local $Title_Name = "Converting file:///"&$Replaced_FilePath&$FileName&" - VLC 미디어 재생기"
   ConsoleWrite("start : "&$Title_Name&$i&"/"&$FL[0]&@CRLF)
   WinWaitClose($Title_Name)
   ConsoleWrite("done"&@CRLF)
   Sleep($Command_sleep * 2)

   ;;VLC 닫기
   ProcessClose($PID)
   Sleep($Command_sleep * 2)

Next