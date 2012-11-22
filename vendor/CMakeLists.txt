# --------------------------------------------------------------
#  yaml_vendor
#  
#  expects:
#    MODULE_NAME defined in the CMakeLists for the module
#
#  provides:
#    yaml/vendor.so
# --------------------------------------------------------------
set(target "${MODULE_NAME}_vendor")

include_directories(src)
file(GLOB SOURCES src/*.c)

if(MODULES_STATIC)
  set(target "${MODULE_NAME}_static")
  add_library(${target} ${SOURCES})
else(MODULES_STATIC)
  set(target "${MODULE_NAME}_vendor")
  add_library(${target} MODULE ${SOURCES})
  set_target_properties(${target}
    PROPERTIES OUTPUT_NAME vendor
    LINK_FLAGS ${PLAT_OBJ_FLAGS}
    PREFIX ""
    SUFFIX ".so"
  )  
  
  # --------------------------------------------------------------
  #  install                                     
  # --------------------------------------------------------------
  install(TARGETS ${target}
    DESTINATION ${LUBYK_LIB}/lib/${MODULE_NAME}
  )
endif(MODULES_STATIC)

add_dependencies(${MODULE_NAME} ${target})

# The file lyaml.c has been edited to fix a float parsing bug
