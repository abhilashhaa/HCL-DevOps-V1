  METHOD zif_abapgit_object_enho~serialize.

    DATA: lo_badi_impl TYPE REF TO cl_enh_tool_badi_impl,
          lv_spot_name TYPE enhspotname,
          lv_shorttext TYPE string,
          lt_impl      TYPE enh_badi_impl_data_it.

    FIELD-SYMBOLS: <ls_impl>   LIKE LINE OF lt_impl,
                   <ls_values> LIKE LINE OF <ls_impl>-filter_values,
                   <ls_filter> LIKE LINE OF <ls_impl>-filters.


    lo_badi_impl ?= ii_enh_tool.

    lv_shorttext = lo_badi_impl->if_enh_object_docu~get_shorttext( ).
    lv_spot_name = lo_badi_impl->get_spot_name( ).
    lt_impl      = lo_badi_impl->get_implementations( ).

    LOOP AT lt_impl ASSIGNING <ls_impl>.
* make sure the XML serialization does not dump, field type = N
      LOOP AT <ls_impl>-filter_values ASSIGNING <ls_values>.
        IF <ls_values>-filter_numeric_value1 CA space.
          CLEAR <ls_values>-filter_numeric_value1.
        ENDIF.
      ENDLOOP.
      LOOP AT <ls_impl>-filters ASSIGNING <ls_filter>.
        IF <ls_filter>-filter_numeric_value1 CA space.
          CLEAR <ls_filter>-filter_numeric_value1.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    ii_xml->add( iv_name = 'TOOL'
                 ig_data = ii_enh_tool->get_tool( ) ).
    ii_xml->add( ig_data = lv_shorttext
                 iv_name = 'SHORTTEXT' ).
    ii_xml->add( iv_name = 'SPOT_NAME'
                 ig_data = lv_spot_name ).
    ii_xml->add( iv_name = 'IMPL'
                 ig_data = lt_impl ).

  ENDMETHOD.