  METHOD serialize_abap_old.
* for old ABAP AS versions
    DATA: lo_source TYPE REF TO cl_oo_source.

    CREATE OBJECT lo_source
      EXPORTING
        clskey             = is_clskey
      EXCEPTIONS
        class_not_existing = 1
        OTHERS             = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from CL_OO_SOURCE. Subrc = { sy-subrc }| ).
    ENDIF.

    lo_source->read( 'A' ).
    rt_source = lo_source->get_old_source( ).
    remove_signatures( CHANGING ct_source = rt_source ).

  ENDMETHOD.