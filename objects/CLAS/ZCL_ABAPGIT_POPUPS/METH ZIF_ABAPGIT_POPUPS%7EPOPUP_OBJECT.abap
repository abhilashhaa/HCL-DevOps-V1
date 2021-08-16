  METHOD zif_abapgit_popups~popup_object.

    DATA: lt_fields      TYPE TABLE OF sval.
    DATA: lv_object_type TYPE spo_value.
    DATA: lv_object_name TYPE spo_value.

    CLEAR: rs_tadir-object, rs_tadir-obj_name.

    add_field( EXPORTING iv_tabname   = 'TADIR'
                         iv_fieldname = 'OBJECT'
                         iv_fieldtext = 'Type'
               CHANGING ct_fields     = lt_fields ).

    add_field( EXPORTING iv_tabname   = 'TADIR'
                         iv_fieldname = 'OBJ_NAME'
                         iv_fieldtext = 'Name'
               CHANGING ct_fields     = lt_fields ).

    _popup_3_get_values( EXPORTING iv_popup_title    = 'Object'
                                   iv_no_value_check = abap_true
                         IMPORTING ev_value_1        = lv_object_type
                                   ev_value_2        = lv_object_name
                         CHANGING  ct_fields         = lt_fields ).

    rs_tadir = zcl_abapgit_factory=>get_tadir( )->read_single(
      iv_object   = to_upper( lv_object_type )
      iv_obj_name = to_upper( lv_object_name ) ).

  ENDMETHOD.