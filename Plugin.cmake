# ~~~
# Summary:      Local, non-generic plugin setup
# Copyright (c) 2020-2025 Mike Rossiter
# License:      GPLv3+
# ~~~

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.


# -------- Options ----------

set(OCPN_TEST_REPO
    "opencpn/aisradar-alpha"
    CACHE STRING "Default repository for untagged builds"
)
set(OCPN_BETA_REPO
    "opencpn/aisradar-beta"
    CACHE STRING
    "Default repository for tagged builds matching 'beta'"
)
set(OCPN_RELEASE_REPO
    "opencpn/aisradar-prod"
    CACHE STRING
    "Default repository for tagged builds not matching 'beta'"
)
#
#
#
# -------  Plugin setup --------
#
set(PKG_NAME aisradar_pi)
set(PKG_VERSION  2.1.0)
set(PKG_PRERELEASE "")  # Empty, or a tag like 'beta'

set(DISPLAY_NAME aisradar)    # Dialogs, installer artifacts, ...
set(PLUGIN_API_NAME aisradar) # As of GetCommonName() in plugin API
set(PKG_SUMMARY "French Tidal Currents")
set(PKG_DESCRIPTION [=[French Tidal Currents from SHOM.
]=])

set(PKG_AUTHOR "Mike Rossiter")
set(PKG_IS_OPEN_SOURCE "yes")
set(PKG_HOMEPAGE https://github.com/Rasbats/aisradar_pi)
set(PKG_INFO_URL https://opencpn.org/OpenCPN/plugins/aisradar.html)

set(SRC
        src/aisradar_pi.h
        src/aisradar_pi.cpp
        src/icons.h
        src/icons.cpp
        src/aisview.h
        src/aisview.cpp
        src/Canvas.h
        src/Canvas.cpp
        src/Target.cpp
        src/Target.h
        
)

set(PKG_API_LIB api-20)  #  A dir in opencpn-libs/ e. g., api-17 or api-16

# Minimum version which should be loaded. Ignored if api < 22. 
# Allows plugins using functions from 1.22+ API to be loaded by 
# hosts only supporting 1.21; plugins then needs to check if host 
# supports 1.22+ before using such functions. 
# If undefined, plugin will only be loaded by host supporting the 
# included api. 
## set(MIN_API_VERSION 1.21) 

  

macro(late_init)
  # Perform initialization after the PACKAGE_NAME library, compilers
  # and ocpn::api is available.
endmacro ()

macro(add_plugin_libraries)
  # Add libraries required by this plugin

  add_subdirectory("opencpn-libs/tinyxml")
  target_link_libraries(${PACKAGE_NAME} ocpn::tinyxml)

  add_subdirectory("${CMAKE_SOURCE_DIR}/opencpn-libs/plugin_dc")
  target_link_libraries(${PACKAGE_NAME} ocpn::plugin-dc)

  # The wxsvg library enables SVG overall in the plugin
  add_subdirectory("${CMAKE_SOURCE_DIR}/opencpn-libs/wxsvg")
  target_link_libraries(${PACKAGE_NAME} ocpn::wxsvg)

endmacro ()
