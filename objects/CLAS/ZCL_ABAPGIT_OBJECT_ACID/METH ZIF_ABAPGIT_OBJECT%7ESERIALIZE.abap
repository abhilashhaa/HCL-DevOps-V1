  METHOD zif_abapgit_object~serialize.

    DATA: lo_aab         TYPE REF TO cl_aab_id,
          lv_description TYPE aab_id_descript.


    IF zif_abapgit_object~exists( ) = abap_false.
      RETURN.
    ENDIF.

    lo_aab = create_object( ).

    lo_aab->get_descript(
      IMPORTING ex_descript = lv_description
      EXCEPTIONS no_description_found = 1 ).

    io_xml->add( iv_name = 'DESCRIPTION'
                 ig_data = lv_description ).

  ENDMETHOD.