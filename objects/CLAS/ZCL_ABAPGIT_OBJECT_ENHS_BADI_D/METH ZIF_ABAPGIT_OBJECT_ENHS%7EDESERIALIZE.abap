  METHOD zif_abapgit_object_enhs~deserialize.

    DATA: lv_parent          TYPE enhspotcompositename,
          lt_enh_badi        TYPE enh_badi_data_it,
          lo_badidef_tool    TYPE REF TO cl_enh_tool_badi_def,
          lv_enh_shorttext   TYPE string,
          li_enh_object      TYPE REF TO if_enh_object,
          li_enh_object_docu TYPE REF TO if_enh_object_docu,
          lv_text            TYPE string,
          lx_error           TYPE REF TO cx_enh_root.

    FIELD-SYMBOLS: <ls_enh_badi> LIKE LINE OF lt_enh_badi.

    ii_xml->read( EXPORTING iv_name = 'PARENT_COMP'
                  CHANGING  cg_data = lv_parent ).

    ii_xml->read( EXPORTING iv_name = 'BADI_DATA'
                  CHANGING  cg_data = lt_enh_badi ).

    ii_xml->read( EXPORTING iv_name = 'SHORTTEXT'
                  CHANGING  cg_data = lv_enh_shorttext ).

    li_enh_object ?= ii_enh_spot_tool.
    li_enh_object_docu ?= ii_enh_spot_tool.

    TRY.
        li_enh_object_docu->set_shorttext( lv_enh_shorttext ).

        lo_badidef_tool ?= ii_enh_spot_tool.

        LOOP AT lt_enh_badi ASSIGNING <ls_enh_badi>.
          lo_badidef_tool->add_badi_def( <ls_enh_badi> ).
        ENDLOOP.

        li_enh_object->save( ).
        li_enh_object->activate( ).
        li_enh_object->unlock( ).

      CATCH cx_enh_root INTO lx_error.
        lv_text = lx_error->get_text( ).
        zcx_abapgit_exception=>raise( lv_text ).
    ENDTRY.

  ENDMETHOD.