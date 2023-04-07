;@Ahk2Exe-SetName       	VlcNotes.exe
;@Ahk2Exe-SetVersion    	0.2.2.0 	
;@Ahk2Exe-SetDescription  	VlcNotes.App
;@Ahk2Exe-SetCopyright    	discretecourage#0179
;@Ahk2Exe-SetCompanyName  	discretecourage#0179
;@Ahk2Exe-SetOrigFilename 	VlcNotes.App
;@Ahk2Exe-SetMainIcon     	VlcNotes.ico

;=============== CURRENT VERSION ==================================

Current_version:="v0.2.2.0"  ; In github always create new release tag with same name

;==================================================================

Changelog =  
(
[ v0.2.2.0 ] ====================================================

- added support for youtube shortlinks
- added support for most of the yt-dlp supported websits
- read more here https://github.com/yt-dlp/yt-dlp/blob/master/supportedsites.md
- added credits for nickstokes

==================================================================
) 

#include, <Vis2>
; #Include, <JSON.Loadfull>
#Include, <Fileurl>
#Include, <ShinsOverlayClass>
#Include, <SettingsGUI1>
#Include, <SortListByName>
#Include, <AppFactory>
#include, <Gdip_All>
#include, <ImagePut>
#Include, <ImageButton>


; #include, <cJSON>
; #include, <DownloadFile>
; #Include, <DragnDrop> 
; ListHotkeys
; MsgBox, %1%




#SingleInstance, Force
#NoEnv
#MaxThreadsBuffer on
#WarnContinuableException Off 
SetTitleMatchMode, 2
SetBatchLines -1
CoordMode,Pixel,Screen
CoordMode,Mouse,Screen
CoordMode, Tooltip, screen
#MaxHotkeysPerInterval 99999999
#HotkeyInterval 99999999
#KeyHistory 0
ListLines Off
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, 0
SendMode Input

Global default_directory_screenshots_var
Global HotkeyNames:=["Window_Hide_Show"
,"Pause_Playback"
,"Forward"
,"Backward"
,"Speed_Increase"
,"Speed_Decrease"
,"Volume_Increase"
,"Volume_Decrease"
,"Overlay_Brightness_Increase"
,"Overlay_Brightness_Decrease"
,"Play_From_Start"
,"Play_Next"
,"Play_Previous"
,"Borderless_window_Toggle"
,"Change_aspect_ratio"
,"Window_Size_Increase"
,"Window_Size_Decrease"
,"Insert_Time_Stamp"
,"Insert_Time_Stamp_text"
,"Insert_Time_Stamp_link"
,"Insert_Screenshot"
,"Insert_Screenshot_pasted_image"
,"Insert_Screenshot_wiki_link"
,"Insert_Screenshot_md_link"
,"Insert_Link"
,"Insert_Title"
,"Hold_Down_For_Drag_and_Drop_UI"
,"Open_Files"
,"Open_Playlist"
; ,"Hold_Down_For_Mouse_Gesture"
,"Marquee_or_Overlay"
,"Temprory_Marquee_Size_Increase"
,"Temprory_Marquee_Size_Decrease"
,"Optical_Character_RecognitionOCR"
,"Exit"]

; Global UserVaraibles:= ["test1"
; , "test2"    
; , "test3"]

global DarkModeStyle :=[ [3, 0xFF565656, 0xFF000000 , 0xFFA1A1A1, 5, 0xFF000000 , 0xFF000000, 1]
					  , [2,  0xFF1C1C1C, 0xFF1C1C1C , 0xFFA1A1A1, 5, 0xFF000000 , 0x80E6E6E6, -1]
                      , [2, 0xFF1C1C1C, 0xFF1C1C1C , 0xFFA1A1A1, 5, 0xFF000000 , 0xFF000000, 1]
                      , [3, 0xFF000000, 0xFF3D3D3D , 0xffA1A1A1, 8, 0xFF000000 , 0xFF000000, 3] ]

Global UserVariables := {"n" : { "Seektime":10
                                ,"Head_start_media":8
                                ,"VolumeChangeStep":5
                                ,"default_screen_shot_width":500
                                ,"vlc_Marquee_text_size":40 } 

                        ,"t" : {"Time_Stamp_prefix":""
                                ,"Time_Stamp_suffix":""
                                ,"title_prefix":""
                                ,"title_suffix":""
                                ,"link_prefix":""
                                ,"link_suffix":""
                                ,"insertSymbol":""}

                        ,"b" : {"Ignore_Taskbar":0
                                ,"insert_directlink_also":1
                                ,"If_Fullscreen_Enable_Default_Vlc_Hotkeys":0
                                ,"Hide_TaskBar_icon":0} }




Global Credits := "Credits : `n Vlc media player `n evilC - AppFactory  `n just me - Imagebutton  `n iseahound - ImagePut `niseahound - OCR`n Geek - cJSON`nnickstokes `nShinesOverlay `ncyruz `n unknown"

; FileGetVersion, Version, %A_ScriptName%
; MsgBox, % "Version --" Version

Global PinnedFolders:=[]
Global PinnedFolders_1,PinnedFolders_2,PinnedFolders_3

Menu,Tray, NoStandard
Menu, Tray, Add,  Settings, SettingShow
Menu, Tray, Add,  Restart, Reloadlbl
Menu, Tray, Add,  close, Terminatelbl


; OnMessage(0x84, "WM_NCHITTEST")
; OnMessage(0x83, "WM_NCCALCSIZE")

overlay := new ShinsOverlayClass(0,0,A_screenWidth,A_ScreenHeight)
OnMessage(0x004A, "Receive_WM_COPYDATA")  ; 0x004A is WM_COPYDA

; msgbox,%0%  
; msgbox,%1% ;----> launch variables 




;(@-2)===========================================================================================================================================



; Readandsend =
; (
; #Persistent
; #NoTrayIcon
; AhkExe := AhkExported()
; Loop,
; {
;     ; Sleep, 20
;     ; t:=AhkExe.AhkGetVar.to2ndthread
;     ; AhkExe.AhkGetArr.myactualpostransfer
;     ; WinGetPos, X, Y, Width, Height, VlcNotes Ahk_id %my_id%
;     ; tooltip,`% t " -" my_id " -" X " -" Y " -" Width " -" Height " -" myactualpostransfer.1

; IniRead, RecievedFilePath, %A_Temp%/VlcNotes-3sdfe7-4sv32-461gd2b-8fb2-ef2fc46.temp, Null, messagesend, 0
; sleep, 50
; if (RecievedFilePath!=0)  {
; IniWrite, 0, %A_Temp%/VlcNotes-3sdfe7-4sv32-461gd2b-8fb2-ef2fc46.temp, Null, messagesend
; AhkExe.ahkFunction["RecieverFunction",RecievedFilePath]
; }
; }


; AhkExported(){
;   static init,functions
;   If !init{
;     init:=Object(),functions:="ahkFunction:s==sssssssssss|ahkPostFunction:s==sssssssssss|ahkassign:ui==ss|ahkExecuteLine:t==tuiui|ahkFindFunc:t==s|ahkFindLabel:t==s|ahkgetvar:s==sui|ahkLabel:ui==sui|ahkPause:i==s"
;     If (DllCall((exe:=!A_AhkPath?A_ScriptFullPath:A_AhkPath) "\ahkgetvar","Str","A_AhkPath","UInt",0,"CDecl Str"))
;       functions.="|addFile:t==si|addScript:t==si|ahkExec:ui==s"
;     Loop,Parse,functions,|
; 		{v:=StrSplit(A_LoopField,":"),init[v.1]:=DynaCall(exe "\" v.1,v.2)
; 		If (v.1="ahkFunction")
; 			init["_" v.1]:=DynaCall(exe "\" v.1,"s==stttttttttt")
; 		else if (v.1="ahkPostFunction")
; 			init["_" v.1]:=DynaCall(exe "\" v.1,"i==stttttttttt")
; 		}
;   }
;   return init
; }
; )
; dll:=AhkThread(Readandsend)

;============================================================================================================================================

;(@-3)===========================================================================================================================================

Updatechecker=
(
; #Persistent
#NoTrayIcon
; #include <cJSON>
AhkExe := AhkExported()  ; ahkExe.AhkGetVar.variable

repoOwner := "ananthuthilakan"
repoName := "VlcNotes"

try
{
url := "https://api.github.com/repos/" repoOwner "/" repoName "/releases/latest"
WinHttpReq := ComObjCreate("WinHttp.WinHttpRequest.5.1")
WinHttpReq.Open("GET", url)
WinHttpReq.Send()
data:=JsonToAHK(WinHttpReq.ResponseText)

Current_version:=ahkExe.AhkGetVar.Current_version

latest_version := StrSplit(data["html_url"],"/")[8]

}



if (Current_version!=latest_version) && (latest_version)
    {
MsgBox 0x40044, New Update Available, Your current version   : `%Current_version`% ``nNew version available   : `%latest_version`%``n``nDo you want to update ?

IfMsgBox Yes, {
    Try 
    Run, https://ananthuthilakan.com/vlcnotes-app-the-ultimate-video-player-to-take-notes-with-timestamps-and-screenshots/

} Else IfMsgBox No, {

}
    }
ExitApp

AhkExported(){
  static init,functions
  If !init{
    init:=Object(),functions:="ahkFunction:s==sssssssssss|ahkPostFunction:s==sssssssssss|ahkassign:ui==ss|ahkExecuteLine:t==tuiui|ahkFindFunc:t==s|ahkFindLabel:t==s|ahkgetvar:s==sui|ahkLabel:ui==sui|ahkPause:i==s"
    If (DllCall((exe:=!A_AhkPath?A_ScriptFullPath:A_AhkPath) "\ahkgetvar","Str","A_AhkPath","UInt",0,"CDecl Str"))
      functions.="|addFile:t==si|addScript:t==si|ahkExec:ui==s"
    Loop,Parse,functions,|
		{v:=StrSplit(A_LoopField,":"),init[v.1]:=DynaCall(exe "\" v.1,v.2)
		If (v.1="ahkFunction")
			init["_" v.1]:=DynaCall(exe "\" v.1,"s==stttttttttt")
		else if (v.1="ahkPostFunction")
			init["_" v.1]:=DynaCall(exe "\" v.1,"i==stttttttttt")
		}
  }
  return init
}


JsonToAHK(json, rec := false) {
    static doc := ComObjCreate("htmlfile")
          , __ := doc.write("<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">")
          , JS := doc.parentWindow
    if !rec
       obj := `%A_ThisFunc`%(JS.eval("(" . json . ")"), true)
    else if !IsObject(json)
       obj := json
    else if JS.Object.prototype.toString.call(json) == "[object Array]" {
       obj := []
       Loop `% json.length
          obj.Push( `%A_ThisFunc`%(json[A_Index - 1], true) )
    }
    else {
       obj := {}
       keys := JS.Object.keys(json)
       Loop `% keys.length {
          k := keys[A_Index - 1]
          obj[k] := `%A_ThisFunc`%(json[k], true)
       }
    }
    Return obj
 }
;  return

)

dll:=AhkThread(Updatechecker)

;============================================================================================================================================

FileCreateDir, %A_MyDocuments%\VlcNotes\
SetWorkingDir, %A_MyDocuments%\VlcNotes\ ; Working directory set here will be used while opening the  vlcNotes app via URL Protocol
                                         ; If its a different directory than provided in original vlcNotes app
                                         ; playlist , resume, last played time and userconfigurations will be loaded/Saved from (to) Here
                                         ; for URL protocols only , usual file opening from file explorer playlist , resume etc will be saved
                                         ; and laoded from directory given in vlcNotes app
                                         ; ----> this can have great implication how you want app to behave when using URL protocol and when NOT


settingfile:=RegExReplace(A_ScriptName, ".ahk|.exe", ".ini")                                         
FileInstall, VlcNotes.ini, %settingfile%, 0
; FileInstall, PrefixSuffix.ini, PrefixSuffix.ini, 0
; FileInstall, yt-dlp.exe, yt-dlp.exe, 0 ; https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe
; FileInstall, yt-dlp.exe, yt-dlp.exe, 0 ; https://github.com/ananthuthilakan/QuickSearcher/releases/latest/download/QuickSearcher.exe

FileInstall, dropbackground.svg, %A_ScriptDir%\dropbackground.svg, 0 
mybackground := A_ScriptDir . "\dropbackground.svg" ; C:\Files\Files\Files.gif ;location of gif you want to show
FileCreateDir, %A_MyDocuments%\VlcNotes\SavedPlaylist
FileCreateDir, %A_ScriptDir%\assets

FileInstall, assets\skbfklsfkionu_1.png , %A_ScriptDir%\assets\skbfklsfkionu_1.png , 1
FileInstall, assets\skbfklsfkionu_2.png , %A_ScriptDir%\assets\skbfklsfkionu_2.png , 1
FileInstall, assets\skbfklsfkionu_3.png , %A_ScriptDir%\assets\skbfklsfkionu_3.png , 1
FileInstall, assets\skbfklsfkionu_4.png , %A_ScriptDir%\assets\skbfklsfkionu_4.png , 1
FileInstall, assets\skbfklsfkionu_5.png , %A_ScriptDir%\assets\skbfklsfkionu_5.png , 1
FileInstall, assets\skbfklsfkionu_6.png , %A_ScriptDir%\assets\skbfklsfkionu_6.png , 1
FileInstall, assets\skbfklsfkionu_7.png , %A_ScriptDir%\assets\skbfklsfkionu_7.png , 1
FileInstall, assets\skbfklsfkionu_8.png , %A_ScriptDir%\assets\skbfklsfkionu_8.png , 1
FileInstall, assets\skbfklsfkionu_9.png , %A_ScriptDir%\assets\skbfklsfkionu_9.png , 1
FileInstall, assets\skbfklsfkionu_10.png , %A_ScriptDir%\assets\skbfklsfkionu_10.png , 1


;[File Installs]{===================================================================================================================================================

FileInstall, Overlay.png, %A_MyDocuments%\VlcNotes\Overlay.png, 0

;}==================================================================================================================================================================
global vlc
global my_id
Global RecievedFilePath

;[Variables related to screenshots]{==============================================================================================================================
; UserVariables.n["default_screen_shot_width"] := 500 ; (  resizing will be done )
; default_directory_screenshots:= "E:\Obsidian\MyDream\zAssets" ; give your obsidian vaults assets directory to make use best out of this with wikilink
how_to_insert_image_into_notes:= 1  ; [ default value ] this can take values 1 or 2 or 3 ; i recommend 2
                                    ; 1 - Directly paste image into notes as pastedimage and delete itself.
                                    ; 2 - move screenshot to default_directory_screenshots (*require)
                                    ; and insert wiki link into notes with alt text as vedio file name 
                                    ; and timestamp of video when its taken (use my simple image caption css to see it)
                                    ; supports >>>
                                    ;          > assigning a UserVariables.n["default_screen_shot_width"]
                                    ;          > inserting timestamp of video as alt text 
                                    ; 3 - move screenshot to default_directory_screenshots (*require)
                                    ; and insert as markdown link 
                                    ; supports >>>
                                    ;          > assigning a UserVariables.n["default_screen_shot_width"] 
                                    ;          > time stamp will be added at alt text of markdown
                                    ;          

/*<<<<<<<<<simple custom css to see image caption for obsidian >>>>>>>>>>>>>>>>>>  
                                
.image-embed::After {
content: attr(alt);
padding: 0 1rem 1rem 5rem;
display: block;
text-align: justify;
font-size: 0.9125rem;
}

*/ ;<<<<<<<<<simple custom css to see image caption >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  



;}================================================================================================================================================================



;[user Configurations variables]{==================================================================================================================================
; Be Carefull while editing , this can break things

; UserVariables.t["Time_Stamp_prefix"]:=""   ; "## "
; UserVariables.t["Time_Stamp_suffix"]:=" "   ; " `n---`n" 
; UserVariables.t["title_prefix"]:=""        ; "## " 
; UserVariables.t["title_suffix"]:=""        ; " `n---`n" 
; UserVariables.t["link_prefix"]:=""         ; "## " 
; UserVariables.t["link_suffix"]:=""         ; " `n---`n" 
; UserVariables.t["insertSymbol"]:=" ▶"



;{<<<<<<<<<<<<<<<< Boolean ( 1 or 0 )>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; UserVariables.b["Ignore_Taskbar"]:=0
 inlinetime:=0  ; 1 = > allow for multiple timestamps in 
                 ; a single line of your note and jump to it with hotkey (1 = slow as it based on OCR)
                 ; Can recognise from non seletable text ( this is an overkill and mostly not needed )
                 ; 0 = > is faster but allows for only one time stamp in one line of your  Note
                 ; even if you write multiple timestamps, quick seek will go to the 1st one by ignoring others
                 ; Cant recognise from non seletable text.
, linkedTime:=0   ; ( inlinetime boolean will be ignored if this is ON )time will be inserted as md links , click on it will directly take you video at that time

;}<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

; UserVariables.n["Seektime"]:= 10000  ; milliseconds
;  UserVariables.b["insert_directlink_also"] := 1

 widthMin:=120
; , UserVariables.n["Head_start_media"]*1000 := 8000 ; (ms) all media will start to play from this time
; , UserVariables.n["VolumeChangeStep"]:=5 
, SizeResizeStep:=30
, Aspect_ratio:=["16:9","16:10","4:3","5:4"] ; default is 16:9 , change it with hotstring "//ar" , this will switch among them
; , Default_Aspect_ratio_Choose:=2
, Default_media_Directory:="D:\" ; This directory  will open if recent file is not from local folders 
, PinnedFolders:=[A_MyDocuments,A_Desktop,A_MyDocuments] ; while open file these folder will be pinned at left bottom of file explorer, you can add more
; , BRoffsetX:= BRoffsetY:= BLoffsetX:= BLoffsetY:= TLoffsetX:= TLoffsetY:= TRoffsetX:= TRoffsetY := MRoffsetX:= MRoffsetY:= 0 ; i dont think these are needed lol -:)

;}=================================================================================================================================================================

;[Allowed Extensions]{=============================================================================================================================================

allowedextensions := "mp4,mkv,flv,mpg,vob,m4a,avi,webm,mp3,wav,aac,flac,aif,ogg"
, videoextensions := "mp4,mkv,flv,mpg,vob,m4a,avi,webm"
, audioextensions := "mp3,wav,aac,flac,aif,ogg"
, imageextensions := "jpg,bmp,png"

;}=================================================================================================================================================================

;[]{===============================================================================================================================================================

n_overlayposX:=""
n_overlayposY:=""
n_overlaywidth:=""
n_overlayheight:=""
n_overlaytextsize:=""

;}=================================================================================================================================================================

;[variables not to be touched]{====================================================================================================================================
 PlaylistLoad:={}
, Width:=480
, item:=1
, WidthFix:=14
, heightFix:=8
, heightMin:=(widthMin*9)//16
, UserConfigurationSave:= { "Gui":{"LastPlayedPosition":[0,0,480,270],"Marqueetoggle":0,"Titlebartoggle":0,"DarkOverlaytoggle":1,"DarkOverlayOpacity":0,"arnumber":""} }
, firsttimeflag:=1

;}=================================================================================================================================================================



;[ UserConfiguration Read ]{========================================================================================================================================
IniRead, tempvar, UserConfigurationSave, UserConfigurationSave, UserConfigurationSave
Try {
UserConfigurationSave:=JSON.Load(tempvar)
} 
Catch, e
{
Gui +OwnDialogs
MsgBox 0x30, Configurtion Not Found, User Configuration not found.`nLoading Default Configuration.
}
sX:=(UserConfigurationSave.Gui.LastPlayedPosition.1) ? UserConfigurationSave.Gui.LastPlayedPosition.1 : 0
, sY:=(UserConfigurationSave.Gui.LastPlayedPosition.2) ? UserConfigurationSave.Gui.LastPlayedPosition.2 : 0
, Width:=(UserConfigurationSave.Gui.LastPlayedPosition.3) ? UserConfigurationSave.Gui.LastPlayedPosition.3 : Width
, Height:=(UserConfigurationSave.Gui.LastPlayedPosition.4) ? UserConfigurationSave.Gui.LastPlayedPosition.4 : Height
, Marqueetoggle:=  (UserConfigurationSave.Gui.Marqueetoggle) ? UserConfigurationSave.Gui.Marqueetoggle : 0
, Titlebartoggle:=  (UserConfigurationSave.Gui.Titlebartoggle) ? UserConfigurationSave.Gui.Titlebartoggle : 0
, DarkOverlaytoggle:= (UserConfigurationSave.Gui.DarkOverlaytoggle) ? UserConfigurationSave.Gui.DarkOverlaytoggle : 0
, DarkOverlayOpacity:= (UserConfigurationSave.Gui.DarkOverlayOpacity) ? UserConfigurationSave.Gui.DarkOverlayOpacity : 0
, arnumber:= (UserConfigurationSave.Gui.arnumber) ? UserConfigurationSave.Gui.arnumber : 1
, how_to_insert_image_into_notes:= (UserConfigurationSave.Gui.how_to_insert_image_into_notes) ? UserConfigurationSave.Gui.how_to_insert_image_into_notes : how_to_insert_image_into_notes

;  msgox,% (StrSplit(chosenAspectRatio,":", , 2))[1]
 choosenAspectRatioArr:=StrSplit(Aspect_ratio[arnumber],":", , 2)

; msgbox, % UserConfigurationSave.Gui.Marqueetoggle
;}===================================================================================================================================================================



