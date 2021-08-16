  METHOD zif_abapgit_object~delete.

    DATA: lt_cdnames TYPE STANDARD TABLE OF cdnames,
          ls_cdnames TYPE cdnames,
          lt_tcdrs   TYPE STANDARD TABLE OF tcdrs,
          ls_tcdrs   TYPE tcdrs,
          lv_msg     TYPE symsgv.

    CALL FUNCTION 'CDNAMES_GET'
      EXPORTING
        iv_object        = mv_object
      TABLES
        it_tcdrs         = lt_tcdrs
        it_names         = lt_cdnames
      EXCEPTIONS
        object_space     = 1
        object_not_found = 2
        OTHERS           = 3.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    CALL FUNCTION 'CHDO_DELETE'
      EXPORTING
        iv_object        = mv_object
        iv_with_tadir    = abap_true
      EXCEPTIONS
        object_is_space  = 1
        object_not_found = 2
        other_error      = 3
        OTHERS           = 4.
    IF sy-subrc <> 0.
      lv_msg = mv_object.
      zcx_abapgit_exception=>raise_t100( iv_msgid = 'CD'
                                         iv_msgno = '869'
                                         iv_msgv1 = lv_msg ).
    ENDIF.

    LOOP AT lt_cdnames INTO ls_cdnames.
      delete_tadir_cdnames( ls_cdnames ).
    ENDLOOP.

    LOOP AT lt_tcdrs INTO ls_tcdrs.
      delete_tadir_tabl( ls_tcdrs ).
    ENDLOOP.

  ENDMETHOD.