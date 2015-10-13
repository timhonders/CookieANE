@echo off

SET mypath=%~dp0

echo Start building...


for /f "delims=" %%x in (config.txt) do (set "%%x")

echo %extention_id%

call "C:\Flex sdk 4.6\bin\acompc" -source-path %mypath%actionscript -include-classes %extention_id% -swf-version=14 -output %mypath%bin\%extention_id%.swc


call "C:\Program Files\7-Zip\7z.exe" x %mypath%bin\%extention_id%.swc -o%mypath%bin\ library.swf

xcopy /Y %mypath%bin\library.swf %mypath%ios\build\Debug-iphoneos\library.swf
xcopy /Y %mypath%bin\library.swf %mypath%windows\Core\Release\library.swf
xcopy /Y %mypath%bin\library.swf %mypath%default\library.swf

del %mypath%bin\library.swf

IF EXIST %mypath%bin\%extention_id%.ane del /F %mypath%bin\%extention_id%.ane

call "C:\Flex sdk 4.6\bin\adt" -package -target ane %mypath%bin\%extention_id%.ane %mypath%extension.xml -swc %mypath%\bin\%extention_id%.swc -platform iPhone-ARM -C %mypath%ios\build\Debug-iphoneos libCookieANE.a library.swf -platform iPhone-x86 -C %mypath%ios\build\Debug-iphonesimulator libCookieANE.a library.swf -platform default -C %mypath%\default library.swf 
