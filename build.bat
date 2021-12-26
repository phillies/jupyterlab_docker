@echo off
for /f "delims=" %%# in ('powershell get-date -format "{yyMMdd}"') do @set today=%%#
docker build -t plies/jupyterlab:%today% .