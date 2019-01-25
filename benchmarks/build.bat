@echo off
del /s /q build\*.*
for %%f in (src\Benchmarks\*.elm) do (
    echo === %%~nf ===
    call elm make %%f --output=build\%%~nf.html --optimize
)
@echo on