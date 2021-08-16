  METHOD exists.

    DATA: li_obj TYPE REF TO zif_abapgit_object.


    TRY.
        li_obj = create_object( is_item = is_item
                                iv_language = zif_abapgit_definitions=>c_english ).
        rv_bool = li_obj->exists( ).
      CATCH zcx_abapgit_exception.
* ignore all errors and assume the object exists
        rv_bool = abap_true.
    ENDTRY.

  ENDMETHOD.