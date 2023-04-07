


/*

; Created by ananthuthilakan
; Discord discretecourage#0179
; Website ananthuthilakan.com
; Credits Appfactory

*/

SettingsGUI(HotkeyNames,GuiName:="SettingsGUI",EnableHotstring:=0,VerticalScroll:=0,UserVariableTab:=0,BooleanTab:=0,Changelog:=0){
Static temp_n_var_names:=[] , temp_b_var_names:=[] , temp_t_var_names:=[] , temp_p_var_names:=[]
tabNames:= "MainSettings"
s:=StrSplit(tabNames,"|").MaxIndex()
loop, % (VerticalScroll=1) ? 1 : Ceil(HotkeyNames.MaxIndex()/12)
tabNames.="|Hotkeys"

su:=StrSplit(tabNames,"|").MaxIndex()
if (UserVariableTab)
tabNames.="|User Variables"
sb:=StrSplit(tabNames,"|").MaxIndex()
if (BooleanTab)
tabNames.="|Booleans"
tabNames.="|ChangeLog|About" 
; Gui,%GuiName%:  color,cE6F5D9,cE6F5D9
if (VerticalScroll=1)
Gui,%GuiName%: +0x200000  +Resize +MinSize900x540 +MaxSize900 ; +AlwaysOnTop
%GuiName%_factory := new AppFactory(GuiName)
Gui,%GuiName%: Font, s20, Arial
Gui,%GuiName%: Add, Text, x0 y-0 w904 h44 +0x200 +Center BackgroundTrans, Settings
Gui,%GuiName%: Font, s10
Gui,%GuiName%: Add, Tab3, x-2 y42 w915  , % tabNames
Loop, % (VerticalScroll=1) ? 1 : Ceil(HotkeyNames.MaxIndex()/12)
{
Gui,%GuiName%: Tab, % " " A_Index + s
Gui,%GuiName%: Font, s12
if (EnableHotstring=1)
Gui,%GuiName%: Add, Progress, xm y73 w854 h32 BackgroundBABABA
Else
{
Gui,%GuiName%: Margin , 75
Gui,%GuiName%: Add, Progress, xm y73 w752 h32 BackgroundBABABA
}
Gui,%GuiName%: Add, Text, xm y73 w368 h32  +Center +0x200 +Border BackgroundTrans, Actions
Gui,%GuiName%: Add, Text, x+2 y73 w190 h32 +Center +0x200 +Border BackgroundTrans, Hotkeys
Gui,%GuiName%: Add, Text, x+2 y73 w190 h32 +Center +0x200 +Border BackgroundTrans, Hotkeys
if (EnableHotstring=1)
Gui,%GuiName%: Add, Text, x+2 y73 w100 h32 +Center +0x200 +Border BackgroundTrans, HotStrings
t:=((Ceil(HotkeyNames.MaxIndex()/12))>A_Index) ? 12 : (HotkeyNames.MaxIndex()-(12*(A_index-1)))
loop,% (VerticalScroll=1) ?  HotkeyNames.MaxIndex() : t
{
n++
Gui,%GuiName%: Add, Text, xm y+1 w368 h32 +0x200  +Border  +Center, % " " HotkeyNames[n]
%GuiName%_factory.AddInputButton("HK1_" . HotkeyNames[n], "x+2 yp w190 h34 ", Func("Hkey_jhfkllsd").Bind("HK1_" . HotkeyNames[n]))
%GuiName%_factory.AddInputButton("HK2_" . HotkeyNames[n], "x+2 yp w190 h34", Func("Hkey_jhfkllsd").Bind("HK2_" . HotkeyNames[n]))
if (EnableHotstring=1)
%GuiName%_factory.AddControl("HS1_" . HotkeyNames[n], "Edit", "x+2 yp w100 h34",,Func("HSstring_uytui").Bind("HS1_" . HotkeyNames[n]))
}
}
Gui,%GuiName%: Margin , 20
if (UserVariableTab) {
    n:=0
For UV, value in UserVariables.n
    {
        ; msgbox, % UV
        temp_n_var_names[A_Index] := UV
    }
For UV, value in UserVariables.t
        {
            ; msgbox, % UV
            temp_t_var_names[A_Index] := UV
        }
 For UV, value in UserVariables.p
     {
                ; msgbox, % UV
                temp_p_var_names[A_Index] := UV
    }
Loop, % (VerticalScroll=1) ? 1 : Ceil((temp_n_var_names.MaxIndex() + temp_t_var_names.MaxIndex() + temp_p_var_names.MaxIndex())/12)
    {
        Gui,%GuiName%: Tab, % " " A_Index + su
        Gui,%GuiName%: Font, s12
        
        Gui,%GuiName%: Add, Progress, xm y73 w854 h32 BackgroundBABABA
       
        Gui,%GuiName%: Add, Text, xm y73 w568 h32  +Center +0x200 +Border BackgroundTrans, User Variables
        Gui,%GuiName%: Add, Text, x+2 y73 w284 h32 +Center +0x200 +Border BackgroundTrans, Number Box
       
        t:=((Ceil(temp_n_var_names.MaxIndex()/12))>A_Index) ? 12 : (temp_n_var_names.MaxIndex()-(12*(A_index-1)))
        loop,% (VerticalScroll=1) ?  temp_n_var_names.MaxIndex() : t
        {
        n++
        Gui,%GuiName%: Add, Text, xm y+1 w568 h32 +0x200  +Border  +Center, % " " temp_n_var_names[n]
        ; %GuiName%_factory.AddControl("UV1_" . temp_n_var_names[n], "Edit", "x+2 yp w284 h34 ",,Func("USR_VarFn_fiowuebfi").Bind("UV1_" . temp_n_var_names[n]))
        Gui,%GuiName%: Add, Text, x+1 yp w286 h32 +0x200  +Border  +Center, ; % " " temp_n_var_names[n]
        %GuiName%_factory.AddControl("UV1_" . temp_n_var_names[n], "UpDown", "xp yp w286 h34 Range0-1000",,Func("USR_VarFn_fiowuebfi").Bind("UV1_" . temp_n_var_names[n]))
       
        }
        n:=0

        if (temp_t_var_names.MaxIndex()) {

        Gui,%GuiName%: Add, Progress, xm y+20 w854 h32 BackgroundBABABA
       
        Gui,%GuiName%: Add, Text, xm yp w568 h32  +Center +0x200 +Border BackgroundTrans, User Variables
        Gui,%GuiName%: Add, Text, x+2 yp w284 h32 +Center +0x200 +Border BackgroundTrans, Edit Box
        }
       
        t:=((Ceil(temp_t_var_names.MaxIndex()/12))>A_Index) ? 12 : (temp_t_var_names.MaxIndex()-(12*(A_index-1)))
        
        loop,% (VerticalScroll=1) ?  temp_t_var_names.MaxIndex() : t
        {
        n++
        Gui,%GuiName%: Add, Text, xm y+1 w568 h32 +0x200  +Border  +Center, % " " temp_t_var_names[n]
        ; %GuiName%_factory.AddControl("UV1_" . temp_n_var_names[n], "Edit", "x+2 yp w284 h34 ",,Func("USR_VarFn_fiowuebfi").Bind("UV1_" . temp_n_var_names[n]))
        Gui,%GuiName%: Add, Text, x+1 yp w286 h32 +0x200  +Border  +Center, ; % " " temp_n_var_names[n]
        %GuiName%_factory.AddControl("UV1_" . temp_t_var_names[n], "Edit", "xp yp w286 h34 ",,Func("USR_EditFn_fiowuebfi").Bind("UV1_" . temp_t_var_names[n]))
       
        }

        n:=0

        if (temp_p_var_names.MaxIndex()) {
        Gui,%GuiName%: Add, Progress, xm y+20 w854 h32 BackgroundBABABA
       
        Gui,%GuiName%: Add, Text, xm yp w368 h32  +Center +0x200 +Border BackgroundTrans, User Variables
        Gui,%GuiName%: Add, Text, x+2 yp w484 h32 +Center +0x200 +Border BackgroundTrans, Passwords / Api keys
        }
        t:=((Ceil(temp_p_var_names.MaxIndex()/12))>A_Index) ? 12 : (temp_p_var_names.MaxIndex()-(12*(A_index-1)))
        
        loop,% (VerticalScroll=1) ?  temp_p_var_names.MaxIndex() : t
        {
        n++
        Gui,%GuiName%: Add, Text, xm y+1 w368 h32 +0x200  +Border  +Center, % " " temp_p_var_names[n]
        ; %GuiName%_factory.AddControl("UV1_" . temp_n_var_names[n], "Edit", "x+2 yp w284 h34 ",,Func("USR_VarFn_fiowuebfi").Bind("UV1_" . temp_n_var_names[n]))
        Gui,%GuiName%: Add, Text, x+1 yp w486 h32 +0x200  +Border  +Center, ; % " " temp_n_var_names[n]
        %GuiName%_factory.AddControl("UV1_" . temp_p_var_names[n], "Edit", "xp yp w486 h34 password",,Func("USR_pFn_flgndsjd").Bind("UV1_" . temp_p_var_names[n]))
       
        }
        n:=0


    }
}
if (BooleanTab) {
n:=0
For UBdklfre, value in UserVariables.b
    {
        ; msgbox, % UBdklfre
        temp_b_var_names[A_Index] := UBdklfre
    }
    Loop, % (VerticalScroll=1) ? 1 : Ceil(temp_b_var_names.MaxIndex()/12)
        {
            Gui,%GuiName%: Tab, % " " A_Index + sb
            Gui,%GuiName%: Font, s12
            
            Gui,%GuiName%: Add, Progress, xm y73 w854 h32 BackgroundBABABA
           
            Gui,%GuiName%: Add, Text, xm y73 w854 h32  +Center +0x200 +Border BackgroundTrans, User Booleans
            ; Gui,%GuiName%: Add, Text, x+2 y73 w284 h32 +Center +0x200 +Border BackgroundTrans, Number Box
           
            t:=((Ceil(temp_b_var_names.MaxIndex()/12))>A_Index) ? 12 : (temp_b_var_names.MaxIndex()-(12*(A_index-1)))
            loop,% (VerticalScroll=1) ?  temp_b_var_names.MaxIndex() : t
            {
            n++
            ; Gui,%GuiName%: Add, Text, xm y+3 w854 h32 +0x200  +Border  +Center, ; % " " temp_b_var_names[n]
            ; %GuiName%_factory.AddControl("UB1_" . temp_b_var_names[n], "Edit", "x+2 yp w284 h34 ",,Func("USR_VarFn_fiowuebfi").Bind("UB1_" . temp_b_var_names[n]))
            ; Gui,%GuiName%: Add, Text, x+1 yp w286 h32 +0x200  +Border  +Center, ; % " " temp_b_var_names[n]
            %GuiName%_factory.AddControl("UB1_" . temp_b_var_names[n], "CheckBox", "xm+30 y+1 w814 h30   ","  " temp_b_var_names[n],Func("USR_BoolFn_dsfsdfbf").Bind("UB1_" . temp_b_var_names[n]))
           
            }
            n:=0
        }
    }
Gui,%GuiName%: Margin 
Gui,%GuiName%: Tab, 6 ; About Section
Gui,%GuiName%: Add, Progress, xm+50 y100 w754 h32 BackgroundBABABA         
Gui,%GuiName%: Add, Text, xm+50 yp w754 h32  +Center +0x200 +Border BackgroundTrans, Thankyou for finding this tool usefull 
Gui,%GuiName%: Add, Button, xp y+10 w100 h32  +Center glbl_yt, Youtube ▶️
Gui,%GuiName%: Add, Button, x+20 yp w100 h32  +Center glbl_insta, Instagram 🥰
Gui,%GuiName%: Add, Button, x+20 yp w150 h32  +Center glbl_th_fr_cfe, Buy Me Coffee 🤑
; UpdateHS_sdfkjhsakoew(1)
Gui,%GuiName%: Add, Edit, xm+50 yp+120 w754 h32  +Center +0x200 +Border BackgroundTrans disabled r8,% credits
Gui,%GuiName%: Add, Text, xm y+20 w854 h50  +Center +0x200 +Border BackgroundTrans r2, Disclaimer : this application is meant purely for educational purpose and `n to avoid distraction while studying.

Gui,%GuiName%: Tab, 5
Gui,%GuiName%: Add, Progress, xm+50 y100 w754 h32 BackgroundBABABA         
Gui,%GuiName%: Add, Text, xm+50 yp w754 h32  +Center +0x200 +Border BackgroundTrans, ChangeLog
Gui,%GuiName%: Add, Edit, xm+50 y+5  w754 Readonly, %Changelog%


Gui,%GuiName%: Show,Hide w900 h540, % RegExReplace(A_ScriptName, ".ahk|.exe", " App" )   "  Settings"
; SettingsGUIshow(GuiName,1)
; Tooltip,
Return
}


lbl_yt(){
    Try 
    Run https://www.youtube.com/channel/UCcfTHJKagMi3kAOZxUQmTKw?sub_confirmation=1
}

lbl_insta(){
    Try
    Run https://www.instagram.com/ananthuthilakan/
}

lbl_th_fr_cfe()
{
    Try 
    Run https://ananthuthilakan.com/say-thank-you/
}

HSstring_uytui(ctrlID, value){
	; Tooltip % " " ctrlID " " value
    static HSarr
    static PrevHSarr
    HSarr:={}
    Hsarr[ctrlID]:= value
    if (PrevHSarr[ctrlID]!=Hsarr[ctrlID]) 
        {
        ; Tooltip % " " ctrlID " " state
        if (IsLabel("lbl_" . SubStr(ctrlID, 5))) {
            if (StrLen(Hsarr[ctrlID])>2)
                Hotstring(":x:" . Hsarr[ctrlID] , "lbl_" . SubStr(ctrlID, 5) , "On")
                Hotstring(":x:" . PrevHSarr[ctrlID] , "lbl_" . SubStr(ctrlID, 5) , "Off")
            }
            Else
            {
                MsgBox 0x42030, Not found,% "SubRoutine not found for " SubStr(ctrlID, 5)
            }
          
        }
    PrevHSarr:= HSarr
}

USR_VarFn_fiowuebfi(ctrlID, value){
  
    if (value) {
    UserVariables.n[SubStr(ctrlID, 5)]:= value
    if (IsLabel("lbl_" . SubStr(ctrlID, 5))) {
        Gosub,% "lbl_" . SubStr(ctrlID, 5)
        }
        Else
        {
            MsgBox 0x42030, Not found, %  "SubRoutine not found for " SubStr(ctrlID, 5)
        }
    }
    
}

USR_EditFn_fiowuebfi(ctrlID, value){
  
    if (value) {
    UserVariables.t[SubStr(ctrlID, 5)]:= value
    if (IsLabel("lbl_" . SubStr(ctrlID, 5))) {
        Gosub,% "lbl_" . SubStr(ctrlID, 5)
        }
        Else
        {
            MsgBox 0x42030, Not found, %  "SubRoutine not found for " SubStr(ctrlID, 5)
        }
    }
    
}


USR_pFn_flgndsjd(ctrlID, value){
  
    if (value) {
    UserVariables.p[SubStr(ctrlID, 5)]:= value
    if (IsLabel("lbl_" . SubStr(ctrlID, 5))) {
        try
        Gosub,% "lbl_" . SubStr(ctrlID, 5)
        
    }
}
    
}




USR_BoolFn_dsfsdfbf(ctrlID, value){
  
    UserVariables.b[SubStr(ctrlID, 5)]:= value

    if (IsLabel("lbl_" . SubStr(ctrlID, 5))) {
        Gosub,% "lbl_" . SubStr(ctrlID, 5)
        }
        Else
        {
            MsgBox 0x42030, Not found, %  "SubRoutine not found for " SubStr(ctrlID, 5)
        }
    
}


Hkey_jhfkllsd(ctrlID,state){
    ; Tooltip % " " ctrlID " " state
    if (state)
        {
        ; if (IsFunc(("lbl_" . SubStr(ctrlID, 5)))){
        ;         t:="lbl_" . SubStr(ctrlID, 5)
        ;         %t%(state)
        ; }
        ;  else 
            if (IsLabel("lbl_" . SubStr(ctrlID, 5))) {
            Gosub,% "lbl_" . SubStr(ctrlID, 5)
            }
            Else
            {
                MsgBox 0x42030, Not found, %  "SubRoutine not found for " SubStr(ctrlID, 5)
            }
        }
        else if (State=0)
            {
            ;     if (IsFunc(("lbl_" . SubStr(ctrlID, 5))) . "_Up"){
            ;         t:="lbl_" . SubStr(ctrlID, 5) . "_Up"
            ;         %t%(state)
            ; }
                if (IsLabel("lbl_" . SubStr(ctrlID, 5)) . "_Up") {
                    try
                    Gosub,% "lbl_" . SubStr(ctrlID, 5) . "_Up"
                    }
            }

}










