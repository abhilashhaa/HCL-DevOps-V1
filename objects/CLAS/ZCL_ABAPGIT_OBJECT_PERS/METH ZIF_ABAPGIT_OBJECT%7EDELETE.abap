  METHOD zif_abapgit_object~delete.

    DATA: lo_personalization_object TYPE REF TO cl_pers_reg.

    lo_personalization_object = get_personalization_object( ).

    lo_personalization_object->delete(
      EXPORTING
        p_no_confirm       = abap_true
      EXCEPTIONS
        deletion_canceled  = 1
        deletion_failed    = 2
        transport_canceled = 3
        OTHERS             = 4 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

  ENDMETHOD.