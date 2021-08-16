  METHOD zif_abapgit_object~jump.

    DATA: lv_typename   TYPE typename.
    DATA: lv_ddtypekind TYPE ddtypekind.

    lv_typename = ms_item-obj_name.

    CALL FUNCTION 'DDIF_TYPEINFO_GET'
      EXPORTING
        typename = lv_typename
      IMPORTING
        typekind = lv_ddtypekind.

    CASE lv_ddtypekind.
      WHEN 'STOB'.
        me->open_adt_stob( ms_item-obj_name ).
      WHEN OTHERS.
        zcx_abapgit_exception=>raise( 'DDLS Jump Error' ).
    ENDCASE.

  ENDMETHOD.