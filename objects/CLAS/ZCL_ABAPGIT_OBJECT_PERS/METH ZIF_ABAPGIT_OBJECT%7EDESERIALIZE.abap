  METHOD zif_abapgit_object~deserialize.

    DATA:
      ls_personalization_object TYPE ty_personalization_object,
      lo_personalization_object TYPE REF TO cl_pers_reg.

    io_xml->read(
      EXPORTING
        iv_name = 'PERS'
      CHANGING
        cg_data = ls_personalization_object ).

    tadir_insert( iv_package ).

    lo_personalization_object = get_personalization_object( iv_create = abap_true ).

    lo_personalization_object->set_reg_data(
        p_pers_reg      = ls_personalization_object-pers_reg
        p_pers_reg_text = ls_personalization_object-pers_reg_text ).

    lo_personalization_object->save(
      EXPORTING
        no_check           = abap_true
      EXCEPTIONS
        data_not_saved     = 1
        transport_canceled = 2
        OTHERS             = 3 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

  ENDMETHOD.