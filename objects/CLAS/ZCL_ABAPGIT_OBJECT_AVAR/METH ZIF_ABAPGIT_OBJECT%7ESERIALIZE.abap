  METHOD zif_abapgit_object~serialize.

    DATA: lo_aab         TYPE REF TO cl_aab_variant,
          lt_ids         TYPE aab_var_obj_act_tab,
          lv_description TYPE aab_var_descript.

    IF zif_abapgit_object~exists( ) = abap_false.
      RETURN.
    ENDIF.

    lo_aab = create_object( ).

    lo_aab->get_descript(
      IMPORTING
        ex_descript = lv_description
      EXCEPTIONS
        no_descript_found = 1 ).
    IF sy-subrc = 0.
      io_xml->add( iv_name = 'DESCRIPTION'
                   ig_data = lv_description ).
    ENDIF.

    lo_aab->get_ids( IMPORTING ex_ids = lt_ids ).

    io_xml->add( iv_name = 'IDS'
                 ig_data = lt_ids ).

  ENDMETHOD.