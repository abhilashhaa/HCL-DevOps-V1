  METHOD read.

    DATA: li_template TYPE REF TO if_w3_api_template,
          lt_source   TYPE w3htmltabtype,
          ls_name     TYPE iacikeyt.

    ls_name = ms_item-obj_name.

    li_template = w3_api_load( is_name = ls_name ).

    es_attr = w3_api_get_attributes( ii_template = li_template ).

    CLEAR: es_attr-chname,
           es_attr-tdate,
           es_attr-ttime,
           es_attr-devclass.

    lt_source = w3_api_get_source( ii_template = li_template ).

    CONCATENATE LINES OF lt_source INTO ev_source RESPECTING BLANKS.

  ENDMETHOD.