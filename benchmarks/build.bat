@echo off
for %%f in (src\Main\*.elm) do (
    echo === %%~nf ===
    call elm make %%f --output=build\%%~nf.html --optimize
)