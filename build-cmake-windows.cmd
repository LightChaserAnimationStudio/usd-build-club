
REM cd in D:\usd_win_local
SET current=%cd%
SET builddir=%cd%\stage\local
SET usddir=%cd%\task-usd-win\install

if not exist "task-usd-win\build" mkdir task-usd-win\build
cd task-usd-win\build

REM ensure a 64 bit development environment using VS2015
IF NOT "%VisualStudioVersion%"=="14.0" ^
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64

if "%~1"=="debug" (set tbb_debug="-DTBB_USE_DEBUG_BUILD:INT=1")

echo "configuring for %tbb_debug% *******"

REM // USE_PTEX=0 because ptex integration is currently broken with the latest version of ptex
cmake ..\..\USD ^
      -DPXR_VALIDATE_GENERATED_CODE=ON ^
      -DPXR_BUILD_MAYA_PLUGIN=1 ^
      -DPXR_BUILD_KATANA_PLUGIN=0 ^
      -DPXR_BUILD_ALEMBIC_PLUGIN=0 ^
      -DCMAKE_INSTALL_PREFIX="%usddir%" ^
      -DCMAKE_PREFIX_PATH="%builddir%" ^
      -DALEMBIC_DIR="%builddir%" ^
      -DDOUBLE_CONVERSION_DIR="%builddir%" ^
      -DGLEW_LOCATION="%builddir%" ^
      -DOIIO_LOCATION="%builddir%" ^
      -DOPENEXR_ROOT_DIR="%builddir%" ^
      -DOPENSUBDIV_ROOT_DIR="%builddir%" ^
      -DPTEX_LOCATION="%builddir%" ^
      -DQT_ROOT_DIR="%builddir%" ^
      -DHDF5_ROOT="%builddir%" ^
      -DPYSIDE_BIN_DIR="C:\Python27\Scripts" ^
      -DBoost_INCLUDE_DIR="%builddir%"/include -DBoost_LIBRARY_DIR="%builddir%"/lib ^
      -DPXR_INSTALL_LOCATION="%usddir%" ^
      -DTBB_ROOT_DIR="%builddir%" %tbb_debug% ^
      -DMAYA_BASE_DIR="C:\Program Files\Autodesk\Maya2017" ^
      -DMAYA_tbb_LIBRARY="%builddir%\lib\tbb.lib" ^
      -DMAYA_LOCATION="W:\software\develop\maya\devkit\maya2017_windows_update3\devkitBase" ^
      -DMAYA_cgGL_LIBRARY="C:\Program Files\Autodesk\Maya2017\lib\cgGL.lib" ^
      -DMAYA_cg_LIBRARY="C:\Program Files\Autodesk\Maya2017\lib\cg.lib" ^
      -G "Visual Studio 14 2015 Win64"
