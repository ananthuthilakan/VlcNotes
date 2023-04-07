SortListByName(vTextA, vTextB, vOffset) ;for use with AHK's Sort command
{
    local
    vRet := DllCall("shlwapi\StrCmpLogicalW", "WStr",vTextA, "WStr",vTextB)
    return vRet ? vRet : -vOffset
}