SettingsGUI(HotkeyNames,"SettingsGUI",1,1,1,1,Changelog) ; hotkeynames [array], gui name (string), hotstrings (boolean) , vertical scroll (boolean) , User Varaiables tab (boolean), User Booleans Tab (Boolean)
Gui,SettingsGUI: Tab, 1
; Gui,SettingsGUI: Margin , 75
Gui,SettingsGUI: Add, Button, xm y85 w300 h36 +Center +0x200  BackgroundTrans gSelectScreenShotSavelbl, screenshot save location 📂
SettingsGUI_factory.AddControl("default_directory_screenshots", "Edit", "x+2 yp+3 w552 h30  vdefault_directory_screenshots_var",,Func("default_directory_screenshots_fn").Bind("default_directory_screenshots"))


; SettingsGUI_factory.AddControl("default_directory_screenshots", "Edit", "x+2 yp+3 w552 h30  vdefault_directory_screenshots_var",,Func("default_directory_screenshots_fn").Bind("default_directory_screenshots"))
; Gui,SettingsGUI: Add, Button, xm y+5 w300 h36 +Center +0x200  BackgroundTrans gOpenPrefixSuffixlbl, Open Prefix Suffix Config file
; Gui,SettingsGUI: Add, Button, x+2 yp w100 h36 +Center +0x200  BackgroundTrans gLoadPrefixSuffixlbl, Load
; Gui,SettingsGUI: Add, Progress, x+2 yp+3 w450 h30 BackgroundBABABA
; Gui,SettingsGUI: Add, text, xp yp+1 w450 h30 +Center +0x200  BackgroundTrans, Be very Carefull While editing Config file






Gui,SettingsGUI: Add, Button, xm y+5 w250 h36 +Center +0x200  BackgroundTrans gManuallyUpdateYtdlp, How to Manually update yt-dlp
Gui,SettingsGUI: Add, Button, x+2 yp w150 h36 +Center +0x200  BackgroundTrans gUpdateYtdlp, auto Update yt-dlp
Gui,SettingsGUI: Add, Progress, x+2 yp+3 w450 h30 BackgroundD4800D
Gui,SettingsGUI: Add, text, xp yp+1 w450 h30 +Center +0x200  BackgroundTrans, Use Yt-Dlp at your own risk `, I dont guarentee anything
; Gui,SettingsGUI: Add, Progress, xm y+5 w250 h30 BackgroundBABABA
Gui,SettingsGUI: Add, text, xm y+5 w250 h30 +Center +border +0x200 BackgroundTrans, Pinned Folders
loop, 3 {
SettingsGUI_factory.AddControl("PNfldr_"A_Index, "Edit", "x+2 yp w160 h30  vPinnedFolders_"A_Index,,Func("pinnedfolder_fn").Bind("PNfldr_"A_Index))
Gui,SettingsGUI: Add, Button, x+1 yp w40 h30 +Center +0x200  BackgroundTrans glblPinnedFolder_%A_Index%, 📂
}

; Gui,SettingsGUI: Add, Progress, xm y+20 w852 h32 BackgroundBABABA
; Gui,SettingsGUI: Add, Text, xm yp w468 h32  +Center +0x200 +Border BackgroundTrans, User Variables
; Gui,SettingsGUI: Add, Text, x+2 yp w380 h32 +Center +0x200 +Border BackgroundTrans, Input Box
; Gui,SettingsGUI: Add, Text, xm y+1 w468 h32 +0x200  +Border  +Center, % " this is test "

DragnDrop()



;[Gui] {===========================================================================================================================================================
; sX:=sY:=0, width:=480
; Gui, Color,c000000,c000000
; Gui, +AlwaysOnTop  +Resize MinSize%widthMin%x%heightMin%  -DPIScale  -caption ; +Border
; Gui, Add, ActiveX,  vvlc , Videolan.VLCPlugin.2
; GuiControl, MoveDraw, vlc, % "x0" "y0" "w"Width "h" (Width*choosenAspectRatioArr.2)//choosenAspectRatioArr.1
; try
; Gui, show, % "x" sX "y" sY "w" Width "h" ((Width*choosenAspectRatioArr.2)//choosenAspectRatioArr.1) , VlcNotes
; Catch,e   ; lol just to be sure
; Gui, show, % "x0 y0 w480 h270" , VlcNotes




Gui, Color,c191919,c191919

Gui, +AlwaysOnTop  +Resize MinSize%widthMin%x%heightMin%  -DPIScale  -caption ; +Border ;+toolwindow ; +Border
; if (UserVariables.b["Hide_TaskBar_icon"])
; Gui, +toolwindow
Gui, Margin , 0 , 0
Gui,Font, c858585
FontScaling := Round(96/A_ScreenDPI*10) + 5
FontLarge := FontScaling + 2

Gui, Font, s%FontScaling%  q5, Arial
Gui, Add, Picture,x0 y0 w20 h20 vPicture1 glbl_th_fr_cfe, %A_ScriptDir%\assets\skbfklsfkionu_1.png
Gui, Add,text,% "x30 y0 w0" "h20   BackgroundTrans vtext_title", title of video
GuiControl, MoveDraw, text_title, % "w"width-50 "h20"
Gui,Add,Button,% "x0 y0  w20 h20  Hidden" , x ; hidden button to remove focus
Gui,Add,Button,% "x0 y0  w20 h20 HwnddBTN0 vdbtn0_1 glbl_Exit" , x
ImageButton.Create(dBTN0, DarkModeStyle*)
GuiControl, MoveDraw, dbtn0_1, % "x"Width-20 "y"-1

; Gui,Add,Button,% "x0 y0  w20 h20 HwnddBTN0 vdbtn0_2" , 0
; ImageButton.Create(dBTN0, DarkModeStyle*)
; GuiControl, MoveDraw, dbtn0_2, % "x"Width-40



Gui, Add, ActiveX,  vvlc , Videolan.VLCPlugin.2
GuiControl, MoveDraw, vlc, % "x0" "y22" "w"Width "h" (Width*choosenAspectRatioArr.2)//choosenAspectRatioArr.1
Gui, Add, ActiveX,  vwb Hidden, Shell.Explorer
GuiControl, MoveDraw, wb, % "x0" "y22" "w"Width "h" (Width*choosenAspectRatioArr.2)//choosenAspectRatioArr.1
; wb.Navigate(mybackground)
wb.Navigate("about:blank")
vHtml = <meta http-equiv="X-UA-Compatible" content="IE=9">
vHtml .= "<html>`n<title>name</title>`n<body>`n<center>`n<img src=""" MyBackground """ >`n</center>`n</body>`n</html>"
wb.Navigate(mybackground)

; wb.document.write(vHtml)
; wb.Refresh()

try
Gui, show, % "x" sX "y" sY "w" Width "h" ((Width*choosenAspectRatioArr.2)//choosenAspectRatioArr.1)+20, VlcNotes
Catch,e   ; lol just to be sure
Gui, show, % "x0 y0 w480 h270" , VlcNotes
ComObjConnect(wb, "IE_")








;}=================================================================================================================================================================


WinGet, my_id, ID, A
activeMon := GetMonitorIndexFromWindow(my_id)
SysGet, MonitorWorkArea, MonitorWorkArea, %activeMon%
SysGet, Monitor, Monitor, %activeMon%
WinGetPos , X, Y, Width, Height, ahk_id %my_id%
Anchortoedge(UserVariables.b["Ignore_Taskbar"])
; tooltip,% myactualpostransfer.1
; msgbox, % my_id
; msgbox, % A_ScriptHwnd

n_overlayposX:= (n_overlayposX) ? n_overlayposX : MonitorWorkAreaRight/3
n_overlayposY:= (n_overlayposY) ? n_overlayposY : MonitorWorkAreaBottom-30
n_overlaywidth:= (n_overlaywidth) ? n_overlaywidth : MonitorWorkAreaRight/3
n_overlayheight:= (n_overlayheight) ? n_overlayheight : 30
n_overlaytextsize:= (n_overlaytextsize) ? n_overlaytextsize : 18
prev_overlayposX:= n_overlayposX, prev_overlayposY:= n_overlayposY, prev_overlaywidth:= n_overlaywidth, prev_overlayheight:= n_overlayheight, prev_overlaytextsize:= n_overlaytextsize


IniWrite, %my_id%, %A_Temp%/VlcNotes-3sdfe7-4sv32-461gd2b-8fb2-ef2fc46.temp, Null, id
IniWrite, %A_ScriptFullPath%, %A_Temp%/VlcNotes-3sdfe7-4sv32-461gd2b-8fb2-ef2fc46.temp, Null, fullpath

OnMessage( 0x200, "WM_MOUSEMOVE" )
OnMessage(WM_SIZING := 0x0214, "GuiSizing")

; Playlstload = ( array ) playlist thats just getting loaded
; PlaylistNameNowPlaying = (simple variable ) Name of the playlist now playing or just getting loaded
; item = (Simple variable) which song or media of the playlist is playing now

if 0 != 1 ;Check %0% to see how many parameters were passed in
    {
        ; msgbox ERROR: There are %0% parameters.
    }
    else
    {
        param = %1%  ;Fetch the contents of the command line argument
        ; msgbox, % param
        SplitPath, param, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
        if (OutExtension="plvlc") {
        IniWrite, %OutNameNoExt%, ResumePlaylist.ini, Recent, RecentPlaylist
        }
        Else if OutExtension in %allowedextensions%
            {
            ;   msgbox, % "is allowed OutExtension " OutExtension
             
              temparr:={"Name":"dummyName","Url":"dummyurl","timelastleft":"0"}
              , temparr.Name:=OutNameNoExt
              , temparr.Url:=param
              , temparr.timelastleft:= UserVariables.n["Head_start_media"]*1000
              , PlaylistLoad[1]:=temparr
              , temparr:=""
              tempvar:=JSON.Dump(PlaylistLoad)
              IniWrite, %tempvar%, SavedPlaylist/SingleMediaPlaylist.plvlc, SavedPlaylist, SavedPlaylist
              IniWrite, SingleMediaPlaylist, ResumePlaylist.ini, Recent, RecentPlaylist
              tempvar:=""
            }
    }





