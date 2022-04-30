add_library(libsepol STATIC
     ${SRC_PATH}/libsepol/src/assertion.c
     ${SRC_PATH}/libsepol/src/avrule_block.c
     ${SRC_PATH}/libsepol/src/avtab.c
     ${SRC_PATH}/libsepol/src/boolean_record.c
     ${SRC_PATH}/libsepol/src/booleans.c
     ${SRC_PATH}/libsepol/src/conditional.c
     ${SRC_PATH}/libsepol/src/constraint.c
     ${SRC_PATH}/libsepol/src/context.c
     ${SRC_PATH}/libsepol/src/context_record.c
     ${SRC_PATH}/libsepol/src/debug.c
     ${SRC_PATH}/libsepol/src/ebitmap.c
     ${SRC_PATH}/libsepol/src/expand.c
     ${SRC_PATH}/libsepol/src/handle.c
     ${SRC_PATH}/libsepol/src/hashtab.c
     ${SRC_PATH}/libsepol/src/hierarchy.c
     ${SRC_PATH}/libsepol/src/iface_record.c
     ${SRC_PATH}/libsepol/src/interfaces.c
     ${SRC_PATH}/libsepol/src/kernel_to_cil.c
     ${SRC_PATH}/libsepol/src/kernel_to_common.c
     ${SRC_PATH}/libsepol/src/kernel_to_conf.c
     ${SRC_PATH}/libsepol/src/link.c
     ${SRC_PATH}/libsepol/src/mls.c
     ${SRC_PATH}/libsepol/src/module.c
     ${SRC_PATH}/libsepol/src/module_to_cil.c
     ${SRC_PATH}/libsepol/src/node_record.c
     ${SRC_PATH}/libsepol/src/nodes.c
     ${SRC_PATH}/libsepol/src/optimize.c
     ${SRC_PATH}/libsepol/src/polcaps.c
     ${SRC_PATH}/libsepol/src/policydb.c
     ${SRC_PATH}/libsepol/src/policydb_convert.c
     ${SRC_PATH}/libsepol/src/policydb_public.c
     ${SRC_PATH}/libsepol/src/port_record.c
     ${SRC_PATH}/libsepol/src/ports.c
     ${SRC_PATH}/libsepol/src/roles.c
     ${SRC_PATH}/libsepol/src/services.c
     ${SRC_PATH}/libsepol/src/sidtab.c
     ${SRC_PATH}/libsepol/src/symtab.c
     ${SRC_PATH}/libsepol/src/user_record.c
     ${SRC_PATH}/libsepol/src/users.c
     ${SRC_PATH}/libsepol/src/util.c
     ${SRC_PATH}/libsepol/src/write.c
     ${SRC_PATH}/libsepol/cil/src/android.c
     ${SRC_PATH}/libsepol/cil/src/cil_binary.c
     ${SRC_PATH}/libsepol/cil/src/cil_build_ast.c
     ${SRC_PATH}/libsepol/cil/src/cil.c
     ${SRC_PATH}/libsepol/cil/src/cil_copy_ast.c
     ${SRC_PATH}/libsepol/cil/src/cil_find.c
     ${SRC_PATH}/libsepol/cil/src/cil_fqn.c
     ${SRC_PATH}/libsepol/cil/src/cil_lexer.l
     ${SRC_PATH}/libsepol/cil/src/cil_list.c
     ${SRC_PATH}/libsepol/cil/src/cil_log.c
     ${SRC_PATH}/libsepol/cil/src/cil_mem.c
     ${SRC_PATH}/libsepol/cil/src/cil_parser.c
     ${SRC_PATH}/libsepol/cil/src/cil_policy.c
     ${SRC_PATH}/libsepol/cil/src/cil_post.c
     ${SRC_PATH}/libsepol/cil/src/cil_reset_ast.c
     ${SRC_PATH}/libsepol/cil/src/cil_resolve_ast.c
     ${SRC_PATH}/libsepol/cil/src/cil_stack.c
     ${SRC_PATH}/libsepol/cil/src/cil_strpool.c
     ${SRC_PATH}/libsepol/cil/src/cil_symtab.c
     ${SRC_PATH}/libsepol/cil/src/cil_tree.c
     ${SRC_PATH}/libsepol/cil/src/cil_verify.c
     ${SRC_PATH}/libsepol/cil/src/cil_write_ast.c
    )

target_compile_definitions(libsepol PRIVATE
    -D_GNU_SOURCE
    )

target_include_directories(libsepol PUBLIC
    ${SRC_PATH}/libselinux/include 
    ${SRC_PATH}/libsepol/include
    )
    
target_include_directories(libsepol PRIVATE
    ${SRC_PATH}/libsepol/src
    ${SRC_PATH}/libsepol/cil/include
    )