  METHOD generate.

    DATA: lv_adt_link       TYPE string.
    DATA: lo_adt_uri_mapper TYPE REF TO object ##needed.
    DATA: lo_adt_objref     TYPE REF TO object ##needed.
    DATA: lo_adt_sub_objref TYPE REF TO object ##needed.
    DATA: lv_program        TYPE progname.
    DATA: lv_include        TYPE progname.
    FIELD-SYMBOLS: <lv_uri> TYPE string.

    get_adt_objects_and_names(
          EXPORTING
            iv_obj_name       = iv_obj_name
            iv_obj_type       = iv_obj_type
          IMPORTING
            eo_adt_uri_mapper = lo_adt_uri_mapper
            eo_adt_objectref  = lo_adt_objref
            ev_program        = lv_program
            ev_include        = lv_include ).

    TRY.
        IF iv_sub_obj_name IS NOT INITIAL.

          IF ( lv_program <> iv_obj_name AND lv_include IS INITIAL ) OR
             ( lv_program = lv_include AND iv_sub_obj_name IS NOT INITIAL ).
            lv_include = iv_sub_obj_name.
          ENDIF.

          CALL METHOD lo_adt_uri_mapper->('IF_ADT_URI_MAPPER~MAP_INCLUDE_TO_OBJREF')
            EXPORTING
              program     = lv_program
              include     = lv_include
              line        = iv_line_number
              line_offset = 0
              end_line    = iv_line_number
              end_offset  = 1
            RECEIVING
              result      = lo_adt_sub_objref.
          IF lo_adt_sub_objref IS NOT INITIAL.
            lo_adt_objref = lo_adt_sub_objref.
          ENDIF.

        ENDIF.

        ASSIGN ('LO_ADT_OBJREF->REF_DATA-URI') TO <lv_uri>.
        ASSERT sy-subrc = 0.

        CONCATENATE 'adt://' sy-sysid <lv_uri> INTO lv_adt_link.

        rv_result = lv_adt_link.
      CATCH cx_root.
        zcx_abapgit_exception=>raise( 'ADT Jump Error' ).
    ENDTRY.
  ENDMETHOD.