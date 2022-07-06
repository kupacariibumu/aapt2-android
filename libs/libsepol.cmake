add_library(libsepol STATIC
     ${SRC_PATH}/libsepol/assertion.c
     ${SRC_PATH}/libsepol/avrule_block.c
     ${SRC_PATH}/libsepol/avtab.c
     ${SRC_PATH}/libsepol/boolean_record.c
     ${SRC_PATH}/libsepol/booleans.c
     ${SRC_PATH}/libsepol/conditional.c
     ${SRC_PATH}/libsepol/constraint.c
     ${SRC_PATH}/libsepol/context.c
     ${SRC_PATH}/libsepol/context_record.c
     ${SRC_PATH}/libsepol/debug.c
     ${SRC_PATH}/libsepol/ebitmap.c
     ${SRC_PATH}/libsepol/expand.c
     ${SRC_PATH}/libsepol/handle.c
     ${SRC_PATH}/libsepol/hashtab.c
     ${SRC_PATH}/libsepol/hierarchy.c
     ${SRC_PATH}/libsepol/iface_record.c
     ${SRC_PATH}/libsepol/interfaces.c
     ${SRC_PATH}/libsepol/kernel_to_cil.c
     ${SRC_PATH}/libsepol/kernel_to_common.c
     ${SRC_PATH}/libsepol/kernel_to_conf.c
     ${SRC_PATH}/libsepol/link.c
     ${SRC_PATH}/libsepol/mls.c
     ${SRC_PATH}/libsepol/module.c
     ${SRC_PATH}/libsepol/module_to_cil.c
     ${SRC_PATH}/libsepol/node_record.c
     ${SRC_PATH}/libsepol/nodes.c
     ${SRC_PATH}/libsepol/optimize.c
     ${SRC_PATH}/libsepol/polcaps.c
     ${SRC_PATH}/libsepol/policydb.c
     ${SRC_PATH}/libsepol/policydb_convert.c
     ${SRC_PATH}/libsepol/policydb_public.c
     ${SRC_PATH}/libsepol/port_record.c
     ${SRC_PATH}/libsepol/ports.c
     ${SRC_PATH}/libsepol/roles.c
     ${SRC_PATH}/libsepol/services.c
     ${SRC_PATH}/libsepol/sidtab.c
     ${SRC_PATH}/libsepol/symtab.c
     ${SRC_PATH}/libsepol/user_record.c
     ${SRC_PATH}/libsepol/users.c
     ${SRC_PATH}/libsepol/util.c
     ${SRC_PATH}/libsepol/write.c
     ${SRC_PATH}/libsepol/cil/android.c
     ${SRC_PATH}/libsepol/cil/cil_binary.c
     ${SRC_PATH}/libsepol/cil/cil_build_ast.c
     ${SRC_PATH}/libsepol/cil/cil.c
     ${SRC_PATH}/libsepol/cil/cil_copy_ast.c
     ${SRC_PATH}/libsepol/cil/cil_find.c
     ${SRC_PATH}/libsepol/cil/cil_fqn.c
     ${SRC_PATH}/libsepol/cil/cil_lexer.l
     ${SRC_PATH}/libsepol/cil/cil_list.c
     ${SRC_PATH}/libsepol/cil/cil_log.c
     ${SRC_PATH}/libsepol/cil/cil_mem.c
     ${SRC_PATH}/libsepol/cil/cil_parser.c
     ${SRC_PATH}/libsepol/cil/cil_policy.c
     ${SRC_PATH}/libsepol/cil/cil_post.c
     ${SRC_PATH}/libsepol/cil/cil_reset_ast.c
     ${SRC_PATH}/libsepol/cil/cil_resolve_ast.c
     ${SRC_PATH}/libsepol/cil/cil_stack.c
     ${SRC_PATH}/libsepol/cil/cil_strpool.c
     ${SRC_PATH}/libsepol/cil/cil_symtab.c
     ${SRC_PATH}/libsepol/cil/cil_tree.c
     ${SRC_PATH}/libsepol/cil/cil_verify.c
     ${SRC_PATH}/libsepol/cil/cil_write_ast.c)

target_compile_definitions(libsepol PRIVATE -D_GNU_SOURCE)

target_include_directories(libsepol PUBLIC
    ${SRC_PATH}/libselinux/include 
    ${SRC_PATH}/libsepol/include)
    
target_include_directories(libsepol PRIVATE
    ${SRC_PATH}/libsepol
    ${SRC_PATH}/libsepol/cil/include)