IniRead, PlaylistNameNowPlaying, ResumePlaylist.ini, Recent, RecentPlaylist,0
IniRead, lastplayedItem, SavedPlaylist/%PlaylistNameNowPlaying%.plvlc, SavedPlaylist, lastplayedItem,1
Goto, playlistloadinglbl
return

; msgbox, this is one
playlistloadinglbl:
if (PlaylistNameNowPlaying) {
IniRead, PlaylistLoad, SavedPlaylist/%PlaylistNameNowPlaying%.plvlc, SavedPlaylist, SavedPlaylist
if (PlaylistLoad) {
        try {
        PlaylistLoad:=JSON.Load(PlaylistLoad)
        item:=lastplayedItem
        RecentFolder:= (RegExMatch(PlaylistLoad[1].url, "i)^[a-z]\:")) ? PlaylistLoad[1].url : Default_media_Directory
        Goto, lbl_play_with_vlc
        }
        Catch,e
        {
           PlaylistLoad:={}
            ; msgbox, here
        }

    }
}
Else 
{
    Goto, lbl_Open_Files
}
return
; if loaded from above directly go to play else go to lbl_Open_Files


lbl_Open_Files: ; direct open
OutputDebug,% "`n" A_ThisLabel " | "
{

    
    Result := ChooseFile( [0, "Create playlist or ChooseFile..."]
                        , RecentFolder
                        , {Videos: "*.avi;*.mp4;*.mkv;*.wmp;*.m4a;*.webm;*.mpg", Music: "*.mp3,*.wav,*.aac,*.flac,*.aif,*.ogg",Images: "*.jpg;*.png;*.bmp", All: "`n*.*",    text: "*.txt", Markdown: "*md"}
                        , PinnedFolders
                        , 0x10000000 | 0x02000000 | 0x00000200 | 0x00001000 )
; OpenfilesofDropedfolder: ; droped file open
    If (Result != FALSE) {
        PlaylistLoad:={}, item:=1 ; reseting the itemflag and  playlistloaded with file open
        For Each, file in Result ; each and file are key value pairs ; basically  get key and value of an object with for loop
        {
        SplitPath, File, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
            if OutExtension in %allowedextensions%
            {
                n++
                temparr:={"Name":"dummyName","Url":"dummyurl","timelastleft":"0"}
                , temparr.Name:=OutNameNoExt
                , temparr.Url:=File
                , PlaylistLoad[n]:=temparr
                , temparr:=""

            }
            Else if (OutExtension:="plvlc")
                {
                    n:=0
                    Gosub, lbl_Open_Playlist
                    
                    return
                }
        }
        n:=0
        Goto, lbl_Saveplaylist
    }
   
}
Return





lbl_SavePlaylist:
{
    if (PlaylistLoad.MaxIndex()>1)
    {
    PlaylistSaveName := cInputBox("Save Current Playlist", "Do you want to save the `n Selected files into a playlist","MyPlaylist" ,1,0)
            if (PlaylistSaveName) {
                
            tempvar:=JSON.Dump(PlaylistLoad)
            IniWrite, %tempvar%, SavedPlaylist/%PlaylistSaveName%.plvlc, SavedPlaylist, SavedPlaylist
            PlaylistNameNowPlaying:=PlaylistSaveName
            item:=1
            tempvar:=""
                NotSaved:=0
            } else {
                Notsaved:=1
            }

    }
    Goto, lbl_play_with_vlc
}
return


