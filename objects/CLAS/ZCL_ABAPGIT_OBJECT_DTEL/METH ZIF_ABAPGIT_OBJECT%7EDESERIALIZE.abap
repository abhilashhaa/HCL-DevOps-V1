  METHOD zif_abapgit_object~deserialize.

    DATA: ls_dd04v TYPE dd04v,
          lv_name  TYPE ddobjname.


    io_xml->read( EXPORTING iv_name = 'DD04V'
                  CHANGING cg_data = ls_dd04v ).

    " DDIC Step: Replace REF TO class/interface with generic reference to avoid cyclic dependency
    IF iv_step = zif_abapgit_object=>gc_step_id-ddic AND ls_dd04v-datatype = 'REF'.
      ls_dd04v-rollname = 'OBJECT'.
    ELSEIF iv_step = zif_abapgit_object=>gc_step_id-late AND ls_dd04v-datatype <> 'REF'.
      RETURN. " already active
    ENDIF.

    corr_insert( iv_package = iv_package
                 ig_object_class = 'DICT' ).

    lv_name = ms_item-obj_name. " type conversion

    CALL FUNCTION 'DDIF_DTEL_PUT'
      EXPORTING
        name              = lv_name
        dd04v_wa          = ls_dd04v
      EXCEPTIONS
        dtel_not_found    = 1
        name_inconsistent = 2
        dtel_inconsistent = 3
        put_failure       = 4
        put_refused       = 5
        OTHERS            = 6.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |error from DDIF_DTEL_PUT, { sy-subrc }| ).
    ENDIF.

    deserialize_texts( ii_xml   = io_xml
                       is_dd04v = ls_dd04v ).

    deserialize_longtexts( io_xml ).

    zcl_abapgit_objects_activation=>add_item( ms_item ).

  ENDMETHOD.