@echo off
echo Building HTML from Markdown files...
powershell /NoProfile /NoLogo /ExecutionPolicy Bypass /Command "& ./build.ps1"
pause