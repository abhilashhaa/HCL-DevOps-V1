  METHOD zif_abapgit_object~deserialize.

    DATA: lv_possible    TYPE abap_bool,
          lv_description TYPE aab_var_descript,
          ls_is          TYPE aab_var_obj_act,
          lt_ids         TYPE aab_var_obj_act_tab,
          lo_aab         TYPE REF TO cl_aab_variant.

    " AVAR can only be created in transportable packages
    lv_possible = zcl_abapgit_factory=>get_sap_package( iv_package )->are_changes_recorded_in_tr_req( ).
    IF lv_possible = abap_false.
      zcx_abapgit_exception=>raise( |Global activation variants require a transportable package| ).
    ENDIF.

    " Create AVAR with description and object (id) list
    io_xml->read( EXPORTING iv_name = 'DESCRIPTION'
                  CHANGING  cg_data = lv_description ).

    io_xml->read( EXPORTING iv_name = 'IDS'
                  CHANGING  cg_data = lt_ids ).

    lo_aab = create_object( ).
    lo_aab->enqueue( ).
    lo_aab->set_descript(
      EXPORTING
        im_descript      = lv_description
      EXCEPTIONS
        no_authorization = 1 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |No authorization for { ls_is-object } { ls_is-name }| ).
    ENDIF.

    LOOP AT lt_ids INTO ls_is.
      lo_aab->set_id(
        EXPORTING
          im_name              = ls_is-name
          im_object            = ls_is-object
          im_actmode           = ls_is-actmode
        EXCEPTIONS
          no_authorization     = 1
          id_not_exists        = 2
          id_not_transportable = 3 ).
      CASE sy-subrc.
        WHEN 1.
          zcx_abapgit_exception=>raise( |No authorization for { ls_is-object } { ls_is-name }| ).
        WHEN 2.
          zcx_abapgit_exception=>raise( |{ ls_is-object } { ls_is-name } does not exist| ).
        WHEN 3.
          zcx_abapgit_exception=>raise( |{ ls_is-object } { ls_is-name } must be transportable| ).
      ENDCASE.
    ENDLOOP.

    tadir_insert( iv_package ).

    lo_aab->save(
      EXCEPTIONS
        no_descript_specified = 1
        prop_error            = 2
        propt_error           = 3
        var_id_error          = 4
        no_changes_found      = 5
        cts_error             = 6 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error saving AVAR { ms_item-obj_name }| ).
    ENDIF.

  ENDMETHOD.