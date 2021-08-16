  METHOD render_result_line.

    DATA: lv_class   TYPE string,
          lv_obj_txt TYPE string,
          lv_msg     TYPE string,
          ls_mtdkey  TYPE seocpdkey.

    CASE is_result-kind.
      WHEN 'E'.
        lv_class = 'ci-error'.
      WHEN 'W'.
        lv_class = 'ci-warning'.
      WHEN OTHERS.
        lv_class = 'ci-info'.
    ENDCASE.

    lv_msg = escape( val = is_result-text
                     format = cl_abap_format=>e_html_attr ).

    IF is_result-sobjname IS INITIAL OR
       ( is_result-sobjname = is_result-objname AND
         is_result-sobjtype = is_result-sobjtype ).
      lv_obj_txt = |{ is_result-objtype } { is_result-objname }|.
    ELSEIF is_result-objtype = 'CLAS' OR
         ( is_result-objtype = 'PROG' AND NOT is_result-sobjname+30(*) IS INITIAL ).
      TRY.
          CASE is_result-sobjname+30(*).
            WHEN seop_incextapp_definition.
              lv_obj_txt = |CLAS { is_result-objname } : Local Definitions|.
            WHEN seop_incextapp_implementation.
              lv_obj_txt = |CLAS { is_result-objname } : Local Implementations|.
            WHEN seop_incextapp_macros.
              lv_obj_txt = |CLAS { is_result-objname } : Macros|.
            WHEN seop_incextapp_testclasses.
              lv_obj_txt = |CLAS { is_result-objname } : Test Classes|.
            WHEN 'CU'.
              lv_obj_txt = |CLAS { is_result-objname } : Public Section|.
            WHEN 'CO'.
              lv_obj_txt = |CLAS { is_result-objname } : Protected Section|.
            WHEN 'CI'.
              lv_obj_txt = |CLAS { is_result-objname } : Private Section|.
            WHEN OTHERS.
              cl_oo_classname_service=>get_method_by_include(
                EXPORTING
                  incname             = is_result-sobjname
                RECEIVING
                  mtdkey              = ls_mtdkey
                EXCEPTIONS
                  class_not_existing  = 1
                  method_not_existing = 2
                  OTHERS              = 3 ).
              IF sy-subrc = 0.
                lv_obj_txt = |CLAS { ls_mtdkey-clsname }->{ ls_mtdkey-cpdname }|.
              ELSE.
                lv_obj_txt = |{ is_result-objtype } { is_result-sobjname }|.
              ENDIF.

          ENDCASE.
        CATCH cx_root.
          lv_obj_txt = ''. "use default below
      ENDTRY.
    ENDIF.
    IF lv_obj_txt IS INITIAL.
      lv_obj_txt = |{ is_result-objtype } { is_result-objname } &gt; { is_result-sobjtype } { is_result-sobjname }|.
    ENDIF.
    lv_obj_txt = |{ lv_obj_txt } [ @{ zcl_abapgit_convert=>alpha_output( is_result-line ) } ]|.

    ii_html->add( |<li class="{ lv_class }">| ).
    ii_html->add_a(
      iv_txt = lv_obj_txt
      iv_act = build_nav_link( is_result )
      iv_typ = zif_abapgit_html=>c_action_type-sapevent ).
    ii_html->add( |<span>{ lv_msg }</span>| ).
    ii_html->add( '</li>' ).

  ENDMETHOD.