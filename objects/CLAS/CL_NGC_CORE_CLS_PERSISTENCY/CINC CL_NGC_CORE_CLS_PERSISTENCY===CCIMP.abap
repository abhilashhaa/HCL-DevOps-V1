*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

*--------------------------------------------------------------------*
*This implementation was moved to CL_NGC_CORE_CHR_PERSISTENCY
*--------------------------------------------------------------------*
*CLASS lcl_ddic_checks DEFINITION FINAL.
*  PUBLIC SECTION.
*    INTERFACES: lif_ddic_checks.
*ENDCLASS.
*
*CLASS lcl_ddic_checks IMPLEMENTATION.
*  METHOD lif_ddic_checks~check_table_or_view_name_tab.
*    rv_val_str = cl_abap_dyn_prg=>check_table_or_view_name_tab(
*                   val      = iv_val
*                   packages = it_packages ).
*  ENDMETHOD.
*
*  METHOD lif_ddic_checks~ddif_nametab_get.
*    CLEAR: et_x031l, et_dfies, ev_subrc.
*
*    CALL FUNCTION 'DDIF_NAMETAB_GET'
*      EXPORTING
*        tabname   = iv_tabname
**       ALL_TYPES = ' '
**       LFIELDNAME        = ' '
**       GROUP_NAMES       = ' '
**       UCLEN     =
**       STATUS    = 'A'
**     IMPORTING
**       X030L_WA  =
**       DTELINFO_WA       =
**       TTYPINFO_WA       =
**       DDOBJTYPE =
**       DFIES_WA  =
**       LINES_DESCR       =
*      TABLES
*        x031l_tab = et_x031l
*        dfies_tab = et_dfies
*      EXCEPTIONS
*        not_found = 1
*        OTHERS    = 2.
*
*    ev_subrc = sy-subrc.
*
*  ENDMETHOD.
*
*  METHOD lif_ddic_checks~ddut_texttable_get.
*    CLEAR: ev_texttable, ev_checkfield.
*
*    CALL FUNCTION 'DDUT_TEXTTABLE_GET'
*      EXPORTING
*        tabname    = iv_tabname
*      IMPORTING
*        texttable  = ev_texttable
*        checkfield = ev_checkfield.
*
*  ENDMETHOD.
*
*  METHOD lif_ddic_checks~function_exists.
*    rv_function_exists = abap_false.
*
*    CALL FUNCTION 'FUNCTION_EXISTS'
*      EXPORTING
*        funcname           = iv_funcname
**     IMPORTING
**       GROUP              =
**       INCLUDE            =
**       NAMESPACE          =
**       STR_AREA           =
*      EXCEPTIONS
*        function_not_exist = 1
*        OTHERS             = 2.
*
*    IF sy-subrc = 0.
*      rv_function_exists = abap_true.
*    ENDIF.
*
*  ENDMETHOD.
*ENDCLASS.
*--------------------------------------------------------------------*
* <<<
*--------------------------------------------------------------------*