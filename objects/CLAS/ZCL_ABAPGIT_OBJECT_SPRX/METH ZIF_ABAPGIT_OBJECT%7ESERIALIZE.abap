  METHOD zif_abapgit_object~serialize.

    DATA:
      ls_sprx_db_data TYPE sprx_db_data.

    FIELD-SYMBOLS:
      <ls_sproxheader> LIKE LINE OF ls_sprx_db_data-sproxhdr,
      <ls_sproxdat>    LIKE LINE OF ls_sprx_db_data-sproxdat.


    IF zif_abapgit_object~exists( ) = abap_false.
      RETURN.
    ENDIF.

    ls_sprx_db_data = load_db( ).

    DELETE ls_sprx_db_data-sproxhdr WHERE object <> mv_object OR obj_name <> mv_obj_name.
    DELETE ls_sprx_db_data-sproxdat WHERE object <> mv_object OR obj_name <> mv_obj_name.
    DELETE ls_sprx_db_data-sproxsvar WHERE object <> mv_object OR obj_name <> mv_obj_name.
    DELETE ls_sprx_db_data-sproxpck WHERE object <> mv_object OR obj_name <> mv_obj_name.
    DELETE ls_sprx_db_data-sproxintf WHERE object <> mv_object OR obj_name <> mv_obj_name.

    IF lines( ls_sprx_db_data-sproxhdr ) <> 1.
      zcx_abapgit_exception=>raise( |SPRX, no header found, { mv_object }, { mv_obj_name }| ).
    ENDIF.

    LOOP AT ls_sprx_db_data-sproxhdr ASSIGNING <ls_sproxheader>.

      CLEAR:
        <ls_sproxheader>-created_by,
        <ls_sproxheader>-created_on,
        <ls_sproxheader>-changed_by,
        <ls_sproxheader>-changed_on.

    ENDLOOP.

    LOOP AT ls_sprx_db_data-sproxdat ASSIGNING <ls_sproxdat>.

      CLEAR <ls_sproxdat>-warnings.

    ENDLOOP.

    io_xml->add(
        iv_name = c_proxy-header
        ig_data = ls_sprx_db_data-sproxhdr ).

    io_xml->add(
        iv_name = c_proxy-data
        ig_data = ls_sprx_db_data-sproxdat ).

  ENDMETHOD.