;@Ahk2Exe-SetName       	VlcNotesHelper.exe
;@Ahk2Exe-SetVersion    	1.0.0 	
;@Ahk2Exe-SetDescription  	VlcNotesHelper.App
;@Ahk2Exe-SetCopyright    	discretecourage#0179
;@Ahk2Exe-SetCompanyName  	discretecourage#0179
;@Ahk2Exe-SetOrigFilename 	VlcNotesHelper.App
;@Ahk2Exe-SetMainIcon     	VlcNotes.ico

#Include, <FileUrl>
#Include, <JsontoAhkfull>
FileCreateDir, %A_MyDocuments%\VlcNotes\
; FileCreateDir, %A_ScriptDir%\
SetWorkingDir, %A_MyDocuments%\VlcNotes\
FileCreateDir, %A_MyDocuments%\VlcNotes\SavedPlaylist\


if 0 != 1 ;Check %0% to see how many parameters were passed in
{
    msgbox ERROR: There are %0% parameters.
}
else
{
    param = %1%  ;Fetch the contents of the command line argument

    param:=StrReplace(param, "VlcNotes://")
    param:=StrReplace(param, "VlcNotes:/")
    param:=StrReplace(param, "VlcNotes:")

    StringToSend:= param
    

    ; IniRead, my_id, %A_Temp%/VlcNotes-3sdfe7-4sv32-461gd2b-8fb2-ef2fc46.temp, Null, id           ;-----> do not delete may come in handy
    ; IniRead, fullpath, %A_Temp%/VlcNotes-3sdfe7-4sv32-461gd2b-8fb2-ef2fc46.temp, Null, fullpath
    ; IniWrite, %param%, %A_Temp%/VlcNotes-3sdfe7-4sv32-461gd2b-8fb2-ef2fc46.temp, Null, messagesend
    ; if !WinExist("ahk_id " . my_id) {
    ; try
    ; Run, %fullpath%
    ; Catch, e
    ; MsgBox 0x30, Application not found, VlcNotes App not found
    ; }

    PlaylistLoad:={}, item:=1
    arrtemp:=""
    Urltemp:= StringToSend
    if InStr(Urltemp, "-~-") {          
    arrtemp:=StrSplit(Urltemp,"-~-"," `t", 3)
    RecievedName:=arrtemp.1
    , RecievedTime:=arrtemp.2
    , RecievedUrl:=arrtemp.3
    }
    Else
    {
    RecievedName:="Unknown"
    , RecievedTime:=0
    , RecievedUrl:=RecievedFilePath
    }
    temparr:={"Name":"dummyName","Url":"dummyurl","timelastleft":"0"}
                , temparr.Name:=RecievedName
                , temparr.Url:=FileURL(RecievedUrl)
                , temparr.timelastleft:= RecievedTime
                , PlaylistLoad[1]:=temparr
               

tempdata:=Ahktojson(PlaylistLoad)
IniWrite, %tempdata%, SavedPlaylist/SingleMediaPlaylist.plvlc, SavedPlaylist, SavedPlaylist
IniWrite, 1, SavedPlaylist/SingleMediaPlaylist.plvlc, SavedPlaylist, lastplayedItem
IniWrite, SingleMediaPlaylist, ResumePlaylist.ini, Recent, RecentPlaylist
}

; ExitApp


sendingmessageattempt:
IniRead, fullpath, %A_Temp%/VlcNotes-3sdfe7-4sv32-461gd2b-8fb2-ef2fc46.temp, Null, fullpath
IniRead, my_id, %A_Temp%/VlcNotes-3sdfe7-4sv32-461gd2b-8fb2-ef2fc46.temp, Null, id
TargetScriptTitle := "VlcNotes ahk_id" . my_id

result := Send_WM_COPYDATA(StringToSend, TargetScriptTitle)
if (result = "FAIL") {
    n++
    if (n=1) {
    try 
    Run, %fullpath%
    Catch, e
    MsgBox 0x30, Application not found, VlcNotes App not found
    }
    Sleep, 100
    if (n<2)
    Goto, sendingmessageattempt
}
else if (result = 0)
{
    MsgBox  VlCNote Coudnt take the action.
}
ExitApp

Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle)  ; ByRef saves a little memory in this case.
; This function sends the specified string to the specified window and returns the reply.
; The reply is 1 if the target window processed the message, or 0 if it ignored it.
{
    VarSetCapacity(CopyDataStruct, 3*A_PtrSize, 0)  ; Set up the structure's memory area.
    ; First set the structure's cbData member to the size of the string, including its zero terminator:
    SizeInBytes := (StrLen(StringToSend) + 1) * (A_IsUnicode ? 2 : 1)
    NumPut(SizeInBytes, CopyDataStruct, A_PtrSize)  ; OS requires that this be done.
    NumPut(&StringToSend, CopyDataStruct, 2*A_PtrSize)  ; Set lpData to point to the string itself.
    Prev_DetectHiddenWindows := A_DetectHiddenWindows
    Prev_TitleMatchMode := A_TitleMatchMode
    DetectHiddenWindows On
    SetTitleMatchMode 2
    TimeOutTime := 4000  ; Optional. Milliseconds to wait for response from receiver.ahk. Default is 5000
    ; Must use SendMessage not PostMessage.
    SendMessage, 0x004A, 0, &CopyDataStruct,, %TargetScriptTitle%,,,, %TimeOutTime% ; 0x004A is WM_COPYDATA.
    DetectHiddenWindows %Prev_DetectHiddenWindows%  ; Restore original setting for the caller.
    SetTitleMatchMode %Prev_TitleMatchMode%         ; Same.
    return ErrorLevel  ; Return SendMessage's reply back to our caller.
}