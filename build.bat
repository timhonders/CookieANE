@echo off

SET mypath=%~dp0

echo Start building...


for /f "delims=" %%x in (config.txt) do (set "%%x")

echo %extention_id%

call "C:\Flex sdk 4.6\bin\acompc" -source-path %mypath%actionscript -include-classes %extention_id% -swf-version=14 -output %mypath%build\%extention_id%.swc


call "C:\Program Files\7-Zip\7z.exe" x %mypath%build\%extention_id%.swc -o%mypath%build\ library.swf

xcopy /Y %mypath%build\library.swf %mypath%build\ios\library.swf

del %mypath%build\library.swf

IF EXIST %mypath%bin\%extention_id%.ane del /F %mypath%bin\%extention_id%.ane

call "C:\Flex sdk 4.6\bin\adt" -package -target ane %mypath%bin\%extention_id%.ane %mypath%build\extension.xml -swc %mypath%\build\%extention_id%.swc -platform iPhone-ARM -C %mypath%build\ios libCore.a library.swf -platformoptions %mypath%build\platform-options.xml 
