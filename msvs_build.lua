workspace "TopcoderArena"
  location "msvs_2017"
  configurations { "Debug", "Release" }
  platforms { "x64" }

  filter { "platforms:x64" }
    system "Windows"
    architecture "x86_64"
    buildoptions { "/std:c++latest", "/Qpar" }

project "TopcoderArena"
  language "C++"
  kind "ConsoleApp"
  location "msvs_2017/TopcoderArena"
  targetdir "$(SolutionDir)../bin/$(ProjectName)_$(Platform)_$(Configuration)/"
  objdir "!$(SolutionDir)../bin/obj/$(ProjectName)_$(Platform)_$(Configuration)/"
  characterset 'Unicode'
  rtti "On"
  flags { "MultiProcessorCompile", "NoPCH" }
  includedirs { "$(SolutionDir)../build_extern/fmt/include", "$(SolutionDir)../build_extern/spdlog/include" }
  files { "src/**.h", "src/**.cpp" }
  vpaths {
    ["Header Files"] = { "src/**.h" },
    ["Source Files"] = { "src/**.cpp" },
    ["Source Files/Main"] = { "src/topcoder_arena/Main.cpp" }
  }

  filter "configurations:Debug"
    defines { "DEBUG", "_CONSOLE", "FMT_HEADER_ONLY" }

  filter "configurations:Release"
    defines { "NDEBUG", "_CONSOLE", "FMT_HEADER_ONLY" }
    optimize "Speed"

  project "TopcoderArenaTest"
    language "C++"
    kind "ConsoleApp"
    location "msvs_2017/TopcoderArena"
    targetdir "$(SolutionDir)../bin/$(ProjectName)_$(Platform)_$(Configuration)/"
    objdir "!$(SolutionDir)../bin/obj/$(ProjectName)_$(Platform)_$(Configuration)/"
    links { "TopcoderArena" }
    characterset 'Unicode'
    rtti "On"
    flags { "MultiProcessorCompile", "NoPCH" }
    includedirs { "$(SolutionDir)../src/topcoder_arena", "$(SolutionDir)../build_extern/google-test/include", "$(SolutionDir)../build_extern/fmt/include", "$(SolutionDir)../build_extern/spdlog/include" }
    libdirs { "$(SolutionDir)../build_extern/google-test/lib_x64_WIN" }
    files { "tests/**.h", "tests/**.cpp" }
    vpaths {
      ["Header Files"] = { "tests/**.h" },
      ["Source Files"] = { "tests/**.cpp" },
      ["Source Files/Main"] = { "tests/topcoder_arena/MainTest.cpp" }
    }
    
    filter "configurations:Release"
      defines { "DEBUG", "_CONSOLE", "FMT_HEADER_ONLY" }
      buildoptions { "/MT" }
      links { "gtest.lib", "gtest_main.lib", "gmock.lib", "gmock_main.lib" }
    
    filter "configurations:Debug"
      defines { "NDEBUG", "_CONSOLE", "FMT_HEADER_ONLY" }
      buildoptions { "/MTd" }
      optimize "Speed"
      links { "gtestd.lib", "gtest_maind.lib", "gmockd.lib", "gmock_maind.lib" }