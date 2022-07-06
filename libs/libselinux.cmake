add_library(libselinux STATIC
    ${SRC_PATH}/libselinux/booleans.c    
    ${SRC_PATH}/libselinux/callbacks.c    
    ${SRC_PATH}/libselinux/freecon.c    
    ${SRC_PATH}/libselinux/label_backends_android.c    
    ${SRC_PATH}/libselinux/label.c    
    ${SRC_PATH}/libselinux/label_support.c    
    ${SRC_PATH}/libselinux/matchpathcon.c    
    ${SRC_PATH}/libselinux/setrans_client.c    
    ${SRC_PATH}/libselinux/sha1.c    
    ${SRC_PATH}/libselinux/android/android.c    
    ${SRC_PATH}/libselinux/avc.c    
    ${SRC_PATH}/libselinux/avc_internal.c    
    ${SRC_PATH}/libselinux/avc_sidtab.c    
    ${SRC_PATH}/libselinux/canonicalize_context.c    
    ${SRC_PATH}/libselinux/checkAccess.c    
    ${SRC_PATH}/libselinux/check_context.c    
    ${SRC_PATH}/libselinux/compute_av.c    
    ${SRC_PATH}/libselinux/compute_create.c    
    ${SRC_PATH}/libselinux/compute_member.c    
    ${SRC_PATH}/libselinux/context.c    
    ${SRC_PATH}/libselinux/deny_unknown.c    
    ${SRC_PATH}/libselinux/disable.c    
    ${SRC_PATH}/libselinux/enabled.c    
    ${SRC_PATH}/libselinux/fgetfilecon.c    
    ${SRC_PATH}/libselinux/fsetfilecon.c    
    ${SRC_PATH}/libselinux/getenforce.c    
    ${SRC_PATH}/libselinux/getfilecon.c    
    ${SRC_PATH}/libselinux/get_initial_context.c    
    ${SRC_PATH}/libselinux/getpeercon.c    
    ${SRC_PATH}/libselinux/init.c    
    ${SRC_PATH}/libselinux/lgetfilecon.c    
    ${SRC_PATH}/libselinux/load_policy.c    
    ${SRC_PATH}/libselinux/lsetfilecon.c    
    ${SRC_PATH}/libselinux/mapping.c    
    ${SRC_PATH}/libselinux/policyvers.c    
    ${SRC_PATH}/libselinux/procattr.c    
    ${SRC_PATH}/libselinux/reject_unknown.c    
    ${SRC_PATH}/libselinux/sestatus.c    
    ${SRC_PATH}/libselinux/setenforce.c    
    ${SRC_PATH}/libselinux/setfilecon.c    
    ${SRC_PATH}/libselinux/stringrep.c 
    ${SRC_PATH}/libselinux/label_file.c
    ${SRC_PATH}/libselinux/regex.c
    ${SRC_PATH}/libselinux/selinux_config.c
    ${SRC_PATH}/libselinux/seusers.c
    ${SRC_PATH}/libselinux/android/android_vendor.c)

target_compile_definitions(libselinux PRIVATE
    -DAUDITD_LOG_TAG=1003 
    -D_GNU_SOURCE 
    -DHOST 
    -DUSE_PCRE2
    -DNO_PERSISTENTLY_STORED_PATTERNS 
    -DDISABLE_SETRANS
    -DDISABLE_BOOL 
    -DNO_MEDIA_BACKEND 
    -DNO_X_BACKEND 
    -DNO_DB_BACKEND
    -DPCRE2_CODE_UNIT_WIDTH=8)
    
target_include_directories(libselinux PUBLIC
    ${SRC_PATH}/libselinux/include 
    ${SRC_PATH}/libsepol/include
    ${SRC_PATH}/libcutils/include
    ${SRC_PATH}/liblog/include 
    ${SRC_PATH}/pcre/include)
    
target_include_directories(libselinux PRIVATE ${SRC_PATH}/libselinux)