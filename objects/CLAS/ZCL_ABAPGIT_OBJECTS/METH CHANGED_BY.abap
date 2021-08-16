  METHOD changed_by.

    DATA: li_obj TYPE REF TO zif_abapgit_object.

    IF is_item IS NOT INITIAL.
      li_obj = create_object( is_item     = is_item
                              iv_language = zif_abapgit_definitions=>c_english ).
      rv_user = li_obj->changed_by( ).
    ENDIF.

    IF rv_user IS INITIAL.
* eg. ".abapgit.xml" file
      rv_user = zcl_abapgit_objects_super=>c_user_unknown.
    ENDIF.

* todo, fallback to looking at transports if rv_user = 'UNKNOWN'?

  ENDMETHOD.