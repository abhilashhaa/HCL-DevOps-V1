  METHOD zif_abapgit_object~deserialize.

* package SEDD
* package SDIC

* fm TR_TADIR_INTERFACE
* fm RS_CORR_INSERT ?

    DATA: lv_name  TYPE ddobjname,
          ls_dd01v TYPE dd01v,
          lt_dd07v TYPE TABLE OF dd07v.

    FIELD-SYMBOLS <ls_dd07v> TYPE dd07v.

    io_xml->read( EXPORTING iv_name = 'DD01V'
                  CHANGING cg_data = ls_dd01v ).
    io_xml->read( EXPORTING iv_name = 'DD07V_TAB'
                  CHANGING cg_data = lt_dd07v ).

    corr_insert( iv_package = iv_package
                 ig_object_class = 'DICT' ).

    lv_name = ms_item-obj_name. " type conversion

    LOOP AT lt_dd07v ASSIGNING <ls_dd07v>.
      <ls_dd07v>-domname = lv_name.
      <ls_dd07v>-valpos = sy-tabix.
    ENDLOOP.

    CALL FUNCTION 'DDIF_DOMA_PUT'
      EXPORTING
        name              = lv_name
        dd01v_wa          = ls_dd01v
      TABLES
        dd07v_tab         = lt_dd07v
      EXCEPTIONS
        doma_not_found    = 1
        name_inconsistent = 2
        doma_inconsistent = 3
        put_failure       = 4
        put_refused       = 5
        OTHERS            = 6.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from DDIF_DOMA_PUT' ).
    ENDIF.

    deserialize_texts( ii_xml   = io_xml
                       is_dd01v = ls_dd01v
                       it_dd07v = lt_dd07v ).

    deserialize_longtexts( io_xml ).

    zcl_abapgit_objects_activation=>add_item( ms_item ).

  ENDMETHOD.