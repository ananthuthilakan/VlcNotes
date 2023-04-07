Class ImageButton {
    Static DefGuiColor  := ""
    Static DefTxtColor := "Black"
    Static LastError := ""
    Static BitMaps := []
    Static GDIPDll := 0
    Static GDIPToken := 0
    Static MaxOptions := 8
    Static HTML := {BLACK: 0x000000, GRAY: 0x808080, SILVER: 0xC0C0C0, WHITE: 0xFFFFFF, MAROON: 0x800000
    , PURPLE: 0x800080, FUCHSIA: 0xFF00FF, RED: 0xFF0000, GREEN: 0x008000, OLIVE: 0x808000
    , YELLOW: 0xFFFF00, LIME: 0x00FF00, NAVY: 0x000080, TEAL: 0x008080, AQUA: 0x00FFFF, BLUE: 0x0000FF}
    Static ClassInit := ImageButton.InitClass()
    __New(P*) {
    Return False
    }
    InitClass() {
    GuiColor := DllCall("User32.dll\GetSysColor", "Int", 15, "UInt")
    This.DefGuiColor := ((GuiColor >> 16) & 0xFF) | (GuiColor & 0x00FF00) | ((GuiColor & 0xFF) << 16)
    Return True
    }
    GdiplusStartup() {
    This.GDIPDll := This.GDIPToken := 0
    If (This.GDIPDll := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "Ptr")) {
    VarSetCapacity(SI, 24, 0)
    Numput(1, SI, 0, "Int")
    If !DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", GDIPToken, "Ptr", &SI, "Ptr", 0)
    This.GDIPToken := GDIPToken
    Else
    This.GdiplusShutdown()
    }
    Return This.GDIPToken
    }
    GdiplusShutdown() {
    If This.GDIPToken
    DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", This.GDIPToken)
    If This.GDIPDll
    DllCall("Kernel32.dll\FreeLibrary", "Ptr", This.GDIPDll)
    This.GDIPDll := This.GDIPToken := 0
    }
    FreeBitmaps() {
    For I, HBITMAP In This.BitMaps
    DllCall("Gdi32.dll\DeleteObject", "Ptr", HBITMAP)
    This.BitMaps := []
    }
    GetARGB(RGB) {
    ARGB := This.HTML.HasKey(RGB) ? This.HTML[RGB] : RGB
    Return (ARGB & 0xFF000000) = 0 ? 0xFF000000 | ARGB : ARGB
    }
    PathAddRectangle(Path, X, Y, W, H) {
    Return DllCall("Gdiplus.dll\GdipAddPathRectangle", "Ptr", Path, "Float", X, "Float", Y, "Float", W, "Float", H)
    }
    PathAddRoundedRect(Path, X1, Y1, X2, Y2, R) {
    D := (R * 2), X2 -= D, Y2 -= D
    DllCall("Gdiplus.dll\GdipAddPathArc"
    , "Ptr", Path, "Float", X1, "Float", Y1, "Float", D, "Float", D, "Float", 180, "Float", 90)
    DllCall("Gdiplus.dll\GdipAddPathArc"
    , "Ptr", Path, "Float", X2, "Float", Y1, "Float", D, "Float", D, "Float", 270, "Float", 90)
    DllCall("Gdiplus.dll\GdipAddPathArc"
    , "Ptr", Path, "Float", X2, "Float", Y2, "Float", D, "Float", D, "Float", 0, "Float", 90)
    DllCall("Gdiplus.dll\GdipAddPathArc"
    , "Ptr", Path, "Float", X1, "Float", Y2, "Float", D, "Float", D, "Float", 90, "Float", 90)
    Return DllCall("Gdiplus.dll\GdipClosePathFigure", "Ptr", Path)
    }
    SetRect(ByRef Rect, X1, Y1, X2, Y2) {
    VarSetCapacity(Rect, 16, 0)
    NumPut(X1, Rect, 0, "Int"), NumPut(Y1, Rect, 4, "Int")
    NumPut(X2, Rect, 8, "Int"), NumPut(Y2, Rect, 12, "Int")
    Return True
    }
    SetRectF(ByRef Rect, X, Y, W, H) {
    VarSetCapacity(Rect, 16, 0)
    NumPut(X, Rect, 0, "Float"), NumPut(Y, Rect, 4, "Float")
    NumPut(W, Rect, 8, "Float"), NumPut(H, Rect, 12, "Float")
    Return True
    }
    SetError(Msg) {
    This.FreeBitmaps()
    This.GdiplusShutdown()
    This.LastError := Msg
    Return False
    }
    Create(HWND, Options*) {
    Static BCM_SETIMAGELIST := 0x1602
    , BS_CHECKBOX := 0x02, BS_RADIOBUTTON := 0x04, BS_GROUPBOX := 0x07, BS_AUTORADIOBUTTON := 0x09
    , BS_LEFT := 0x0100, BS_RIGHT := 0x0200, BS_CENTER := 0x0300, BS_TOP := 0x0400, BS_BOTTOM := 0x0800
    , BS_VCENTER := 0x0C00, BS_BITMAP := 0x0080
    , BUTTON_IMAGELIST_ALIGN_LEFT := 0, BUTTON_IMAGELIST_ALIGN_RIGHT := 1, BUTTON_IMAGELIST_ALIGN_CENTER := 4
    , ILC_COLOR32 := 0x20
    , OBJ_BITMAP := 7
    , RCBUTTONS := BS_CHECKBOX | BS_RADIOBUTTON | BS_AUTORADIOBUTTON
    , SA_LEFT := 0x00, SA_CENTER := 0x01, SA_RIGHT := 0x02
    , WM_GETFONT := 0x31
    This.LastError := ""
    If !DllCall("User32.dll\IsWindow", "Ptr", HWND)
    Return This.SetError("Invalid parameter HWND!")
    If !(IsObject(Options)) || (Options.MinIndex() <> 1) || (Options.MaxIndex() > This.MaxOptions)
    Return This.SetError("Invalid parameter Options!")
    WinGetClass, BtnClass, ahk_id %HWND%
    ControlGet, BtnStyle, Style, , , ahk_id %HWND%
    If (BtnClass != "Button") || ((BtnStyle & 0xF ^ BS_GROUPBOX) = 0) || ((BtnStyle & RCBUTTONS) > 1)
    Return This.SetError("The control must be a pushbutton!")
    If !This.GdiplusStartup()
    Return This.SetError("GDIPlus could not be started!")
    GDIPFont := 0
    HFONT := DllCall("User32.dll\SendMessage", "Ptr", HWND, "UInt", WM_GETFONT, "Ptr", 0, "Ptr", 0, "Ptr")
    DC := DllCall("User32.dll\GetDC", "Ptr", HWND, "Ptr")
    DllCall("Gdi32.dll\SelectObject", "Ptr", DC, "Ptr", HFONT)
    DllCall("Gdiplus.dll\GdipCreateFontFromDC", "Ptr", DC, "PtrP", PFONT)
    DllCall("User32.dll\ReleaseDC", "Ptr", HWND, "Ptr", DC)
    If !(PFONT)
    Return This.SetError("Couldn't get button's font!")
    VarSetCapacity(RECT, 16, 0)
    If !DllCall("User32.dll\GetWindowRect", "Ptr", HWND, "Ptr", &RECT)
    Return This.SetError("Couldn't get button's rectangle!")
    BtnW := NumGet(RECT,  8, "Int") - NumGet(RECT, 0, "Int")
    BtnH := NumGet(RECT, 12, "Int") - NumGet(RECT, 4, "Int")
    ControlGetText, BtnCaption, , ahk_id %HWND%
    If (ErrorLevel)
    Return This.SetError("Couldn't get button's caption!")
    This.BitMaps := []
    For Index, Option In Options {
    If !IsObject(Option)
    Continue
    BkgColor1 := BkgColor2 := TxtColor := Mode := Rounded := GuiColor := Image := ""
    Loop, % This.MaxOptions {
    If (Option[A_Index] = "")
    Option[A_Index] := Options.1[A_Index]
    }
    Mode := SubStr(Option.1, 1 ,1)
    If !InStr("0123456789", Mode)
    Return This.SetError("Invalid value for Mode in Options[" . Index . "]!")
    If (Mode = 0)
    && (FileExist(Option.2) || (DllCall("Gdi32.dll\GetObjectType", "Ptr", Option.2, "UInt") = OBJ_BITMAP))
    Image := Option.2
    Else {
    If !(Option.2 + 0) && !This.HTML.HasKey(Option.2)
    Return This.SetError("Invalid value for StartColor in Options[" . Index . "]!")
    BkgColor1 := This.GetARGB(Option.2)
    If (Option.3 = "")
    Option.3 := Option.2
    If !(Option.3 + 0) && !This.HTML.HasKey(Option.3)
    Return This.SetError("Invalid value for TargetColor in Options[" . Index . "]!")
    BkgColor2 := This.GetARGB(Option.3)
    }
    If (Option.4 = "")
    Option.4 := This.DefTxtColor
    If !(Option.4 + 0) && !This.HTML.HasKey(Option.4)
    Return This.SetError("Invalid value for TxtColor in Options[" . Index . "]!")
    TxtColor := This.GetARGB(Option.4)
    Rounded := Option.5
    If (Rounded = "H")
    Rounded := BtnH * 0.5
    If (Rounded = "W")
    Rounded := BtnW * 0.5
    If !(Rounded + 0)
    Rounded := 0
    If (Option.6 = "")
    Option.6 := This.DefGuiColor
    If !(Option.6 + 0) && !This.HTML.HasKey(Option.6)
    Return This.SetError("Invalid value for GuiColor in Options[" . Index . "]!")
    GuiColor := This.GetARGB(Option.6)
    BorderColor := ""
    If (Option.7 <> "") {
    If !(Option.7 + 0) && !This.HTML.HasKey(Option.7)
    Return This.SetError("Invalid value for BorderColor in Options[" . Index . "]!")
    BorderColor := 0xFF000000 | This.GetARGB(Option.7)
    }
    BorderWidth := Option.8 ? Option.8 : 1
    DllCall("Gdiplus.dll\GdipCreateBitmapFromScan0", "Int", BtnW, "Int", BtnH, "Int", 0
    , "UInt", 0x26200A, "Ptr", 0, "PtrP", PBITMAP)
    DllCall("Gdiplus.dll\GdipGetImageGraphicsContext", "Ptr", PBITMAP, "PtrP", PGRAPHICS)
    DllCall("Gdiplus.dll\GdipSetSmoothingMode", "Ptr", PGRAPHICS, "UInt", 4)
    DllCall("Gdiplus.dll\GdipSetInterpolationMode", "Ptr", PGRAPHICS, "Int", 7)
    DllCall("Gdiplus.dll\GdipSetCompositingQuality", "Ptr", PGRAPHICS, "UInt", 4)
    DllCall("Gdiplus.dll\GdipSetRenderingOrigin", "Ptr", PGRAPHICS, "Int", 0, "Int", 0)
    DllCall("Gdiplus.dll\GdipSetPixelOffsetMode", "Ptr", PGRAPHICS, "UInt", 4)
    DllCall("Gdiplus.dll\GdipGraphicsClear", "Ptr", PGRAPHICS, "UInt", GuiColor)
    If (Image = "") {
    PathX := PathY := 0, PathW := BtnW, PathH := BtnH
    DllCall("Gdiplus.dll\GdipCreatePath", "UInt", 0, "PtrP", PPATH)
    If (Rounded < 1)
    This.PathAddRectangle(PPATH, PathX, PathY, PathW, PathH)
    Else
    This.PathAddRoundedRect(PPATH, PathX, PathY, PathW, PathH, Rounded)
    If (BorderColor <> "") && (BorderWidth > 0) && (Mode <> 7) {
    DllCall("Gdiplus.dll\GdipCreateSolidFill", "UInt", BorderColor, "PtrP", PBRUSH)
    DllCall("Gdiplus.dll\GdipFillPath", "Ptr", PGRAPHICS, "Ptr", PBRUSH, "Ptr", PPATH)
    DllCall("Gdiplus.dll\GdipDeleteBrush", "Ptr", PBRUSH)
    DllCall("Gdiplus.dll\GdipResetPath", "Ptr", PPATH)
    PathX := PathY := BorderWidth, PathW -= BorderWidth, PathH -= BorderWidth, Rounded -= BorderWidth
    If (Rounded < 1)
    This.PathAddRectangle(PPATH, PathX, PathY, PathW - PathX, PathH - PathY)
    Else
    This.PathAddRoundedRect(PPATH, PathX, PathY, PathW, PathH, Rounded)
    BkgColor1 := 0xFF000000 | BkgColor1
    BkgColor2 := 0xFF000000 | BkgColor2
    }
    PathW -= PathX
    PathH -= PathY
    If (Mode = 0) {
    DllCall("Gdiplus.dll\GdipCreateSolidFill", "UInt", BkgColor1, "PtrP", PBRUSH)
    DllCall("Gdiplus.dll\GdipFillPath", "Ptr", PGRAPHICS, "Ptr", PBRUSH, "Ptr", PPATH)
    }
    Else If (Mode = 1) || (Mode = 2) {
    This.SetRectF(RECTF, PathX, PathY, PathW, PathH)
    DllCall("Gdiplus.dll\GdipCreateLineBrushFromRect", "Ptr", &RECTF
    , "UInt", BkgColor1, "UInt", BkgColor2, "Int", Mode & 1, "Int", 3, "PtrP", PBRUSH)
    DllCall("Gdiplus.dll\GdipSetLineGammaCorrection", "Ptr", PBRUSH, "Int", 1)
    This.SetRect(COLORS, BkgColor1, BkgColor1, BkgColor2, BkgColor2)
    This.SetRectF(POSITIONS, 0, 0.5, 0.5, 1)
    DllCall("Gdiplus.dll\GdipSetLinePresetBlend", "Ptr", PBRUSH
    , "Ptr", &COLORS, "Ptr", &POSITIONS, "Int", 4)
    DllCall("Gdiplus.dll\GdipFillPath", "Ptr", PGRAPHICS, "Ptr", PBRUSH, "Ptr", PPATH)
    }
    Else If (Mode >= 3) && (Mode <= 6) {
    W := Mode = 6 ? PathW / 2 : PathW
    H := Mode = 5 ? PathH / 2 : PathH
    This.SetRectF(RECTF, PathX, PathY, W, H)
    DllCall("Gdiplus.dll\GdipCreateLineBrushFromRect", "Ptr", &RECTF
    , "UInt", BkgColor1, "UInt", BkgColor2, "Int", Mode & 1, "Int", 3, "PtrP", PBRUSH)
    DllCall("Gdiplus.dll\GdipSetLineGammaCorrection", "Ptr", PBRUSH, "Int", 1)
    DllCall("Gdiplus.dll\GdipFillPath", "Ptr", PGRAPHICS, "Ptr", PBRUSH, "Ptr", PPATH)
    }
    Else {
    DllCall("Gdiplus.dll\GdipCreatePathGradientFromPath", "Ptr", PPATH, "PtrP", PBRUSH)
    DllCall("Gdiplus.dll\GdipSetPathGradientGammaCorrection", "Ptr", PBRUSH, "UInt", 1)
    VarSetCapacity(ColorArray, 4, 0)
    NumPut(BkgColor1, ColorArray, 0, "UInt")
    DllCall("Gdiplus.dll\GdipSetPathGradientSurroundColorsWithCount", "Ptr", PBRUSH, "Ptr", &ColorArray
    , "IntP", 1)
    DllCall("Gdiplus.dll\GdipSetPathGradientCenterColor", "Ptr", PBRUSH, "UInt", BkgColor2)
    FS := (BtnH < BtnW ? BtnH : BtnW) / 3
    XScale := (BtnW - FS) / BtnW
    YScale := (BtnH - FS) / BtnH
    DllCall("Gdiplus.dll\GdipSetPathGradientFocusScales", "Ptr", PBRUSH, "Float", XScale, "Float", YScale)
    DllCall("Gdiplus.dll\GdipFillPath", "Ptr", PGRAPHICS, "Ptr", PBRUSH, "Ptr", PPATH)
    }
    DllCall("Gdiplus.dll\GdipDeleteBrush", "Ptr", PBRUSH)
    DllCall("Gdiplus.dll\GdipDeletePath", "Ptr", PPATH)
    } Else {
    If (Image + 0)
    DllCall("Gdiplus.dll\GdipCreateBitmapFromHBITMAP", "Ptr", Image, "Ptr", 0, "PtrP", PBM)
    Else
    DllCall("Gdiplus.dll\GdipCreateBitmapFromFile", "WStr", Image, "PtrP", PBM)
    DllCall("Gdiplus.dll\GdipDrawImageRectI", "Ptr", PGRAPHICS, "Ptr", PBM, "Int", 0, "Int", 0
    , "Int", BtnW, "Int", BtnH)
    DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", PBM)
    }
    If (BtnCaption <> "") {
    DllCall("Gdiplus.dll\GdipStringFormatGetGenericTypographic", "PtrP", HFORMAT)
    DllCall("Gdiplus.dll\GdipCreateSolidFill", "UInt", TxtColor, "PtrP", PBRUSH)
    HALIGN := (BtnStyle & BS_CENTER) = BS_CENTER ? SA_CENTER
    : (BtnStyle & BS_CENTER) = BS_RIGHT  ? SA_RIGHT
    : (BtnStyle & BS_CENTER) = BS_Left   ? SA_LEFT
    : SA_CENTER
    DllCall("Gdiplus.dll\GdipSetStringFormatAlign", "Ptr", HFORMAT, "Int", HALIGN)
    VALIGN := (BtnStyle & BS_VCENTER) = BS_TOP ? 0
    : (BtnStyle & BS_VCENTER) = BS_BOTTOM ? 2
    : 1
    DllCall("Gdiplus.dll\GdipSetStringFormatLineAlign", "Ptr", HFORMAT, "Int", VALIGN)
    DllCall("Gdiplus.dll\GdipSetTextRenderingHint", "Ptr", PGRAPHICS, "Int", 0)
    VarSetCapacity(RECT, 16, 0)
    NumPut(BtnW, RECT,  8, "Float")
    NumPut(BtnH, RECT, 12, "Float")
    DllCall("Gdiplus.dll\GdipDrawString", "Ptr", PGRAPHICS, "WStr", BtnCaption, "Int", -1
    , "Ptr", PFONT, "Ptr", &RECT, "Ptr", HFORMAT, "Ptr", PBRUSH)
    }
    DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", PBITMAP, "PtrP", HBITMAP, "UInt", 0X00FFFFFF)
    This.BitMaps[Index] := HBITMAP
    DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", PBITMAP)
    DllCall("Gdiplus.dll\GdipDeleteBrush", "Ptr", PBRUSH)
    DllCall("Gdiplus.dll\GdipDeleteStringFormat", "Ptr", HFORMAT)
    DllCall("Gdiplus.dll\GdipDeleteGraphics", "Ptr", PGRAPHICS)
    }
    DllCall("Gdiplus.dll\GdipDeleteFont", "Ptr", PFONT)
    HIL := DllCall("Comctl32.dll\ImageList_Create"
    , "UInt", BtnW, "UInt", BtnH, "UInt", ILC_COLOR32, "Int", 6, "Int", 0, "Ptr")
    Loop, % (This.BitMaps.MaxIndex() > 1 ? 6 : 1) {
    HBITMAP := This.BitMaps.HasKey(A_Index) ? This.BitMaps[A_Index] : This.BitMaps.1
    DllCall("Comctl32.dll\ImageList_Add", "Ptr", HIL, "Ptr", HBITMAP, "Ptr", 0)
    }
    VarSetCapacity(BIL, 20 + A_PtrSize, 0)
    NumPut(HIL, BIL, 0, "Ptr")
    Numput(BUTTON_IMAGELIST_ALIGN_CENTER, BIL, A_PtrSize + 16, "UInt")
    
    ControlSetText, , , ahk_id %HWND%
    Control, Style, +%BS_BITMAP%, , ahk_id %HWND%
    SendMessage, %BCM_SETIMAGELIST%, 0, 0, , ahk_id %HWND%
    SendMessage, %BCM_SETIMAGELIST%, 0, % &BIL, , ahk_id %HWND%
    This.FreeBitmaps()
    This.GdiplusShutdown()
    Return True
    }
    SetGuiColor(GuiColor) {
    If !(GuiColor + 0) && !This.HTML.HasKey(GuiColor)
    Return False
    This.DefGuiColor := (This.HTML.HasKey(GuiColor) ? This.HTML[GuiColor] : GuiColor) & 0xFFFFFF
    Return True
    }
    SetTxtColor(TxtColor) {
    If !(TxtColor + 0) && !This.HTML.HasKey(TxtColor)
    Return False
    This.DefTxtColor := (This.HTML.HasKey(TxtColor) ? This.HTML[TxtColor] : TxtColor) & 0xFFFFFF
    Return True
    }
    }
    ;~ ////