; DragnDrop()
; return

; ^!m::
; DragnDropShow()
; return

; youshould have a DragnDropGet(url) inside your script


DragnDrop(){
    global wb
    Gui,dragndrop: +AlwaysOnTop +ToolWindow   MinSize200x200  -DPIScale  
    Gui,dragndrop: Color, 19191C, 19191C
    Gui,dragndrop: Add, ActiveX, x-10 y-10 w225 h210 vwb, Shell.Explorer
    wb.Navigate("about:blank")
    Gui,dragndrop: Show,Hide w200 h200, Drop Files/urls
    ComObjConnect(wb, "IE_")
    }
    
    ; IE_BeforeNavigate2(p*) {
    ;   NumPut(true, ComObjValue(p.7))
    ;   DragnDropGet(p.2)
    ; ;   if (IsFunc("DragnDropRecieve")){
    ; ;     DragnDropRecieve(p.2)
    ; ;   }
    ; }
    
    DragnDropShow()
    {
      Gui,dragndrop: Show
    }
    
    DragnDropHide()
    {
      Gui,dragndrop: Hide
    }
    
    ; DragnDropGet(url:="")
    ; {
    ;   static goturl
    ;   if (url)
    ;     goturl:=url
    ;   Else
    ;     {
    ;     return goturl
    ;     }
    ; }

    