lbl_play_with_vlc:
{
; if (inturrupt=1) ; ----> fixed the issue no longer needed
; return
PlaylistNowPlaying:=PlaylistLoad
filepath_original:=PlaylistNowPlaying[item].url
filename_original:=PlaylistNowPlaying[item].Name
filename_original:=StrReplace(filename_original, "%20"," " )
; fileAppend,%filepath_original%`n,test.log
; msgbox,%filepath_original%`
if (RegExMatch(filepath_original, "i)^[a-z]\:"))
{
    if FileExist(filepath_original)  ;------> ; Decide to add restrictions for extensions, its already there for opening files
        {
       
        filepath_Modified := StrReplace(filepath_original, "\", "/")
        filepath_Modified :="file:///" . filepath_Modified
        filepath_to_insert:=filepath_Modified
        }
    Else
        {
        Gui +OwnDialogs
        MsgBox 0x10, Not Found, %filename_original% `nCan't be located
        }
} 
Else if (RegExMatch(filepath_original, "i)^http")) {
     ; https://youtu.be/DRJ92IVhRlk
    {
;    MsgBox, % filepath_original
if (RegExMatch(filepath_original, "i)youtube.com")) || (RegExMatch(filepath_original, "i)youtu.be"))
    Command= yt-dlp -e --get-title -g --get-url --format b  %filepath_original% 
Else
    Command= yt-dlp -e --get-title -g --get-url --no-warnings  %filepath_original% 

    tempvar :=""
    ; SetWorkingDir, %A_ScriptDir%
    tempvar := StdOutToVar(comspec .  " /c " . Command)
    if (RegExMatch(tempvar, "'yt-dlp' is not recognized as an internal or external command")) || (RegExMatch(tempvar, "Unable to extract uploader id")) {
        Gui +OwnDialogs
        MsgBox 0x30, yt-dlp need to updated, Yt-dlp need to be updated !`nOpen settings and  Click ON update yt-dlp.`n`nyt-dlp should be used at your own risk`,`nI dont guarentee anything with regards to yt-dlp !
        gui, Hide
        gui,SettingsGUI: Show
        ; return
    }
        
    ; SetWorkingDir, %A_MyDocuments%\VlcNotes\
    youtube_linkarr:=strsplit(tempvar,"`n")
    filename_original:= youtube_linkarr.1
    filepath_Modified:= youtube_linkarr.2
    filepath_to_insert:=filepath_original
    }
    ; Else{

    ;     filepath_to_insert:=filepath_original
    ;     filepath_Modified:=filepath_original  ; if any url is not opening check for the
    ;                                   ; curresponding luac file and put it in in playlist folder (instruction for outside of ahk )
    ; }

}
Else{
    MsgBox 0x10, Not Supported or no file selected, Not suported at the moment or  no file selected  ; ---------> need to be looked later what need to be done here 
                                                            ; add new feature like allow to load jsons or xml files                                                            ; Reload
  Return
} 
try {
; msgbox, % filepath_Modified
vlc.playlist.stop()
vlc.playlist.items.clear()
vlc.playlist.add(filepath_Modified,"","""""")
vlc.playlist.next()
SetTimer, TimerMain , 1200
    }
    Catch,e
    {
    Gui +OwnDialogs
    MsgBox 0x10, VLC Error, VLC Error : %e%
    }

vlc.input.time:=(PlaylistNowPlaying[item].timelastleft<UserVariables.n["Head_start_media"]*1000) ? UserVariables.n["Head_start_media"]*1000 : PlaylistNowPlaying[item].timelastleft
if (firsttimeflag=1) {   ; everything that need to be checked for firstime loading will go here
; msgbox, here
Gosub, lbl_Marquee_or_Overlay
Gosub, lbl_Borderless_window_Toggle
Gosub, ShowHideDarkOverlay
}
firsttimeflag:=0 ,  inturrupt:=1
; loop,40 
; {
    
WinSet, AlwaysOnTop, Off, ahk_id %my_id%
if (overlay.BeginDraw()) {  
    activeMon := GetMonitorIndexFromWindow(my_id)
    SysGet, MonitorWorkArea, MonitorWorkArea, %activeMon%
    SysGet, Monitor, Monitor, %activeMon%
    WinGetPos , X, Y, Width, Height, ahk_id %my_id%
	text:=" " filename_original ; " `n`n " filepath_modified
    ; overlay.FillRoundedRectangle(MonitorWorkAreaRight//2-250, MonitorWorkAreaBottom//2-150, 500, 300,15.15,0xAA000000,1)
    ; overlay.DrawText(text,MonitorWorkAreaRight//2-250, MonitorWorkAreaBottom//2-25,size:=40,color:=0xFF949ea8,fontName:="Arial","aCenter dsFF000000 dsx1 dsy1 w500"  "h30")


     overlay.FillRoundedRectangle(X, Y, Width, Height,1,1,0xAA000000,1)
    overlay.DrawText(text,X, Y+Height/2.3,size:=40,color:=0xFF949ea8,fontName:="Arial","aCenter dsFF000000 dsx1 dsy1 w" Width  "h" Height )
    overlay.EndDraw()
    
}
; sleep, 5000
gosub, picture_pulsing_timer
; }
}
return

TimerMain:
; OutputDebug, % "vlc.video.fullscreen --" vlc.video.fullscreen
; If (!WinExist("ahk_class VLC ActiveX Fullscreen Class"))
If (vlc.video.fullscreen=0)
WinSet, AlwaysOnTop, On, ahk_id %my_id%
Else 
WinSet, AlwaysOnTop, Off, ahk_id %my_id%
msec:=vlc.input.time
, totaltimemsec:=vlc.input.length
, runningtimehhmmss:=mstohhmmss(msec)
, totaltimehhmmss:=mstohhmmss(totaltimemsec)
, vlc.video.marquee.text:= " " mstohhmmss(msec) " / " totaltimehhmmss " - " vlc.input.state " 🔊" . vlc.audio.volume 
, test_title:= " " mstohhmmss(msec) " / " totaltimehhmmss "    ⏩ " Round(vlc.input.rate, 1) "    🔊 "  vlc.audio.volume "   "  ; "" SubStr(filename_original, 1 , 60) "..."
to2ndthread:= " " mstohhmmss(msec) " / " totaltimehhmmss " -[ " vlc.input.state " ]"
GuiControl,,text_title,% test_title
; if (msec>(totaltimemsec-3000))5
if (vlc.input.state=3) {
tempAutosaveiteration++
PlaylistNowPlaying[item].timelastleft:=msec
if (tempAutosaveiteration>20){
    Gosub, autosave
    tempAutosaveiteration:=0
}
}
SetTimer, TimerMain , 990
Gosub, overlaydraw
return
; if (msec=totaltimesec) || (vlc.input.state=6) ; current video finished , what to do now
; {
; ; PlaylistNowPlaying[item].timelastleft:=totaltimemsec-10000
;   item++
;   Goto, lbl_play_with_vlc ; play next
; }


; WinSet, AlwaysOnTop, On, ahk_id %my_id%
; WinSet, AlwaysOnTop, Off, ahk_id %my_id%


autosave:
if (PlaylistLoad.MaxIndex()=1) {
PlaylistNameNowPlaying:="SingleMediaPlaylist"
item:=1
}
tempvar:=JSON.Dump(PlaylistNowPlaying)
IniWrite, %tempvar%, SavedPlaylist/%PlaylistNameNowPlaying%.plvlc, SavedPlaylist, SavedPlaylist
tempvar:=""
IniWrite, %Item%, SavedPlaylist/%PlaylistNameNowPlaying%.plvlc, SavedPlaylist, lastplayedItem
if (PlaylistNameNowPlaying)
IniWrite, %PlaylistNameNowPlaying%, ResumePlaylist.ini, Recent, RecentPlaylist
WinGetPos , tempX, tempY, tempW, tempH, ahk_id %my_id%
tempPosition:= [ tempX, tempY, tempW-WidthFix, tempH-HeightFix]
UserConfigurationSave.Gui.LastplayedPosition:=tempPosition
, UserConfigurationSave.Gui.Marqueetoggle:=!Marqueetoggle
, UserConfigurationSave.Gui.Titlebartoggle:=!Titlebartoggle
, UserConfigurationSave.Gui.DarkOverlaytoggle:=!DarkOverlaytoggle
, UserConfigurationSave.Gui.DarkOverlayOpacity:=DarkOverlayOpacity
, UserConfigurationSave.Gui.arnumber:=arnumber
, UserConfigurationSave.Gui.how_to_insert_image_into_notes:=how_to_insert_image_into_notes
tempvar:=JSON.Dump(UserConfigurationSave)
IniWrite, %tempvar%, UserConfigurationSave, UserConfigurationSave, UserConfigurationSave
return



overlaydraw:
if (marqueetoggle) {
overlay.BeginDraw()
overlay.EndDraw()
}
if (overlay.BeginDraw()) && (!marqueetoggle) {  
    ; activeMon := GetMonitorIndexFromWindow(my_id)
    ; SysGet, MonitorWorkArea, MonitorWorkArea, %activeMon%
    ; SysGet, Monitor, Monitor, %activeMon%
    ; WinGetPos , X, Y, Width, Height, ahk_id %my_id% NewStr := SubStr(filename_original, 1 , 50)

	text:=" " mstohhmmss(msec) " / " totaltimehhmmss "   " newline " ⏩ " Round(vlc.input.rate, 1) "   " newline " 🔊 "  vlc.audio.volume "   " newline "" SubStr(filename_original, 1 , 55) "..."
    overlay.FillRoundedRectangle(n_overlayposX, n_overlayposY, n_overlaywidth, n_overlayheight,15,15,0xAA000000,1)
 
    overlay.DrawText(text,n_overlayposX,n_overlayposY+5,size:=n_overlaytextsize,color:=0xFF949ea8,fontName:="Arial","aCenter dsFF000000 dsx1 dsy1 w" n_overlaywidth "h" n_overlayheight)
    overlay.EndDraw()
}

return






lbl_Play_From_Start:
vlc.input.time:=UserVariables.n["Head_start_media"]*1000
return

; :://tt::
; ^k::
lbl_Marquee_or_Overlay:
marqueetoggle:=!marqueetoggle
if (marqueetoggle) {
overlay.BeginDraw()
overlay.EndDraw()
vlc.video.marquee.enable()
; msec:=vlc.input.time
; totaltimemsec:=vlc.input.length
vlc.video.marquee.text:= " " mstohhmmss(msec) " / " totaltimehhmmss
vlc.video.marquee.color:=0x949ea8
vlc.video.marquee.opacity:=255
vlc.video.marquee.position:="bottom-left"
vlc.video.marquee.refresh:=1
vlc.video.marquee.size:= UserVariables.n["vlc_Marquee_text_size"]
}
Else
{
vlc.video.marquee.disable()
Gosub, overlaydraw
}
return

lbl_Temprory_Marquee_Size_Increase:
vlc.video.marquee.size+=5
return

lbl_Temprory_Marquee_Size_Decrease:
vlc.video.marquee.size-=5
return


lbl_Borderless_window_Toggle:
Titlebartoggle:=!Titlebartoggle
if (Titlebartoggle)
Gui, +Resize ; +Caption
else
Gui, -Resize ; -Caption
return






GuiSize:
	If (A_EventInfo = 1) ; The window has been minimized.
		Return
	 AutoXYWH("wh", "vlc")
	 AutoXYWH("wh", "wb")
	 AutoXYWH("x", "dbtn0_1")
	;  AutoXYWH("w", "progress_w")
   
	;  AutoXYWH("xw", "text_title")
    Width:=A_GuiWidth 
    ; GuiControl, MoveDraw, progress_w, % "w"width-20 "h20"
    Gui, show, % "NoActivate w"Width "h" ((Width*choosenAspectRatioArr.2)//choosenAspectRatioArr.1)+20
    Anchortoedge(UserVariables.b["Ignore_Taskbar"])
return

uiMove:
PostMessage, 0xA1, 2,,, A
Return






lbl_Change_aspect_ratio:
arnumber:= (arnumber=Aspect_ratio.MaxIndex()) ? 1 : arnumber+1
choosenAspectRatioArr:=StrSplit(Aspect_ratio[arnumber],":", , 2)
; arnumber:= ((arnumber=Aspect_ratio.MaxIndex()) ? 1 : arnumber+1)
; chosenAspectRatio:=Aspect_ratio[arnumber]
; choosenAspectRatioArr:=""
; choosenAspectRatioArr:=StrSplit(chosenAspectRatio,":", , 2)
Gui, show, % "NoActivate x" sX "y" sY "w" Width "h" ((Width*choosenAspectRatioArr.2)//choosenAspectRatioArr.1)+20 , VlcNotes
return


lbl_Play_Previous:
if (item>1) {
item--
Gosub, lbl_play_with_vlc
}
Else{
    vlc.playlist.stop()
vlc.playlist.items.clear()
}
return


lbl_Play_Next:
if (item<PlaylistNowPlaying.MaxIndex()) {
item++
Gosub, lbl_play_with_vlc
}
Else
{
vlc.playlist.stop()
vlc.playlist.items.clear()
}
return










GuiClose:
lbl_Exit:
OutputDebug,% "`n" A_ThisLabel " | "
SetTimer, TimerMain , off
vlc.playlist.stop()
if (PlaylistLoad.MaxIndex()=1) {
PlaylistNameNowPlaying:="SingleMediaPlaylist"
item:=1
}
tempvar:=JSON.Dump(PlaylistNowPlaying)
IniWrite, %tempvar%, SavedPlaylist/%PlaylistNameNowPlaying%.plvlc, SavedPlaylist, SavedPlaylist
tempvar:=""
IniWrite, %Item%, SavedPlaylist/%PlaylistNameNowPlaying%.plvlc, SavedPlaylist, lastplayedItem
if (PlaylistNameNowPlaying)
IniWrite, %PlaylistNameNowPlaying%, ResumePlaylist.ini, Recent, RecentPlaylist
WinGetPos , tempX, tempY, tempW, tempH, ahk_id %my_id%
tempPosition:= [ tempX, tempY, tempW-WidthFix, tempH-HeightFix]
UserConfigurationSave.Gui.LastplayedPosition:=tempPosition
, UserConfigurationSave.Gui.Marqueetoggle:=!Marqueetoggle
, UserConfigurationSave.Gui.Titlebartoggle:=!Titlebartoggle
, UserConfigurationSave.Gui.DarkOverlaytoggle:=!DarkOverlaytoggle
, UserConfigurationSave.Gui.DarkOverlayOpacity:=DarkOverlayOpacity
, UserConfigurationSave.Gui.arnumber:=arnumber
, UserConfigurationSave.Gui.how_to_insert_image_into_notes:=how_to_insert_image_into_notes
tempvar:=JSON.Dump(UserConfigurationSave)
IniWrite, %tempvar%, UserConfigurationSave, UserConfigurationSave, UserConfigurationSave
vlc:="",  tempvar:="" 
Gui, Hide
Sleep, 200
; Gdip_Shutdown(pToken) 
; msgbox,% " PlaylistLoad.MaxIndex() = " PlaylistLoad.MaxIndex() " PlaylistNameNowPlaying  = " PlaylistNameNowPlaying " item " item 
ExitApp


~*$LButton::
WindowMouseDragMove()
Anchortoedge(UserVariables.b["Ignore_Taskbar"])   
return

~*$RButton::WindowMouseDragResize()

lbl_Optical_Character_RecognitionOCR:
OCR()
return






lbl_Speed_Increase:
OutputDebug,% "`n" A_ThisLabel " | "
gosub,overlayshift
if (vlc.input.rate<4)
vlc.input.rate+=0.1
Gosub, TimerMain
return

lbl_Speed_Decrease:
OutputDebug,% "`n" A_ThisLabel " | "
gosub,overlayshift
if (vlc.input.rate>0.3)
vlc.input.rate-=0.1
Gosub, TimerMain
return


lbl_Volume_Increase:
gosub,overlayshift
if (vlc.audio.volume<100)
vlc.audio.volume += UserVariables.n["VolumeChangeStep"]
Gosub, TimerMain
return




lbl_Volume_Decrease:
gosub,overlayshift
if (vlc.audio.volume>0)
vlc.audio.volume -= UserVariables.n["VolumeChangeStep"]
Gosub, TimerMain
Return

; / & d::

lbl_Backward:
gosub,overlayshift
vlc.input.time -= UserVariables.n["Seektime"]*1000
PlaylistNowPlaying[item].timelastleft:=vlc.input.time
Gosub, TimerMain
return

; / & f::

lbl_Forward:
gosub,overlayshift
vlc.input.time+= UserVariables.n["Seektime"]*1000
PlaylistNowPlaying[item].timelastleft:=vlc.input.time
Gosub, TimerMain
return

; / Up::
; ~Ctrl Up::
; ~Alt Up::
; ~#Alt Up::
; gosub, overlayreturn
; return

; ^!+O::
; :://to::


ShowHideDarkOverlay:
DarkOverlaytoggle:=!DarkOverlaytoggle
if (DarkOverlaytoggle) {
vlc.video.logo.enable()
vlc.video.logo.file("Overlay.png")
vlc.video.logo.opacity:=DarkOverlayOpacity
}
Else
{
vlc.video.logo.disable()
}
return

; / & h::
lbl_Overlay_Brightness_Increase:
OutputDebug,% "`n" A_ThisLabel " | "
if (DarkOverlayOpacity>0) {
   DarkOverlayOpacity-=10
vlc.video.logo.opacity:=DarkOverlayOpacity
}
Else
{
    DarkOverlayOpacity:=0, DarkOverlaytoggle:=0
    vlc.video.logo.disable()
}
Return

; / & g::
lbl_Overlay_Brightness_Decrease:
OutputDebug,% "`n" A_ThisLabel " | "
; tooltip,% DarkOverlayOpacity
; if (DarkOverlayOpacity=0){
DarkOverlaytoggle:=1
vlc.video.logo.enable()
vlc.video.logo.file("Overlay.png")
vlc.video.logo.opacity:=DarkOverlayOpacity
; }
if (DarkOverlayOpacity<255) {
DarkOverlayOpacity+=10
vlc.video.logo.opacity:=DarkOverlayOpacity
} 
Return


!wheelup::
lbl_Window_Size_Increase:
OutputDebug,% "`n" A_ThisLabel " | "
gosub, overlayreturn
 width+=SizeResizeStep
 GuiControl, MoveDraw, vlc, % "x0" "y22" "w"Width "h" (Width*choosenAspectRatioArr.2)//choosenAspectRatioArr.1
 sleep, 30
 Gui, show, % "NoActivate w"Width "h" ((Width*choosenAspectRatioArr.2)//choosenAspectRatioArr.1)+20
return

lbl_Window_Size_Decrease:
OutputDebug,% "`n" A_ThisLabel " | "
gosub, overlayreturn
 if (width>widthMin) {
 width-=SizeResizeStep
 GuiControl, MoveDraw, vlc, % "x0" "y22" "w"Width "h" (Width*choosenAspectRatioArr.2)//choosenAspectRatioArr.1
 sleep, 30
 Gui, show, % "NoActivate w"Width "h" ((Width*choosenAspectRatioArr.2)//choosenAspectRatioArr.1)+20
 }
return












MouseGesture(){
	Static
	MouseGetPos,xpos2, ypos2
	dx:=xpos2-xpos1,dy:=ypos1-ypos2
	( abs(dy) >= abs(dx) ? (dy > 0 ? (gesture:="U") : (gesture:="D")) : (dx > 0 ? (gesture:="R") : (gesture:="L")) )	
	,abs(dy)<5 and abs(dx)<5 ? (gesture := "") : ""	
	,xpos1:=xpos2,ypos1:=ypos2
	Return gesture
}

overlayshift:
WinGetPos, X, Y, Width, Height, ahk_id %my_id%
n_overlayposX:= X
n_overlayposY:= ((Y+Height)>(MonitorWorkAreaBottom-280)) ? Y-280 : Y+Height
n_overlayheight:= 280
n_overlayWidth:= Width
n_overlaytextsize:= 35
newline:="`n"
return




overlayreturn:
SetTimer, overlayreturn, off
newline:=""
n_overlayposX:= prev_overlayposX,  n_overlayposY := prev_overlayposY,  n_overlaywidth := prev_overlaywidth,  n_overlayheight := prev_overlayheight,  n_overlaytextsize := prev_overlaytextsize
gosub, overlaydraw
return





tooltipremove:
Tooltip,
SetTimer, tooltipremove, off
return










;=================================Test==================================================================================


; !Space::
; :://p::
lbl_Pause_Playback:
OutputDebug,% "`n" A_ThisLabel " | "
vlc.playlist.togglePause()
return


lbl_Insert_Screenshot_pasted_image:
how_to_insert_image_into_notes:=1
gosub, lbl_Insert_Screenshot
return


lbl_Insert_Screenshot_wiki_link:
how_to_insert_image_into_notes:=2
gosub, lbl_Insert_Screenshot
return


lbl_Insert_Screenshot_md_link:
how_to_insert_image_into_notes:=3
gosub, lbl_Insert_Screenshot
return



lbl_Insert_Screenshot:
if (!default_directory_screenshots) {
    gosub, SelectScreenShotSavelbl
return
}
vlc.video.takeSnapshot()
sleep,20
if (how_to_insert_image_into_notes = 3){
if FileExist("*.bmp") {
Loop Files, *.bmp, ; R  ; Recurse into subfolders.
{
FilePath := A_LoopFileLongPath
; ImagePutClipboard(FilePath)
default_directory_screenshots:= FileExist(default_directory_screenshots) ? default_directory_screenshots : A_ScriptDir "\VlcNotes\ScreenShots"
tempname:= ImagePutFile({image: FilePath, scale: [UserVariables.n["default_screen_shot_width"], ""]}, default_directory_screenshots . "\png") ; ImagePutFile(image, filepath, quality)
SplitPath, tempname, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
templink:="![" filename_original . "->" . runningtimehhmmss "](<file:///" . tempname . ">)"
Clipboard := templink
Send,^v
FileDelete, % A_LoopFileLongPath
}
}
}
Else if (how_to_insert_image_into_notes=2) {
 if FileExist("*.bmp") {
Loop Files, *.bmp, ; R  ; Recurse into subfolders.
{
FilePath := A_LoopFileLongPath
; ImagePutClipboard(FilePath)
default_directory_screenshots:= FileExist(default_directory_screenshots) ? default_directory_screenshots : A_ScriptDir "\VlcNotes\ScreenShots"
tempname:= ImagePutFile({image: FilePath, scale: [UserVariables.n["default_screen_shot_width"], ""]}, default_directory_screenshots . "\png")  ; ImagePutFile(image, filepath, quality)
SplitPath, tempname, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
templink:="![[" OutFileName . "|" . filename_original . "->" . runningtimehhmmss "]]"
Clipboard := templink
Send,^v
FileDelete, % A_LoopFileLongPath
}

}   

}
Else {
if FileExist("*.bmp") {
Loop Files, *.bmp, ; R  ; Recurse into subfolders.
{
FilePath := A_LoopFileLongPath
; ImagePutClipboard(FilePath)
ImagePutClipboard({image: FilePath, scale: [UserVariables.n["default_screen_shot_width"], ""]}) ; ImagePutClipboard(image)
ImagePutFile({image: FilePath, scale: [UserVariables.n["default_screen_shot_width"], ""]}, default_directory_screenshots . "\0") ; ImagePutFile(image, filepath, quality)
FileDelete, % A_LoopFileLongPath
}
SendInput, ^{v}
sleep, 200
SendInput,{Enter}
Gosub, lbl_Insert_Time_Stamp
}
}
return


lbl_Insert_Time_Stamp:
msec:=vlc.input.time
timestamp:=mstohhmmss(msec)
; <vlcNotes:Name-~-6445321-~-File:///D:\Lectures\test.mp4>
if (linkedTime=1) {
mdlink:=UserVariables.t["Time_Stamp_prefix"] . "[" . timestamp . UserVariables.t["insertSymbol"] . "](<vlcNotes:" . filename_original . "-~-" . msec . "-~-" . filepath_to_insert . ">)" . UserVariables.t["Time_Stamp_suffix"]
clipboard :=  mdlink    ; copy this text:
ClipWait, 2             ; wait max. 2 seconds for the clipboard to contain data. 
Send, ^v  
; Send,{Space}  
}
Else {
rawtimestamp:=  UserVariables.t["Time_Stamp_prefix"] . timestamp . UserVariables.t["insertSymbol"] . UserVariables.t["Time_Stamp_suffix"]
clipboard :=  rawtimestamp    ; copy this text:
ClipWait, 2             ; wait max. 2 seconds for the clipboard to contain data. 
Send, ^v  
}
return


lbl_Insert_Link:
OutputDebug,% "`n" A_ThisLabel " | "
if (UserVariables.b["insert_directlink_also"]=1) 
medialink:=UserVariables.t["link_prefix"] . "[" . filename_original . " 📽️ ](<vlcNotes:" . filename_original . "-~-" . UserVariables.n["Head_start_media"]*1000 . "-~-" . filepath_to_insert . ">) | [Direct Link](<" . filepath_original . ">)" . UserVariables.t["link_suffix"]
Else
medialink:=UserVariables.t["link_prefix"] . "[" . filename_original . " 📽️ ](<vlcNotes:" . filename_original . "-~-" . 0 . "-~-" . filepath_to_insert . ">)" . UserVariables.t["link_suffix"]
clipboard :=  medialink    ; copy this text:
ClipWait, 2             ; wait max. 2 seconds for the clipboard to contain data. 
Send, ^v 
return

lbl_Insert_Title:
OutputDebug,% "`n" A_ThisLabel " | "
mediatitle:=UserVariables.t["title_prefix"] . filename_original . UserVariables.t["title_suffix"]
clipboard :=  mediatitle    ; copy this text:
ClipWait, 2             ; wait max. 2 seconds for the clipboard to contain data. 
Send, ^v 
return


lbl_Insert_Time_Stamp_link:
linkedTime:=1
gosub, lbl_Insert_Time_Stamp
return


lbl_Insert_Time_Stamp_text:
linkedTime:=0
gosub, lbl_Insert_Time_Stamp
return


lbl_Time_Stamp_prefix:
lbl_Time_Stamp_suffix:
lbl_title_prefix:
lbl_title_suffix:
lbl_link_prefix:
lbl_link_suffix:
lbl_insertSymbol:
return






lbl_Window_Hide_Show:
guihideshow:=!guihideshow
if (guihideshow) {
gui, Hide
}
else
{
gui, show, NoActivate
}
return


;=======================================================================================================================
~^MButton::
if (A_PriorHotkey <> A_ThisHotkey Or A_TimeSincePriorHotkey > 400)
		Return
if (inlinetime=1) {
MouseClick, Left,,, 2
SendInput,{Right}^{Right 2}
gosub, ocrtimefind
}
else{
MouseClick, Left,,, 3
hhmmss:=Grabline()
SendInput,{Right}
}
tmsec:=hhmmsstotmsec(hhmmss)
tmsec:=(tmsec>totaltimemsec) ? totaltimemsec-2000 : tmsec
if (tmsec)
vlc.input.time:=tmsec
;~ ToolTip,% mstohhmmss()
Gosub, TimerMain
return

ocrtimefind:
MouseGetPos  OutputVarX, OutputVarY
srr:=[186,623,200,50]
srr.1:= OutputVarX-100
srr.2:= OutputVarY-25
hhmmss := OCR(srr)
return



;{================================Grabline underneath to clipboard======================================================
Grabline() {
	OldClip := ClipboardAll ; Back up Clipboard
	Clipboard := "" ; Empties clipboard
	;~ MouseClick, Left,,, 3 ; Left Click 2 times to mark word
	Send, ^c ; Save to clipboard
	ClipWait, 1, 1 ; Waits for Clip
	ClipVar := Clipboard ; Saves word to ClipVar
	Clipboard := OldClip ; Restores old clipboard
	Return ClipVar ; Returns the word to function call
}
;}======================================================================================================================





;========================================================================================================================
;[ hhmmss to milliseconds and milliseconds to hhmmss ]{==================================================================

mstohhmmss(msec) {
    ;~ msec:=vlc.input.time
    if (msec=0 )
    return
	secs := floor(mod((msec / 1000),60))
	mins := floor(mod((msec / (1000 * 60)), 60) )
	hour := floor(mod((msec / (1000 * 60 * 60)) , 24))
	return Format("{:02}:{:02}:{:02}",hour,mins,secs)
}



hhmmsstotmsec(hhmmss) {
hhmmss_arr:=[]
hhmmss := StrReplace(hhmmss, "`r`n")
hhmmss := StrReplace(hhmmss, A_Space)
RegExMatch(hhmmss, "(h*\d{1,2}(?:\.|:)\d{1,2}(?:\.|:)\d{1,2})|(h*\d{1,2}(?:\.|:)\d{1,2})",hhmmss)
hhmmss := StrReplace(hhmmss,":","/")
hhmmss := StrReplace(hhmmss,".","/")
hhmmss_arr:=StrSplit(hhmmss,"/")
if (hhmmss_arr.MaxIndex()=3) {
tmsec:=(hhmmss_arr.1*60*60*1000) + (hhmmss_arr.2*60*1000) + (hhmmss_arr.3*1000)
}
Else if (hhmmss_arr.MaxIndex()=2) {
tmsec:= (hhmmss_arr.1*60*1000) + (hhmmss_arr.2*1000)
}
Else if (hhmmss_arr.MaxIndex()=1) {
tmsec:=""
}
return tmsec
}





;}=====================================================================================================================
;======================================================================================================================






WM_NCCALCSIZE()
{
    if A_Gui
        return 0    ; Sizes the client area to fill the entire window.
}

; Redefine where the sizing borders are.  This is necessary since
; returning 0 for WM_NCCALCSIZE effectively gives borders zero size.


WM_NCHITTEST(wParam, lParam)
{
    static border_size = 6

    if !A_Gui
        return

    WinGetPos, gX, gY, gW, gH

    x := lParam<<48>>48, y := lParam<<32>>48

    hit_left    := x <  gX+border_size
    hit_right   := x >= gX+gW-border_size
    hit_top     := y <  gY+border_size
    hit_bottom  := y >= gY+gH-border_size

    if hit_top
    {
        if hit_left
            return 0xD
        else if hit_right
            return 0xE
        else
            return 0xC
    }
    else if hit_bottom
    {
        if hit_left
            return 0x10
        else if hit_right
            return 0x11
        else
            return 0xF
    }
    else if hit_left
        return 0xA
    else if hit_right
        return 0xB

    ; else let default hit-testing be done
}



memorycheck:
memx:=checkWorkingset()//1024 . "-kB-RAM"
ToolTip, %memx%
return
checkWorkingset(pid:=""){
    static wmi:=comObjGet("winmgmts:{impersonationLevel=impersonate}!\\" . a_computerName . "\root\cimv2")
    pid:=pid?pid:dllCall("GetCurrentProcessId")
    processInfo:=wmi.execQuery("select WorkingSetSize,ProcessId from Win32_Process")._NewEnum
    while(processInfo[item]){
        if(item.processId=pid){
            workingSet:=item.WorkingSetSize
            break
        }
    }
    return workingSet
}


WM_MOUSEMOVE( wparam, lparam, msg, hwnd )
{
    MouseGetPos,,,, OutputVarControl
    if (OutputVarControl="Static1"){
        loop, 3
            {
             MouseGetPos,,,, OutputVarControl
             if (OutputVarControl!="Static1")
                break
        loop, 10
            {
                GuiControl,, Picture1, %A_ScriptDir%\assets\skbfklsfkionu_%A_Index%.png
                Sleep 50
            }
            loop, 10
                {
                    tn:=11-A_Index
                    GuiControl,, Picture1, %A_ScriptDir%\assets\skbfklsfkionu_%tn%.png
                    Sleep 50
                }
            }
    }
	if wparam = 1 ; LButton
        {
		PostMessage, 0xA1, 2,,, A ; WM_NCLBUTTONDOWN
        }
}

;=========================Autoresize===============================================================
AutoXYWH(DimSize, cList*){  ; http://ahkscript.org/boards/viewtopic.php?t=1079
  static cInfo := {}
  If !cInfo[A_Gui].ClassNN.MaxIndex() {
    WinGet, CH, ControlListHwnd,
    WinGet, CN, ControlList,
    ACH := StrSplit(CH, "`n"), ACN := StrSplit(CN, "`n")
    Loop, % ACH.MaxIndex()
      If InStr(ACN[A_Index], "Button")   ;GroupBox have a ClassNN of 'Button'
        cInfo[A_Gui , "ClassNN" , ACH[A_Index]] := 1
  }
  For i, ctrl in cList {
    ctrlID := A_Gui ":" ctrl
    If ( cInfo[ctrlID].x = "" ){
        GuiControlGet, i, %A_Gui%:Pos, %ctrl%
        GuiControlGet, Hwnd, %A_Gui%:Hwnd, %ctrl%
        MMD := cInfo[A_Gui,"ClassNN",Hwnd] ? "MoveDraw" : "Move"
        fx := fy := fw := fh := 0
        For i, dim in (a := StrSplit(RegExReplace(DimSize, "i)[^xywh]")))
            If !RegExMatch(DimSize, "i)" dim "\s*\K[\d.-]+", f%dim%)
              f%dim% := 1
        cInfo[ctrlID] := { x:ix, fx:fx, y:iy, fy:fy, w:iw, fw:fw, h:ih, fh:fh, gw:A_GuiWidth, gh:A_GuiHeight, a:a , m:MMD}
    }Else If ( cInfo[ctrlID].a.1) {
        dgx := dgw := A_GuiWidth  - cInfo[ctrlID].gw  , dgy := dgh := A_GuiHeight - cInfo[ctrlID].gh
        For i, dim in cInfo[ctrlID]["a"]
            Options .= dim (dg%dim% * cInfo[ctrlID]["f" dim] + cInfo[ctrlID][dim]) A_Space
        GuiControl, % A_Gui ":" cInfo[ctrlID].m , % ctrl, % Options
} } }





;=========================Keep Aspect reatio function==============================================
GuiSizing(WP, LP) {
    ; -------------------------------------------------------------------------------------
    ; http://msdn.microsoft.com/en-us/library/ms632647(v=vs.85).aspx
    ; WP: The edge of the window that is being sized. This can be one of the following values:
    ; 1 = Left, 2 = Right, 3 = Top, 4 = TopLeft, 5 = TopRight, 6 = Bottom, 7 = BottomLeft, 8 = BottomRight
    ; LP: A pointer to a RECT structure with the screen coordinates of the drag rectangle.
    ; -------------------------------------------------------------------------------------
    Static WR := "", HR := "", PL := 0, PT := 0, PR := 0, PB := 0
    L := NumGet(LP + 0,  0, "Int") , R := NumGet(LP + 0,  8, "Int")
    T := NumGet(LP + 0,  4, "Int") , B := NumGet(LP + 0, 12, "Int")
    If ( WR == "" )
        WR := (R-L)/(B-T), HR := (B-T)/(R-L), PL := L, PT := T, PR := R, PB := B
    DL := Abs(PL-L), DT := Abs(PT-T), DR := Abs(PR-R), DB := Abs(PB-B)
    If (DL || DT || DR || DB) {
        If (WP = 1) || (WP = 2) ; --------------------------- Left or Right
            B := T+((R-L)*HR) , NumPut(B, LP + 0, 12, "Int")
        Else If (WP = 3) || (WP = 6) ; ---------------------- Top or Bottom
            R := L+((B-T)*WR) , NumPut(R, LP + 0,  8, "Int")
        Else If (WP = 4) || (WP = 5) { ; -------------------- TopLeft or TopRight
            T := B-((R-L)*HR), Confine(1,0,T-2,999999,T+2)
            NumPut( T , LP + 0 ,  4 , "Int"), Confine(0)
        } Else If (WP = 7) || (WP = 8) { ; ------------------ BottomLeft or BottomRight
            B := T+((R-L)*HR), Confine(1,0,B-2,999999,B+2)
            NumPut( B , LP + 0 , 12 , "Int"), Confine(0)
        }
        PL := NumGet(LP + 0,  0, "Int") , PR := NumGet(LP + 0,  8, "Int")
        PT := NumGet(LP + 0,  4, "Int") , PB := NumGet(LP + 0, 12, "Int")
    }
}

;=============================

; Following function adapted by MasterFocus, originally from
; http://www.autohotkey.com/community/viewtopic.php?f=2&t=22178
Confine(C=0,X1=0,Y1=0,X2=0,Y2=0) {
  VarSetCapacity(R,16,0),NumPut(X1,&R+0),NumPut(Y1,&R+4),NumPut(X2,&R+8),NumPut(Y2,&R+12)
  Return C ? DllCall("ClipCursor",UInt,&R) : DllCall("ClipCursor")
}

;===================================================================================================




;===========================Move and Resize==========================================================




/**
;  	File: WinDrag.ahk
; 	Author: 	nickstokes
; 	Forum:		https://www.autohotkey.com/boards/viewtopic.php?t=57703
; 				https://www.autohotkey.com/boards/viewtopic.php?f=5&t=48520&p=216669

Example usage, add the following three lines to your AHK script:


#Include windrag.ahk
^!LButton::WindowMouseDragMove()
^!RButton::WindowMouseDragResize()


* While holding down ctrl+alt, left click anywhere on a window and drag to move.
* While holding down ctrl+alt, right click any outer quadrant of a window and
  drag to resize, or near the center of a window to move. The system icons will
  show where you're going.

*/

;    +---------------------+
;    |   Set/Reset cursor  |
;    +---------------------+
; from: https://autohotkey.com/board/topic/32608-changing-the-system-cursor/

; Parameter 1 is file path or cursor name, e.g. IDC_SIZEALL. If this is omitted it will hide the cursor.
;   IDC_ARROW     IDC_UPARROW      IDC_SIZENESW      IDC_NO
;   IDC_IBEAM     IDC_SIZE         IDC_SIZEWE        IDC_HAND
;   IDC_WAIT      IDC_ICON         IDC_SIZENS        IDC_APPSTARTING
;   IDC_CROSS     IDC_SIZENWSE     IDC_SIZEALL       IDC_HELP
;
; Parameters 2 and 3 are the desired width and height of cursor. Omit these to use the default size, e.g. loading a 48x48 cursor will display as 48x48.
;
SetSystemCursor( Cursor = "", cx = 0, cy = 0 )
{
	BlankCursor := 0, SystemCursor := 0, FileCursor := 0 ; init

	SystemCursors = 32512IDC_ARROW,32513IDC_IBEAM,32514IDC_WAIT,32515IDC_CROSS
	,32516IDC_UPARROW,32640IDC_SIZE,32641IDC_ICON,32642IDC_SIZENWSE
	,32643IDC_SIZENESW,32644IDC_SIZEWE,32645IDC_SIZENS,32646IDC_SIZEALL
	,32648IDC_NO,32649IDC_HAND,32650IDC_APPSTARTING,32651IDC_HELP

	If Cursor = ; empty, so create blank cursor
	{
		VarSetCapacity( AndMask, 32*4, 0xFF ), VarSetCapacity( XorMask, 32*4, 0 )
		BlankCursor = 1 ; flag for later
	}
	Else If SubStr( Cursor,1,4 ) = "IDC_" ; load system cursor
	{
		Loop, Parse, SystemCursors, `,
		{
			CursorName := SubStr( A_Loopfield, 6, 15 ) ; get the cursor name, no trailing space with substr
			CursorID := SubStr( A_Loopfield, 1, 5 ) ; get the cursor id
			SystemCursor = 1
			If ( CursorName = Cursor )
			{
				CursorHandle := DllCall( "LoadCursor", Uint,0, Int,CursorID )
				Break
			}
		}
		If CursorHandle = ; invalid cursor name given
		{
			Msgbox,, SetCursor, Error: Invalid cursor name
			CursorHandle = Error
		}
	}
	Else If FileExist( Cursor )
	{
		SplitPath, Cursor,,, Ext ; auto-detect type
		If Ext = ico
			uType := 0x1
		Else If Ext in cur,ani
			uType := 0x2
		Else ; invalid file ext
		{
			Msgbox,, SetCursor, Error: Invalid file type
			CursorHandle = Error
		}
		FileCursor = 1
	}
	Else
	{
		Msgbox,, SetCursor, Error: Invalid file path or cursor name
		CursorHandle = Error ; raise for later
	}
	If CursorHandle != Error
	{
		Loop, Parse, SystemCursors, `,
		{
			If BlankCursor = 1
			{
				Type = BlankCursor
				%Type%%A_Index% := DllCall( "CreateCursor"
				, Uint,0, Int,0, Int,0, Int,32, Int,32, Uint,&AndMask, Uint,&XorMask )
				CursorHandle := DllCall( "CopyImage", Uint,%Type%%A_Index%, Uint,0x2, Int,0, Int,0, Int,0 )
				DllCall( "SetSystemCursor", Uint,CursorHandle, Int,SubStr( A_Loopfield, 1, 5 ) )
			}
			Else If SystemCursor = 1
			{
				Type = SystemCursor
				CursorHandle := DllCall( "LoadCursor", Uint,0, Int,CursorID )
				%Type%%A_Index% := DllCall( "CopyImage"
				, Uint,CursorHandle, Uint,0x2, Int,cx, Int,cy, Uint,0 )
				CursorHandle := DllCall( "CopyImage", Uint,%Type%%A_Index%, Uint,0x2, Int,0, Int,0, Int,0 )
				DllCall( "SetSystemCursor", Uint,CursorHandle, Int,SubStr( A_Loopfield, 1, 5 ) )
			}
			Else If FileCursor = 1
			{
				Type = FileCursor
				%Type%%A_Index% := DllCall( "LoadImageA"
				, UInt,0, Str,Cursor, UInt,uType, Int,cx, Int,cy, UInt,0x10 )
				DllCall( "SetSystemCursor", Uint,%Type%%A_Index%, Int,SubStr( A_Loopfield, 1, 5 ) )
			}
		}
	}
}

RestoreCursors()
{
	SPI_SETCURSORS := 0x57
	DllCall( "SystemParametersInfo", UInt,SPI_SETCURSORS, UInt,0, UInt,0, UInt,0 )
}





;          +-----------------------------------------+
;          |          SetWindowPosNoFlicker          |
;          +-----------------------------------------+
SetWindowPosNoFlicker(handle, wx, wy, ww, wh)
{

 ;WinMove ahk_id %handle%,, wx, wy, ww, wh

  DllCall("user32\SetWindowPos"
   , "Ptr", handle
   , "Ptr", 0
   , "Int", wx
   , "Int", wy
   , "Int", ww
   , "Int", wh
   , "UInt", 0)
  ; 0x4000	= SWP_ASYNCWINDOWPOS
; 0x2000	= SWP_DEFERERASE
; 0x400		= SWP_NOSENDCHANGING
; 0x200		= SWP_NOOWNERZORDER
; 0x100		= SWP_NOCOPYBITS
; 0x10		= SWP_NOACTIVATE
; 0x8			= SWP_NOREDRAW
; 0x4			= SWP_NOZORDER



  ;DllCall("user32\RedrawWindow"
  ; , "Ptr", handle
  ; , "Ptr", 0
  ; , "Ptr", 0
  ;, "UInt", 0x0100)  ;RDW_INVALIDATE | RDW_UPDATENOW

  /*
   RDW_INVALIDATE          0x0001
   RDW_INTERNALPAINT       0x0002
   RDW_ERASE               0x0004

   RDW_VALIDATE            0x0008
   RDW_NOINTERNALPAINT     0x0010
   RDW_NOERASE             0x0020

   RDW_NOCHILDREN          0x0040
   RDW_ALLCHILDREN         0x0080

   RDW_UPDATENOW           0x0100
   RDW_ERASENOW            0x0200

   RDW_FRAME               0x0400
   RDW_NOFRAME             0x0800
  */

}









WindowMouseDragMove()
{
MouseButton := DetermineMouseButton()
w1:=A_GuiWidth
CoordMode, Mouse, Screen
MouseGetPos, x0, y0, window_id
;~ WinGet, window_id, ID, A
WinGet, window_minmax, MinMax, ahk_id %window_id%
WinGetPos, wx, wy, ww, wh, ahk_id %window_id%
sleep, 20
w2:=A_GuiWidth
; Return if the window is maximized or minimized
if (window_minmax <> 0 ) || (window_id != my_id) || (w1!=w2)
{
   return
}
init := 1
SetWinDelay, 0
while(GetKeyState(MouseButton, "P"))
{
  MouseGetPos, x, y

  if( x == x0 && y == y0 ) {
     continue
  }

  if( init == 1 )  {
     SetSystemCursor( "IDC_SIZEALL" )
	 init := 0
  }

  wx += x - x0
  wy += y - y0
  x0 := x
  y0 := y

  WinMove ahk_id %window_id%,, wx, wy
}
SetWinDelay, -1
RestoreCursors()
return
}


;          +--------------------------------------------+
;          |             WindowMouseDragResize          |
;          +--------------------------------------------+

/**
@brief Resize windows from anywhere within the window, without having to aim the edges or corners
 following mouse while right-click press

For example:

@code
^!RButton::WindowMouseDragResize()
@endcode

Initial mouse move determines which corner to drag for resize.
Use in combination with WindowMouseDragMove for best effect.

@todo `WindowMouseDragResize` Right-click is hardcoded. Customize to any given key.
@todo `WindowMouseDragResize` Inverted option as an argument for corner-selection logic.

@remark based on: https://autohotkey.com/board/topic/25106-altlbutton-window-dragging/
Fixed a few things here and there
*/


WindowMouseDragResize0()
{
MouseButton := DetermineMouseButton()
CoordMode, Mouse, Screen
MouseGetPos, mx0, my0, window_id
WinGetPos, wx, wy, ww, wh, ahk_id %window_id%
WinGet, window_minmax, MinMax, ahk_id %window_id%

; menu-resize based solution -
; https://autohotkey.com/boards/viewtopic.php?f=5&t=48520&p=216844#p216844
; WinMenuSelectItem, ahk_id %window_id%,,0&, Size
; return


SetWinDelay, 0

; Resore if maximized
if (window_minmax > 0)
{
  WinRestore ahk_id %window_id%

  ; Restore the window if maximized or minimized and set the position as seen
  ; badeffect ; WinMove ahk_id %window_id%, , wx, wy, ww, wh
}


; window-menu ; mx := mx0
; window-menu ; my := my0
; window-menu ; while(mx == mx0 || my == my0) {
; window-menu ;    Sleep 10
; window-menu ;    MouseGetPos, mx, my
; window-menu ; }
; window-menu ;
; window-menu ; ; 0x0112 WM_SYSCOMMAND
; window-menu ; ; 0xF000 SC_SIZE
; window-menu ; PostMessage,  0x0112, 0xF000, 0, , ahk_id %window_id%
; window-menu ; if( ErrorLevel != 0 ) {
; window-menu ;    return
; window-menu ; }

firstDeltaX := "init"
firstDeltaY := "init"
cursorInit := 1
while(GetKeyState(MouseButton,"P")) {
  ; resize the window based on cursor position
  MouseGetPos, mx, my
  if(mx == mx0 && my == my0) {
     continue
  }

  if( firstDeltaX == "init" && mx-mx0 <> 0 ) {
     firstDeltaX := mx-mx0
  }
  if( firstDeltaY == "init" && my-my0 <> 0 ) {
     firstDeltaY := my-my0
  }
  if( cursorInit == 1 &&  firstDeltaX != "init"  &&  firstDeltaY != "init") {
	 SetSystemCursor( firstDeltaX*firstDeltaY>0 ? "IDC_SIZENWSE" : "IDC_SIZENESW" )
	 cursorInit := 0
  }

  deltaX := mx - mx0
  deltaY := my - my0

  if(firstDeltaX<0) {
    ww += deltaX
  }
  else {
	wx += deltaX
	ww -= deltaX
  }
  if(firstDeltaY<0) {
    wh += deltaY
  }
  else {
	wy += deltaY
	wh -= deltaY
  }

  mx0 := mx
  my0 := my

  WinMove ahk_id %window_id%,, wx, wy, ww, wh
}
RestoreCursors()
return
}





;          +--------------------------------------------+
;          |             WindowMouseDragResize          |
;          +--------------------------------------------+

/**
@brief Resize windows from anywhere within the window, without having to aim the edges or corners
 following mouse while right-click press

For example:

@code
^!RButton::WindowMouseDragResize()
@endcode

Initial mouse move determines which corner to drag for resize.
Use in combination with WindowMouseDragMove for best effect.

@todo `WindowMouseDragResize` Right-click is hardcoded. Customize to any given key.
@todo `WindowMouseDragResize` Inverted option as an argument for corner-selection logic.

@remark based on: https://autohotkey.com/board/topic/25106-altlbutton-window-dragging/
Fixed a few things here and there
*/

WindowMouseDragResize()
{
MouseButton := DetermineMouseButton()
; determine corner drag if mouse is this many percent points away from the center
cornerTolerance := 20
CoordMode, Mouse, Screen
MouseGetPos, mx0, my0, window_id
WinGetPos, wx, wy, ww, wh, ahk_id %window_id%
WinGet, window_minmax, MinMax, ahk_id %window_id%

; menu-resize based solution -
; https://autohotkey.com/boards/viewtopic.php?f=5&t=48520&p=216844#p216844
; WinMenuSelectItem, ahk_id %window_id%,,0&, Size
; return
if (window_id != my_id)
{
return                ; only resize my window
}

SetWinDelay, 0

; Restore if maximized [??]
if (window_minmax > 0)
{
  WinRestore ahk_id %window_id%
}

; establish drag corner depending on which quadrant the mouse is
wxCenter := wx+(ww/2)
wyCenter := wy+(wh/2)
xNoCornerZoneHalfSize := ww*(cornerTolerance/200.) ; 100 is for percent, 2 is for half
yNoCornerZoneHalfSize := wh*(cornerTolerance/200.)
wxLeftCorner   := wxCenter - xNoCornerZoneHalfSize
wxRightCorner  := wxCenter + xNoCornerZoneHalfSize
wyTopCorner    := wyCenter - yNoCornerZoneHalfSize
wyBottomCorner := wyCenter + yNoCornerZoneHalfSize

xCorner := mx0 < wxLeftCorner  ?  -1 : mx0>wxRightCorner  ? 1 : 0
yCorner := my0 < wyTopCorner   ?  -1 : my0>wyBottomCorner ? 1 : 0
; OutputDebug % "slyutil: win " wx " " wy " " ww " " wh
; OutputDebug % "slyutil: mouse " mx0 " " my0
; OutputDebug, slyutil: wxCenter %wxCenter% wyCenter %wyCenter%  xNoCornerZoneHalfSize %xNoCornerZoneHalfSize% yNoCornerZoneHalfSize %yNoCornerZoneHalfSize%
; OutputDebug, slyutil: xCorner %xCorner% yCorner %yCorner%

if( xCorner*yCorner>0 )
  SetSystemCursor("IDC_SIZENWSE")
else if (xCorner*yCorner<0)
  SetSystemCursor("IDC_SIZENESW")
else
{
   if(xCorner==0 && yCorner == 0)
     SetSystemCursor("IDC_SIZEALL")
   else
     SetSystemCursor( xCorner==0 ? "IDC_SIZENS" : "IDC_SIZEWE")
}



;SendMessage 0x0B, 1, , ,  ahk_id %window_id%
;SendMessage, 0x231, 0, 0,, ahk_id %window_id%	; WM_ENTERSIZEMOVE

while(GetKeyState(MouseButton,"P")) {
  MouseGetPos, mx, my
  if(mx == mx0 && my == my0) {
     continue
  }

  deltaX := mx - mx0
  deltaY := my - my0

  if(xCorner == 0 && yCorner == 0) {
    ; move
    wx += mx - mx0
    wy += my - my0
  }
  else if(xCorner>0)
    ww += deltaX
  else if(xCorner<0)
  {
	 wx += deltaX
	 ww -= deltaX
  }
  if(yCorner>0)
    wh += deltaY
  else if(yCorner<0)
  {
	 wy += deltaY
	 wh -= deltaY
  }

  mx0 := mx
  my0 := my

  SetWindowPosNoFlicker(window_id, wx, wy, ww, wh)
}
;SendMessage 0x0B, 0, , ,  ahk_id %window_id%
;SendMessage, 0x232, 0, 0,, ahk_id %window_id%	; WM_EXITSIZEMOVE
RestoreCursors()
return
}



DetermineMouseButton() {
; Author: 	Cyberklabauter
; Forum:   https://www.autohotkey.com/boards/viewtopic.php?f=6&t=57703&p=378638#p378638
	If (InStr(a_thisHotkey, "LButton"))
		return "LButton"
	If (InStr(a_thisHotkey, "MButton"))
		return "MButton"
	If (InStr(a_thisHotkey, "RButton"))
		return "RButton"
	If (InStr(a_thisHotkey, "XButton1"))
		return "XButton1"
	If (InStr(a_thisHotkey, "XButton2"))
		return "XButton2"
	}


;[Custom open file]{==========================================================================
/*
    Displays a standard dialog that allows the user to open file(s).
    Parameters:
        Owner / Title:
            The identifier of the window that owns this dialog. This value can be zero.
            An Array with the identifier of the owner window and the title. If the title is an empty string, it is set to the default.
        FileName:
            The path to the file or directory selected by default. If you specify a directory, it must end with a backslash.
        Filter:
            Specify a file filter. You must specify an object, each key represents the description and the value the file types.
            To specify the filter selected by default, add the "`n" character to the value.
        CustomPlaces:
            Specify an Array with the custom directories that will be displayed in the left pane. Missing directories will be omitted.
            To specify the location in the list, specify an Array with the directory and its location (0 = Lower, 1 = Upper).
        Options:
            Determines the behavior of the dialog. This parameter must be one or more of the following values.
                0x00000200 (FOS_ALLOWMULTISELECT) = Enables the user to select multiple items in the open dialog.
                0x00001000    (FOS_FILEMUSTEXIST) = The item returned must exist.
                0x00040000 (FOS_HIDEPINNEDPLACES) = Hide items shown by default in the view's navigation pane.
                0x02000000  (FOS_DONTADDTORECENT) = Do not add the item being opened or saved to the recent documents list (SHAddToRecentDocs).
                0x10000000  (FOS_FORCESHOWHIDDEN) = Include hidden and system items.
            You can check all available values â€‹â€‹at https://msdn.microsoft.com/en-us/library/windows/desktop/dn457282(v=vs.85).aspx.
    Return:
        Returns 0 if the user canceled the dialog, otherwise returns the path of the selected file.
        If you specified the FOS_ALLOWMULTISELECT option and the function succeeded, it returns an Array with the path of the selected files.
*/
ChooseFile(Owner, FileName := "", Filter := "", CustomPlaces := "", Options := 0x1000)
{
    ; IFileOpenDialog interface
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775834(v=vs.85).aspx
    local IFileOpenDialog := ComObjCreate("{DC1C5A9C-E88A-4DDE-A5A1-60F82A20AEF7}", "{D57C7288-D4AD-4768-BE02-9D969532D960}")
        ,           Title := IsObject(Owner) ? Owner[2] . "" : ""
        ,           Flags := Options     ; FILEOPENDIALOGOPTIONS enumeration (https://msdn.microsoft.com/en-us/library/windows/desktop/dn457282(v=vs.85).aspx)
        ,      IShellItem := PIDL := 0   ; PIDL recibe la direcciÃ³n de memoria a la estructura ITEMIDLIST que debe ser liberada con la funciÃ³n CoTaskMemFree
        ,             Obj := {COMDLG_FILTERSPEC: ""}, foo := bar := ""
        ,       Directory := FileName
    Owner := IsObject(Owner) ? Owner[1] : (WinExist("ahk_id" . Owner) ? Owner : 0)
    Filter := IsObject(Filter) ? Filter : {"All files": "*.*"}


    if ( FileName != "" )
    {
        if ( InStr(FileName, "\") )
        {
            if !( FileName ~= "\\$" )    ; si Â«FileNameÂ» termina con "\" se trata de una carpeta
            {
                local File := ""
                SplitPath FileName, File, Directory
                ; IFileDialog::SetFileName
                ; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775974(v=vs.85).aspx
                StrPutVar(File, FileW, "UTF-16")
                DllCall(NumGet(NumGet(IFileOpenDialog+0)+15*A_PtrSize), "UPtr", IFileOpenDialog, "UPtr", &FileW)
            }

            while ( InStr(Directory,"\") && !DirExist(Directory) )                   ; si el directorio no existe buscamos directorios superiores
                Directory := SubStr(Directory, 1, InStr(Directory, "\",, -1) - 1)    ; recupera el directorio superior
            if ( DirExist(Directory) )
            {
                StrPutVar(Directory, DirectoryW, "UTF-16")
                DllCall("Shell32.dll\SHParseDisplayName", "UPtr", &DirectoryW, "Ptr", 0, "UPtrP", PIDL, "UInt", 0, "UInt", 0)
                DllCall("Shell32.dll\SHCreateShellItem", "Ptr", 0, "Ptr", 0, "UPtr", PIDL, "UPtrP", IShellItem)
                ObjRawSet(Obj, IShellItem, PIDL)
                ; IFileDialog::SetFolder method
                ; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761828(v=vs.85).aspx
                DllCall(NumGet(NumGet(IFileOpenDialog+0)+12*A_PtrSize), "Ptr", IFileOpenDialog, "UPtr", IShellItem)
            }
        }
        else
        {
            StrPutVar(FileName, FileNameW, "UTF-16")
            DllCall(NumGet(NumGet(IFileOpenDialog+0)+15*A_PtrSize), "UPtr", IFileOpenDialog, "UPtr", &FileNameW)
        }
    }


    ; COMDLG_FILTERSPEC structure
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/bb773221(v=vs.85).aspx
    local Description := "", FileTypes := "", FileTypeIndex := 1
    ObjSetCapacity(Obj, "COMDLG_FILTERSPEC", 2*Filter.Count() * A_PtrSize)
    for Description, FileTypes in Filter
    {
        FileTypeIndex := InStr(FileTypes,"`n") ? A_Index : FileTypeIndex
        StrPutVar(Trim(Description), desc_%A_Index%, "UTF-16")
        StrPutVar(Trim(StrReplace(FileTypes,"`n")), ft_%A_Index%, "UTF-16")
        NumPut(&desc_%A_Index%, ObjGetAddress(Obj,"COMDLG_FILTERSPEC") + A_PtrSize * 2*(A_Index-1))        ; COMDLG_FILTERSPEC.pszName
        NumPut(&ft_%A_Index%, ObjGetAddress(Obj,"COMDLG_FILTERSPEC") + A_PtrSize * (2*(A_Index-1)+1))    ; COMDLG_FILTERSPEC.pszSpec
    }

    ; IFileDialog::SetFileTypes method
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775980(v=vs.85).aspx
    DllCall(NumGet(NumGet(IFileOpenDialog+0)+4*A_PtrSize), "UPtr", IFileOpenDialog, "UInt", Filter.Count(), "UPtr", ObjGetAddress(Obj,"COMDLG_FILTERSPEC"))

    ; IFileDialog::SetFileTypeIndex method
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775978(v=vs.85).aspx
    DllCall(NumGet(NumGet(IFileOpenDialog+0)+5*A_PtrSize), "UPtr", IFileOpenDialog, "UInt", FileTypeIndex)


    if ( IsObject(CustomPlaces := IsObject(CustomPlaces) || CustomPlaces == "" ? CustomPlaces : [CustomPlaces]) )
    {
        for foo, Directory in CustomPlaces    ; foo = index
        {
            foo := IsObject(Directory) ? Directory[2] : 0    ; FDAP enumeration (https://msdn.microsoft.com/en-us/library/windows/desktop/bb762502(v=vs.85).aspx)
            if ( DirExist(Directory := IsObject(Directory) ? Directory[1] : Directory) )
            {
                StrPutVar(Directory, DirectoryW, "UTF-16")
                DllCall("Shell32.dll\SHParseDisplayName", "UPtr", &DirectoryW, "Ptr", 0, "UPtrP", PIDL, "UInt", 0, "UInt", 0)
                DllCall("Shell32.dll\SHCreateShellItem", "Ptr", 0, "Ptr", 0, "UPtr", PIDL, "UPtrP", IShellItem)
                ObjRawSet(Obj, IShellItem, PIDL)
                ; IFileDialog::AddPlace method
                ; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775946(v=vs.85).aspx
                DllCall(NumGet(NumGet(IFileOpenDialog+0)+21*A_PtrSize), "UPtr", IFileOpenDialog, "UPtr", IShellItem, "UInt", foo)
            }
        }
    }


    ; IFileDialog::SetTitle method
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761834(v=vs.85).aspx
    StrPutVar(Title, TitleW, "UTF-16")
    DllCall(NumGet(NumGet(IFileOpenDialog+0)+17*A_PtrSize), "UPtr", IFileOpenDialog, "UPtr", Title == "" ? 0 : &TitleW)

    ; IFileDialog::SetOptions method
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761832(v=vs.85).aspx
    DllCall(NumGet(NumGet(IFileOpenDialog+0)+9*A_PtrSize), "UPtr", IFileOpenDialog, "UInt", Flags)


    ; IModalWindow::Show method
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761688(v=vs.85).aspx
    local Result := []
    if ( !DllCall(NumGet(NumGet(IFileOpenDialog+0)+3*A_PtrSize), "UPtr", IFileOpenDialog, "Ptr", Owner, "UInt") )
    {
        ; IFileOpenDialog::GetResults method
        ; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775831(v=vs.85).aspx
        local IShellItemArray := 0    ; IShellItemArray interface (https://msdn.microsoft.com/en-us/library/windows/desktop/bb761106(v=vs.85).aspx)
        DllCall(NumGet(NumGet(IFileOpenDialog+0)+27*A_PtrSize), "UPtr", IFileOpenDialog, "UPtrP", IShellItemArray)

        ; IShellItemArray::GetCount method
        ; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761098(v=vs.85).aspx
        local Count := 0    ; pdwNumItems
        DllCall(NumGet(NumGet(IShellItemArray+0)+7*A_PtrSize), "UPtr", IShellItemArray, "UIntP", Count, "UInt")

        local Buffer := ""
        loop % 0*VarSetCapacity(Buffer,32767 * 2) + Count
        {
            ; IShellItemArray::GetItemAt method
            ; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761100(v=vs.85).aspx
            DllCall(NumGet(NumGet(IShellItemArray+0)+8*A_PtrSize), "UPtr", IShellItemArray, "UInt", A_Index-1, "UPtrP", IShellItem)
            DllCall("Shell32.dll\SHGetIDListFromObject", "UPtr", IShellItem, "UPtrP", PIDL)
            DllCall("Shell32.dll\SHGetPathFromIDListEx", "UPtr", PIDL, "Str", Buffer, "UInt", 32767, "UInt", 0)
            ObjRawSet(Obj, IShellItem, PIDL), ObjPush(Result, StrGet(&Buffer, "UTF-16"))
        }

        ObjRelease(IShellItemArray)
    }


    for foo, bar in Obj    ; foo = IShellItem interface (ptr)  |  bar = PIDL structure (ptr)
        if foo is integer    ; IShellItem?
            ObjRelease(foo), DllCall("Ole32.dll\CoTaskMemFree", "UPtr", bar)
    ObjRelease(IFileOpenDialog)

    return ObjLength(Result) ? (Options & 0x200 ? Result : Result[1]) : FALSE
}

DirExist(DirName)
{
    loop Files, % DirName, D
        return A_LoopFileAttrib
}
StrPutVar(string, ByRef var, encoding)
{
    ; Ensure capacity.
    VarSetCapacity( var, StrPut(string, encoding)
        ; StrPut returns char count, but VarSetCapacity needs bytes.
        * ((encoding="utf-16"||encoding="cp1200") ? 2 : 1) )
    ; Copy or convert the string.
    return StrPut(string, &var, encoding)
} ; https://www.autohotkey.com/docs/commands/StrPut.htm#Examples
;}============================================================================================

/*
 * ======================================================================================================================================================
	cInputBox - Custom input box that can be use to capture input or passwords
	Params:
		title = The title to be displayed on the input box
		text = The text to be displayed above the input box
		InputValue = Optional - The inital value of the Inputbox
		owner = Optional - If 0, this will be a standalone dialog. If you want this dialog to be owned by another GUI, place its number here.
		isPassword = Optional - If non-zero or true then the input box will use password masking
	Usage:
		InputReslut := cInputBox("The title", "The Text", "secret",,1)
		if (InputReslut) {
			MsgBox, 64, Result Found, The result from the custom input box is: %InputReslut%
		} else {
			MsgBox, 16, Result Error, The was no result returned from the custom input box
		}
	Other Notes:
		The GuiID should be sufficent for most uses. If however it conflicts then you will need to change it in three places
			GuiID := (New ID number) - found in the second line of the cInpuBox functon
			(New ID number)GuiEscape: - Found just below cInputBox function
			(New ID number)GuiClose: - Found just below cInputBox function
 * ======================================================================================================================================================
 */
cInputBox(title, text, inputValue = "", owner=0,isPassword=0){
	Global _CInput_Result, _cInput_Value
	GuiID := 8      ; If you change, also change the subroutines below for #GuiEscape & #GuiClose
	If( owner <> 0 ) {
		Gui %owner%:+Disabled
		Gui %GuiID%:+Owner%owner%
	}

	Gui, %GuiID%:Add, Text, x12 y10 w320 h30 , %text%
	Gui, %GuiID%:Add, Edit, % "x12 y40 w320 h20 -VScroll v_cInput_Value" . ((isPassword <> 0) ? " Password":""), %inputValue%
	Gui, %GuiID%:Add, Button, x232 y70 w100 h30 gCInputButton, % "Cancel"
	Gui, %GuiID%:Add, Button, x122 y70 w100 h30 gCInputButton Default, % "OK"
	Gui, %GuiID%:+Toolwindow +AlwaysOnTop
	Gui %GuiID%:Show,,%title%

	Loop
		If( _CInput_Result )
			Break

	If( owner <> 0 )
		Gui %owner%:-Disabled
	Gui, %GuiID%:Submit, Hide

	if (_CInput_Result = "OK"){
		Result := _cInput_Value
	} else {
		Result := ""
	}
	_cInput_Value := ""
	_CInput_Result := ""
	Gui %GuiID%:Destroy
  	Return Result
}

8GuiEscape:
8GuiClose:
  _CInput_Result := "Close"
Return

CInputButton:
  StringReplace _CInput_Result, A_GuiControl, &,, All
Return





; Snaptoedge(MovePos,offsetX:=0,offsetY:=0) {

;     activeMon := GetMonitorIndexFromWindow(my_id)
;     SysGet, MonitorWorkArea, MonitorWorkArea, %activeMon%
;     WinGetPos , X, Y, Width, Height, ahk_id %my_id%
;     ; MonitorWorkAreaLeft
;     ; MonitorWorkAreaRight
;     ; MonitorWorkAreaBottom
;     ; MonitorWorkAreaTop
;     if (MovePos="BR") {
;         PosX:= MonitorWorkAreaRight-Width-offsetX
;         , PosY:= MonitorWorkAreaBottom-Height-offsetY
;     }
;     Else if (MovePos="BL") {
;  PosX:=MonitorWorkAreaLeft + offsetX
;  , PosY:= MonitorWorkAreaBottom-Height - offsetY
;     }
;     Else if (MovePos="TL") {
;         PosX:=MonitorWorkAreaLeft + offsetX
;         , PosY:=MonitorWorkAreaTop + offsetY
;     }
;     Else if (MovePos="TR") {
;         PosX:=MonitorWorkAreaRight-Width - offsetX
;         , PosY:=MonitorWorkAreaTop + offsetY
;     }
;     Else if (MovePos="MR") {
;         PosX:=MonitorWorkAreaRight-Width - offsetX
;         , PosY:=(MonitorWorkAreaBottom//2) - (Height//2) + offsetY
;     }
;     Else
;     {
;          PosX:=(MonitorWorkAreaRight//2) - (Width//2)
;         , PosY:=(MonitorWorkAreaBottom//2) - (Height//2)
;     }
	
;     WinMove,ahk_id %my_id%,,%posX%,%posY% ;,%width%,%height%
; }



; ################################################################################################
;(@-1)[Approach1 through Onmessage and postmessage]{==============================================

Receive_WM_COPYDATA(wParam, lParam)
{
    StringAddress := NumGet(lParam + 2*A_PtrSize)  ; Retrieves the CopyDataStruct's lpData member.
   Global RecievedFilePath := StrGet(StringAddress)  ; Copy the string out of the structure.
    settimer,LaunchRecievedFilePath, 2
    return true  ; Returning 1 (true) is the traditional way to acknowledge this message.
}

;(@-2)[ Approch 2 through read and write through ini and 2nd thread ] { ===========================

; RecieverFunction(FilePath){
; Global RecievedFilePath := FilePath
; Gosub, LaunchRecievedFilePath
; }
                                       ; -----> see starting of the code to enable 2nd thread
;}==================================================================================================
;###################################################################################################

;[Anchortoedge] ====================================================================================
; Author ananthuthilakan
; Website ananthuthilakan.com 
; How to use 
; make your gui id available at my_id as global variable
; the call this function when you move your gui either through onmessage or through any label
;===================================================================================================


Anchortoedge(Ignore_Taskbar) {
    
    activeMon := GetMonitorIndexFromWindow(my_id)  ; credits unknkown
    SysGet, MonitorWorkArea, MonitorWorkArea, %activeMon%
    SysGet, Monitor, Monitor, %activeMon%
    WinGetPos , X, Y, Width, Height, ahk_id %my_id%
    ; MonitorWorkAreaLeft
    ; MonitorWorkAreaRight
    ; MonitorWorkAreaBottom
    ; MonitorWorkAreaTop
    if (Ignore_Taskbar){
    if ((X+Width)> MonitorRight) || (((X+Width)<(MonitorRight-20)) && ((X+Width)>(MonitorRight-50))) {
    posX:=MonitorRight-Width
    }
    Else if (X<MonitorLeft) {
    posX:=MonitorLeft
    }
    if ((Y+Height)>MonitorBottom) || (((Y+Height)<MonitorBottom-15) && ((Y+Height)>MonitorBottom-50)){
        PosY:= MonitorBottom-Height
    }
    Else if (Y<MonitorTop){
        PosY:= MonitorTop
    }
    }
    Else {
    if ((X+Width)> MonitorWorkAreaRight) || (((X+Width)<(MonitorWorkAreaRight-20)) && ((X+Width)>(MonitorWorkAreaRight-50))) {
    posX:=MonitorWorkAreaRight-Width
    }
    Else if (X<MonitorWorkAreaLeft) {
    posX:=MonitorWorkAreaLeft
    }
    if ((Y+Height)>MonitorWorkAreaBottom) || (((Y+Height)<MonitorWorkAreaBottom-15) && ((Y+Height)>MonitorWorkAreaBottom-50)) { 
        PosY:= MonitorWorkAreaBottom-Height
    }
    Else if (Y<MonitorWorkAreaTop){
        PosY:= MonitorWorkAreaTop
    }
    }
    WinMove,ahk_id %my_id%,,%posX%,%posY% 
}


GetMonitorIndexFromWindow(windowHandle) {
    ; Starts with 1.
    monitorIndex := 1

    VarSetCapacity(monitorInfo, 40)
    NumPut(40, monitorInfo)

    if (monitorHandle := DllCall("MonitorFromWindow", "uint", windowHandle, "uint", 0x2))
        && DllCall("GetMonitorInfo", "uint", monitorHandle, "uint", &monitorInfo) {
        monitorLeft   := NumGet(monitorInfo,  4, "Int")
        monitorTop    := NumGet(monitorInfo,  8, "Int")
        monitorRight  := NumGet(monitorInfo, 12, "Int")
        monitorBottom := NumGet(monitorInfo, 16, "Int")
        workLeft      := NumGet(monitorInfo, 20, "Int")
        workTop       := NumGet(monitorInfo, 24, "Int")
        workRight     := NumGet(monitorInfo, 28, "Int")
        workBottom    := NumGet(monitorInfo, 32, "Int")
        isPrimary     := NumGet(monitorInfo, 36, "Int") & 1

        SysGet, monitorCount, MonitorCount

        Loop, %monitorCount% {
            SysGet, tempMon, Monitor, %A_Index%

            ; Compare location to determine the monitor index.
            if ((monitorLeft = tempMonLeft) and (monitorTop = tempMonTop)
                and (monitorRight = tempMonRight) and (monitorBottom = tempMonBottom)) {
                monitorIndex := A_Index
                break
            }
        }
    }

    return %monitorIndex%
}

; :://o::
; Gosub, lbl_Open_Files
; return


; :://ol::
; RecievedName:="Unknown"
; msgbox,% linkopen := cInputBox("Open Link", "Enter a valid link","Link" ,1,0)
;    temp:="file:" . RecievedUrl
;     temp:= FileURL(temp)
;     SplitPath, temp, OutFileNamet, OutDirt, OutExtensiont, OutNameNoExtt, OutDrivet
;    if OutExtensiont in %allowedextensions%
;             {
;                 RecievedName:=OutNameNoExtt

;             }
    
;     ; RecievedUrl:=
;     temparr:={"Name":"dummyName","Url":"dummyurl","timelastleft":"0"}
;                 , temparr.Name:=RecievedName
;                 , temparr.Url:=FileURL(RecievedUrl)
;                 , temparr.timelastleft:= RecievedTime
;                 , PlaylistLoad[1]:=temparr
;                 , temparr:=""
; ; msgbox,% FileURL(RecievedUrl)

;     GoSub, lbl_play_with_vlc

; return



 
lbl_Open_Playlist:
OutputDebug,% "`n" A_ThisLabel " | "
{

    
    Result := ChooseFile( [0, "Select the playlist to open..."]
                        , A_MyDocuments . "\VlcNotes\SavedPlaylist\SingleMediaPlaylist.plvlc"
                        , {Playlist: "*.plvlc"}
                        , 
                        , 0x00001000 | 0x00040000)
    If (Result != FALSE) {
        PlaylistLoad:={}
        ; msgbox, % result
        SplitPath, result, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
        if (OutExtension="plvlc") 
        {
            IniRead, lastplayedItem, %result%, SavedPlaylist, lastplayedItem,1
            IniRead, PlaylistLoad,  %result%, SavedPlaylist, SavedPlaylist,0
   
            try
            {
            PlaylistLoad:=JSON.Load(PlaylistLoad)
            ; msgbox, % PlaylistLoad.1.name
            PlaylistNameNowPlaying:=OutNameNoExt
            item:=lastplayedItem
            RecentFolder:= (RegExMatch(PlaylistLoad[1].url, "i)^[a-z]\:")) ? PlaylistLoad[1].url : Default_media_Directory
            GoSub, lbl_play_with_vlc
            }
            Catch, e
            {
            Gui +OwnDialogs
            MsgBox 0x30, file not  readable, file not readable...
            }
        }
        Else
        {
            Gui +OwnDialogs
            MsgBox 0x30, Not supported, Non supported file type`ntry another one....
            Gosub, lbl_Open_Playlist
        }
    
    }
}
Return



; GuiDropFiles:
; MsgBox, % A_GuiEvent
; ; Loop, Files, %A_GuiEvent%\*.*, FD  ; Include Files and Directories
; ; MsgBox, % A_loopfilename
; return




Terminatelbl(){
    OutputDebug,% "`n" A_ThisFunc " | "
    ExitApp
    }

SettingShow:
gui,SettingsGUI: Show
return

Reloadlbl:
OutputDebug,% "`n" A_ThisLabel " | "
Reload
return




; lbl_Forward:
; OutputDebug,% "`n" A_ThisLabel " | "
; return

; lbl_Backward:
; OutputDebug,% "`n" A_ThisLabel  " | "
; return

; lbl_Speed_Increase:
; OutputDebug,% "`n" A_ThisLabel " | "
; return

; lbl_Speed_Decrease:
; OutputDebug,% "`n" A_ThisLabel " | "
; return

; lbl_Volume_Increase:
; OutputDebug,% "`n" A_ThisLabel " | "
; return

; lbl_Volume_Decrease:
; OutputDebug,% "`n" A_ThisLabel " | "
; return

; lbl_Overlay_Brightness_Increase:
; OutputDebug,% "`n" A_ThisLabel " | "
; return

; lbl_Overlay_Brightness_Decrease:
; OutputDebug,% "`n" A_ThisLabel " | "
; return

; lbl_Window_Size_Increase:
; OutputDebug,% "`n" A_ThisLabel " | "
; return

; lbl_Window_Size_Decrease:
; OutputDebug,% "`n" A_ThisLabel " | "
; return

; lbl_Insert_Time_Stamp:
; OutputDebug,% "`n" A_ThisLabel " | "
; return

; lbl_Insert_Screenshot:
; OutputDebug,% "`n" A_ThisLabel " | "
; return

; lbl_Insert_Link:
; OutputDebug,% "`n" A_ThisLabel " | "
; return

; lbl_Insert_Title:
; OutputDebug,% "`n" A_ThisLabel " | "
; return

; fn_Hold_Down_For_Drag_and_Drop_UI(state)
; {
;     static n
;     OutputDebug,% "`n" A_ThisFunc " | "
;     if (state) {
;     tempnum++
;     (tempnum=1) ? DragnDropShow()
;     }
;     Else
;     {
;     DragnDropHide()
;     }
; }




 DragnDropGet(url:="")
    {
      static goturl
      if (url){
        goturl:=url
        Gosub, OpenDropedLink
      }
      Else
        {
        return goturl
        }
    }


; ^!L::
; :://ol::
; RecievedFilePath := cInputBox("Open Link", "Enter a valid link","Link" ,1,0)

OpenDropedLink:
RecievedFilePath := DragnDropGet()
LaunchDropedFIles:
SplitPath, RecievedFilePath, OutFileNamet, OutDirt, OutExtensiont, OutNameNoExtt, OutDrivet
OutputDebug, % "OutFileNamet => " OutFileNamet "`n" "OutDirt =>" OutDirt "`n" "OutExtensiont =>" OutExtensiont "`n" "OutNameNoExtt =>" OutNameNoExtt "`n" "OutDrivet =>" OutDrivet
{
    PlaylistLoad:={}, item:=1
    ; msgbox, % RecievedFilePath
    arrtemp:=""
    Urltemp:= RecievedFilePath
    if (InStr(Urltemp, "-~-")) && (InStr(Urltemp, "VlcNotes:")) {          ; just to be sure it wont break any urls delimiter chosen is -~-
                                        ; Hope it wont break any random urls from internets
    arrtemp:=StrSplit(Urltemp,"-~-"," `t", 3)
    RecievedName:=arrtemp.1
    , RecievedTime:=arrtemp.2
    , RecievedUrl:=arrtemp.3
    }
    Else
    {
        ; 1. https
        ; 2. file
        ; msgbox, % UserVariables.n["Head_start_media"]
        RecievedName:="Unknown"
        , RecievedTime:=UserVariables.n["Head_start_media"]*1000
        , RecievedUrl:=RecievedFilePath
      
        temp:="file:" . RecievedUrl
        temp:= FileURL(temp)
        SplitPath, temp, OutFileNamet, OutDirt, OutExtensiont, OutNameNoExtt, OutDrivet
       if OutExtensiont in %allowedextensions%
                {
                    RecievedName:=OutNameNoExtt
    
                }
            if (!OutExtensiont) && (FileExist(RecievedUrl))
                {
                    PlaylistLoad:={}, item:=1 , n:=0 , list:=""
                    ; msgbox,% RecievedUrl
                    Loop Files, %RecievedUrl%\* ; , R  ; Recurse into subfolders.
                        {
                            ; Result:={}
                            ; Result[%A_Index%] := A_LoopFileFullPath
                             List .= A_LoopFileFullPath "`n"
                        }
                        Sort, List, F SortListByName
                        Loop, parse, List, `n
                            {
                                if (A_LoopField = "")  ; Ignore the blank item at the end of the list.
                                    continue
                                SplitPath, A_LoopField, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
                                if OutExtension in %allowedextensions%
                                {
                                    n++
                                    temparr:={"Name":"dummyName","Url":"dummyurl","timelastleft":"0"}
                                    , temparr.Name:=OutNameNoExt
                                    , temparr.Url:=A_LoopField
                                    , PlaylistLoad[n]:=temparr
                                    , temparr:=""
                    
                                }
                            }
                        n:=0 , list:=""
                        Goto, lbl_Saveplaylist
                        return
                   
                }

    }
    ; RecievedUrl:=
    temparr:={"Name":"dummyName","Url":"dummyurl","timelastleft":"0"}
                , temparr.Name:=RecievedName
                , temparr.Url:=RecievedUrl
                ; , temparr.Url:=FileURL(RecievedUrl)
                , temparr.timelastleft:= RecievedTime
                , PlaylistLoad[1]:=temparr
                ; msgbox,% temparr.Url
                temparr:=""
; msgbox,% FileURL(RecievedUrl)
if (prevRecievedUrl!=RecievedUrl) {
    GoSub, lbl_play_with_vlc
    }
    Else 
    {
    if (RecievedTime)
    vlc.input.time:=RecievedTime  
    }
   prevRecievedUrl:=RecievedUrl
   

}

return





LaunchRecievedFilePath:
; msgbox, this is 2 
settimer,LaunchRecievedFilePath, off
{
    PlaylistLoad:={}, item:=1
    ; msgbox, % RecievedFilePath
    arrtemp:=""
    Urltemp:= RecievedFilePath
    if InStr(Urltemp, "-~-") {          ; just to be sure it wont break any urls delimiter chosen is -~-
                                        ; Hope it wont break any random urls from internets
    arrtemp:=StrSplit(Urltemp,"-~-"," `t", 3)
    RecievedName:=arrtemp.1
    , RecievedTime:=arrtemp.2
    , RecievedUrl:=arrtemp.3
    }
    Else
    {
    RecievedName:="Unknown"
    , RecievedTime:=UserVariables.n["Head_start_media"]*1000
    , RecievedUrl:=RecievedFilePath
    temp:="file:" . RecievedUrl
    temp:= FileURL(temp)
    SplitPath, temp, OutFileNamet, OutDirt, OutExtensiont, OutNameNoExtt, OutDrivet
   if OutExtensiont in %allowedextensions%
            {
                RecievedName:=OutNameNoExtt

            }
    }
    ; RecievedUrl:=
    temparr:={"Name":"dummyName","Url":"dummyurl","timelastleft":"0"}
                , temparr.Name:=RecievedName
                , temparr.Url:=FileURL(RecievedUrl)
                , temparr.timelastleft:= RecievedTime
                , PlaylistLoad[1]:=temparr
                , temparr:=""
; msgbox,% FileURL(RecievedUrl)
if (prevRecievedUrl!=RecievedUrl) {
    GoSub, lbl_play_with_vlc
    }
    Else 
    {
    if (RecievedTime)
    vlc.input.time:=RecievedTime  
    }
   prevRecievedUrl:=RecievedUrl
   

}

return

IE_BeforeNavigate2(p*) {
    NumPut(true, ComObjValue(p.7))
    DragnDropGet(p.2)
    vlc.input.time:=UserVariables.n["Head_start_media"]*1000
    Gosub, lbl_Hold_Down_For_Drag_and_Drop_UI_Up
  ;   if (IsFunc("DragnDropRecieve")){
  ;     DragnDropRecieve(p.2)
  ;   }
  }

  



;   m::
;   GuiControl, Hide , vlc
;   GuiControl, show , wb
;   keywait, m
;   GuiControl, Show , vlc
;   GuiControl, Hide , wb
;   return

lbl_Hold_Down_For_Drag_and_Drop_UI:
OutputDebug,% "`n" A_ThisLabel " | " 
tempnum++
if (tempnum=1){
GuiControl, Hide , vlc
GuiControl, show , wb
}
sleep, 20
return

lbl_Hold_Down_For_Drag_and_Drop_UI_Up:
tempnum:=0
GuiControl, Show , vlc
GuiControl, Hide , wb
return

lbl_Hold_Down_For_Mouse_Gesture:
return
OutputDebug,% "`n" A_ThisLabel " | " A_ThisHotkey
    gesture := MouseGesture()
    if (gesture="U")
    Gosub, lbl_Volume_Increase
    Else if (gesture="D")
    Gosub, lbl_Volume_Decrease
    Else if (gesture="L")
    Gosub, lbl_Backward
    Else if (gesture="R")
    gosub, lbl_Forward
    Else  
    {
    sleep, 300
    Gosub, overlayreturn
    }
    gosub, TimerMain
    Sleep 150

Return


~#Alt::
if (Mouse_Gesture:=1){
gesture := MouseGesture()
if (gesture="U")
Gosub, lbl_Volume_Increase
Else if (gesture="D")
Gosub, lbl_Volume_Decrease
Else if (gesture="L")
Gosub, lbl_Backward
Else if (gesture="R")
gosub, lbl_Forward
Else  
{
    ; sleep, 300
    settimer, overlayreturn, 500
}
gosub, TimerMain
Sleep 150
}
return



; ~LWin Up::
; ~Alt Up::
; ~#Alt Up::
lbl_Forward_Up:
lbl_Backward_Up:
lbl_Speed_Increase_Up:
lbl_Speed_Decrease_Up:
lbl_Volume_Increase_Up:
lbl_Volume_Decrease_Up:
OutputDebug,% "`n" A_ThisLabel  " | "
settimer, overlayreturn, 500
return






default_directory_screenshots_fn(ctrlID, value){
    
    ; msgbox, % ctrlID " " value
    global default_directory_screenshots
    default_directory_screenshots:= value
}

pinnedfolder_fn(ctrlID, value)
{
    ; msgbox, % ctrlID " " value
    if (value)
    PinnedFolders[SubStr(ctrlID, StrLen("PNfldr_")+1)]:= value
}


SelectScreenShotSavelbl:
Gui +OwnDialogs
MsgBox 0x40, where you want to save screenshot ?, Choose a location !`nideally its better choose your note taking apps assets folder such that inserting wiki links works.`n`nfor e.g. `n`nobsidian asset folder   
prev_default_directory_screenshots:=default_directory_screenshots
FileSelectFolder, default_directory_screenshots, ::{20d04fe0-3aea-1069-a2d8-08002b30309d}
; MsgBox, % default_directory_screenshots
if (!default_directory_screenshots)
default_directory_screenshots:=prev_default_directory_screenshots
GuiControl,SettingsGUI: , default_directory_screenshots_var, % default_directory_screenshots
return

lblPinnedFolder_1:
lblPinnedFolder_2:
lblPinnedFolder_3:
FileSelectFolder, temppinnedfolder, ::{20d04fe0-3aea-1069-a2d8-08002b30309d}
temp:=SubStr(A_ThisLabel, StrLen("lblPinnedFolder_")+1)
if (temppinnedfolder)
PinnedFolders[temp]:= temppinnedfolder
GuiControl,SettingsGUI: , PinnedFolders_%temp%, % PinnedFolders[temp]
temp:="" , temppinnedfolder:=""
; msgbox, % SubStr(A_ThisLabel, StrLen("lblPinnedFolder_")+1) " | " PinnedFolders[SubStr(A_ThisLabel, StrLen("lblPinnedFolder_")+1)]
return







UpdateYtdlp:
; DownloadFile("https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe", "yt-dlp.exe",1,1)
try
UrlDownloadToFile, https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe, yt-dlp.exe
reload
return

ManuallyUpdateYtdlp:
try {
    run, % A_WorkingDir
    run, https://github.com/yt-dlp/yt-dlp/releases
    MsgBox 0x40020, Download, Download yt-dlp.exe and place it in here `n "myDocuments\VlcNotes\"
}
return

#If (WinActive("ahk_class VLC ActiveX Fullscreen Class")) && (UserVariables.b["If_Fullscreen_Enable_Default_VLC_Hotkeys"])

~Space::
OutputDebug, % A_ThisHotkey
vlc.playlist.togglePause()
return

~Right::
OutputDebug, % A_ThisHotkey
vlc.input.time+= 10*1000
return

~Left::
OutputDebug, % A_ThisHotkey
vlc.input.time-= 10*1000
return

~+Right::
OutputDebug, % A_ThisHotkey
vlc.input.time+= 4*1000
return

~+Left::
OutputDebug, % A_ThisHotkey
vlc.input.time-= 4*1000
return

~^Right::
OutputDebug, % A_ThisHotkey
vlc.input.time+= 60*1000
return

~^Left::
OutputDebug, % A_ThisHotkey
vlc.input.time-= 60*1000
return

~WheelUp::
if (vlc.audio.volume<200)
vlc.audio.volume += 5
return

~WheelDown::
if (vlc.audio.volume>0)
vlc.audio.volume -= 5
Return


#If


lbl_Ignore_Taskbar:
Anchortoedge(UserVariables.b["Ignore_Taskbar"]) 
return
lbl_insert_directlink_also:
lbl_If_Fullscreen_Enable_Default_Vlc_Hotkeys:
return


lbl_Hide_TaskBar_icon:
if (UserVariables.b["Hide_TaskBar_icon"])
Gui,1: +ToolWindow
Else
Gui,1: -ToolWindow
return

lbl_Seektime:
lbl_Head_start_media:
lbl_VolumeChangeStep:
lbl_default_screen_shot_width:
return

lbl_vlc_Marquee_text_size:
vlc.video.marquee.size:= UserVariables.n["vlc_Marquee_text_size"]
return




picture_pulsing_timer:
loop, 3
    {
loop, 10
    {
        GuiControl,, Picture1, %A_ScriptDir%\assets\skbfklsfkionu_%A_Index%.png
        Sleep 50
    }
    loop, 10
        {
            tn:=11-A_Index
            GuiControl,, Picture1, %A_ScriptDir%\assets\skbfklsfkionu_%tn%.png
            Sleep 50
        }
    ; GuiControl,, Picture1, skbfklsfkionu_1.png
    }
; GuiControl,, Picture1, love_1.png
return

; 3fe4a45549324ba2f97b6847f124feddMtjz6o2ua7JjFN8M-0.png

; lbl_th_fr_cfe:
; Run, https://google.com/
; return
