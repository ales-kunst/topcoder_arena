@echo off
@setlocal enableextensions
@set build_extern_name=build_extern
@set default_lib_name=lib_x64_WIN
@set default_inc_name=include
@set default_src_name=src

if exist %build_extern_name% (
    rmdir /s /q %build_extern_name%
)
@mkdir %build_extern_name%

echo *******************************************
echo * Start build Google-Test and Google-Mock *
echo *******************************************

@set google_test_build_folder=.\extern\google-test\build\
if exist %google_test_build_folder% (
    rmdir /s /q %google_test_build_folder%
)
@mkdir %google_test_build_folder%
@pushd %google_test_build_folder%
@cmake .. -G "Visual Studio 15 Win64"
@MSBuild ALL_BUILD.vcxproj /p:Configuration=Debug /p:Platform=x64
@MSBuild ALL_BUILD.vcxproj /p:Configuration=Release /p:Platform=x64
@popd
@mkdir .\%build_extern_name%\google-test\%default_lib_name%
@mkdir .\%build_extern_name%\google-test\%default_inc_name%
@mkdir .\%build_extern_name%\google-test\%default_src_name%
@robocopy %google_test_build_folder%\lib\Debug .\%build_extern_name%\google-test\%default_lib_name% *.lib /Z /R:5 /W:5 /V /MT
@robocopy %google_test_build_folder%\lib\Release .\%build_extern_name%\google-test\%default_lib_name% *.lib /Z /R:5 /W:5 /V /MT
@robocopy %google_test_build_folder%\bin\Debug .\%build_extern_name%\google-test\%default_lib_name% *.pdb /Z /R:5 /W:5 /V /MT
@robocopy %google_test_build_folder%\bin\Release .\%build_extern_name%\google-test\%default_lib_name% *.pdb /Z /R:5 /W:5 /V /MT
@robocopy %google_test_build_folder%\..\googletest\include .\%build_extern_name%\google-test\%default_inc_name% /S /E /Z /R:5 /W:5 /V /MT
@robocopy %google_test_build_folder%\..\googlemock\include .\%build_extern_name%\google-test\%default_inc_name% /S /E /Z /R:5 /W:5 /V /MT
@rmdir /s /q %google_test_build_folder%

echo *******************************************
echo * End build Google-Test and Google-Mock   *
echo *******************************************

echo *******************************************
echo * Start build Fmt                         *
echo *******************************************

@set fmt_folder=.\extern\fmt

@set fmt_build_folder=%fmt_folder%\build\
if exist %fmt_build_folder% (
    rmdir /s /q %fmt_build_folder%
)
@mkdir %fmt_build_folder%
@pushd %fmt_build_folder%
@cmake .. -G "Visual Studio 15 Win64"
@MSBuild ALL_BUILD.vcxproj /p:Configuration=Debug /p:Platform=x64
@MSBuild ALL_BUILD.vcxproj /p:Configuration=Release /p:Platform=x64
@popd

@mkdir .\%build_extern_name%\fmt\%default_lib_name%
@mkdir .\%build_extern_name%\fmt\%default_inc_name%
@mkdir .\%build_extern_name%\fmt\%default_src_name%

@robocopy %fmt_build_folder%\Debug .\%build_extern_name%\fmt\%default_lib_name% *.lib /Z /R:5 /W:5 /V /MT
@robocopy %fmt_build_folder%\Release .\%build_extern_name%\fmt\%default_lib_name% *.lib /Z /R:5 /W:5 /V /MT
@robocopy %fmt_build_folder%\fmt.dir\Debug .\%build_extern_name%\fmt\%default_lib_name% *.pdb /Z /R:5 /W:5 /V /MT
@pushd .\%build_extern_name%\fmt\%default_lib_name%
@ren fmt.pdb fmtd.pdb
@popd
@robocopy %fmt_folder%\include .\%build_extern_name%\fmt\%default_inc_name% /S /E /Z /R:5 /W:5 /V /MT
@robocopy %fmt_folder%\src .\%build_extern_name%\fmt\%default_src_name% /S /E /Z /R:5 /W:5 /V /MT
::@rmdir /s /q %fmt_build_folder%

echo ******************************************
echo * End build Fmt                          *
echo ******************************************

echo *******************************************
echo * Start build SpdLog                      *
echo *******************************************

@set spdlog_folder=.\extern\spdlog

@mkdir .\%build_extern_name%\spdlog\%default_lib_name%
@mkdir .\%build_extern_name%\spdlog\%default_inc_name%
@mkdir .\%build_extern_name%\spdlog\%default_src_name%

@robocopy %spdlog_folder%\include .\%build_extern_name%\spdlog\%default_inc_name% /S /E /Z /R:5 /W:5 /V /MT

echo ******************************************
echo * End build SpdLog                       *
echo ******************************************

echo *******************************************
echo * Start build Hayai                       *
echo *******************************************

@set hayai_folder=.\extern\hayai

@mkdir .\%build_extern_name%\hayai\%default_lib_name%
@mkdir .\%build_extern_name%\hayai\%default_inc_name%\hayai
@mkdir .\%build_extern_name%\hayai\%default_src_name%

@robocopy %hayai_folder%\src .\%build_extern_name%\hayai\%default_inc_name%\hayai *.hpp /S /E /Z /R:5 /W:5 /V /MT

echo ******************************************
echo * End build Hayai                        *
echo ******************************************