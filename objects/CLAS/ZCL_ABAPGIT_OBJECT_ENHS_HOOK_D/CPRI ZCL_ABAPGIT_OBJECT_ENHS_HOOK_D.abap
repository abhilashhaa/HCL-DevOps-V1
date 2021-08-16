  PRIVATE SECTION.
    TYPES: BEGIN OF ty_hook_defifnition,
             pgmid     TYPE pgmid,
             obj_name  TYPE trobj_name,
             obj_type  TYPE trobjtype,
             main_type TYPE trobjtype,
             main_name TYPE eu_aname,
             program   TYPE progname,
             def_hooks TYPE enh_hook_def_ext_it,
           END OF ty_hook_defifnition.
