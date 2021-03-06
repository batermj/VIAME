# VIAME Internal Project
#
# Required symbols are:
#   VIAME_BUILD_PREFIX - where packages are built
#   VIAME_BUILD_INSTALL_PREFIX - directory install target
#   VIAME_PACKAGES_DIR - location of git submodule packages
#   VIAME_ARGS_COMMON -
##

FormatPassdowns( "VIAME_ENABLE" VIAME_ENABLE_FLAGS )
FormatPassdowns( "VIAME_DISABLE" VIAME_DISABLE_FLAGS )
FormatPassdowns( "VIAME_INSTALL" VIAME_INSTALL_FLAGS )
FormatPassdowns( "VIAME_DOWNLOAD" VIAME_DOWNLOAD_FLAGS )
FormatPassdowns( "VIAME_.*_VERSION" VIAME_VERSION_FLAGS )

if( VIAME_ENABLE_MATLAB )
  FormatPassdowns( "Matlab" VIAME_MATLAB_FLAGS )
endif()

if( VIAME_ENABLE_PYTHON )
  FormatPassdowns( "PYTHON" VIAME_PYTHON_FLAGS )
endif()

ExternalProject_Add(viame
  DEPENDS ${VIAME_PROJECT_LIST}
  PREFIX ${VIAME_BUILD_PREFIX}
  SOURCE_DIR ${CMAKE_SOURCE_DIR}
  CMAKE_GENERATOR ${gen}
  CMAKE_CACHE_ARGS
    ${VIAME_ARGS_COMMON}
    ${VIAME_ARGS_fletch}
    ${VIAME_ARGS_kwiver}
    ${VIAME_ARGS_scallop_tk}
    ${VIAME_ENABLE_FLAGS}
    ${VIAME_DISABLE_FLAGS}
    ${VIAME_DOWNLOAD_FLAGS}
    ${VIAME_INSTALL_FLAGS}
    ${VIAME_MATLAB_FLAGS}
    ${VIAME_PYTHON_FLAGS}
    ${VIAME_VERSION_FLAGS}
    -DBUILD_SHARED_LIBS:BOOL=ON
    -DVIAME_BUILD_DEPENDENCIES:BOOL=OFF
    -DVIAME_CREATE_PACKAGE:BOOL=${VIAME_CREATE_PACKAGE}
    -DVIAME_FIRST_CONFIGURATION:BOOL=${VIAME_FIRST_CONFIGURATION}
    -DKWIVER_PYTHON_MAJOR_VERSION:STRING=${PYTHON_VERSION_MAJOR}
  INSTALL_DIR ${VIAME_BUILD_INSTALL_PREFIX}
  )

#if (VIAME_FORCEBUILD)
ExternalProject_Add_Step(viame forcebuild
  COMMAND ${CMAKE_COMMAND}
    -E remove ${VIAME_BUILD_PREFIX}/src/viame-stamp/viame-build
  COMMENT "Removing build stamp file for build update (forcebuild)."
  DEPENDEES configure
  DEPENDERS build
  ALWAYS 1
  )
#endif()
