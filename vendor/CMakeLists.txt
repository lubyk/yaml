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
file(GLOB CORE_SOURCES src/*.c)

add_library(${target} MODULE ${CORE_SOURCES})
set_target_properties(${target}
  PROPERTIES OUTPUT_NAME vendor
  LINK_FLAGS ${PLAT_OBJ_FLAGS}
  PREFIX ""
  SUFFIX ".so"
)  

add_dependencies(${MODULE_NAME} ${target})

# --------------------------------------------------------------
#  install                                     
# --------------------------------------------------------------
install(TARGETS ${target}
  DESTINATION ${LUBYK_LIB}/lib/${MODULE_NAME}
)

# The file lyaml.c has been edited to fix a float parsing bug
