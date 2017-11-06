set _file=%1
set _framerate=60
log2vid\blackbox_render.exe --threads 8 --fps %_framerate% --gapless --no-draw-pid-table --draw-craft --draw-sticks --no-draw-time --no-plot-motor --no-plot-pid --no-plot-gyro --unit-gyro degree --prefix %_file%-int %_file%
mkdir %_file%-render
FOR %%i IN (%_file%-int*) DO (Move %%i %_file%-render/)
cd %_file%-render
rem lets make them mp4's
mkdir %_file%
ffmpeg.exe -framerate %_framerate% -i %_file%-int.01.%%06d.png -filter:v "crop=540:360:220:30" %_file%\%_file%.craft.%%06d.png
ffmpeg.exe -framerate %_framerate% -i %_file%-int.01.%%06d.png -filter:v "crop=650:250:1100:100" %_file%\%_file%.sticks.%%06d.png   
del *int*.png
cd ..
Move %_file%-render\%_file% %cd%\%_file%-out
rmdir %_file%-render\