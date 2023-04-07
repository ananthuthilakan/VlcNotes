
FileURL( File ) {                                                ; By SKAN on D1CA @ goo.gl/UqXL6n
Local v, INTERNET_MAX_URL_LENGTH := 2048   
  VarSetCapacity(v,4200,0)
  DllCall( "Shlwapi.dll" ( SubStr(File,1,5)="file:" ? "\PathCreateFromUrl" : "\UrlCreateFromPath" )
         , "Str",File, "Str",v, "UIntP",INTERNET_MAX_URL_LENGTH, "UInt",0 )
Return v
}