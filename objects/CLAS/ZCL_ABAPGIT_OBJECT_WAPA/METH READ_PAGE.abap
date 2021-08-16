  METHOD read_page.

    DATA: lv_name    TYPE o2applname,
          ls_pagekey TYPE o2pagkey,
          lv_content TYPE xstring,
          lv_extra   TYPE string,
          lv_ext     TYPE string,
          lo_page    TYPE REF TO cl_o2_api_pages.


    lv_name = ms_item-obj_name.

    ls_pagekey-applname = lv_name.
    ls_pagekey-pagekey = is_page-pagekey.

    cl_o2_api_pages=>load(
      EXPORTING
        p_pagekey = ls_pagekey
      IMPORTING
        p_page    = lo_page ).

    lo_page->get_attrs( IMPORTING p_attrs = rs_page-attributes ).

    IF rs_page-attributes-pagetype <> so2_controller.

      lo_page->get_event_handlers(
        IMPORTING
          p_ev_handler = rs_page-event_handlers
        EXCEPTIONS
          page_deleted = 1
          invalid_call = 2 ).
      ASSERT sy-subrc = 0.

      lo_page->get_parameters(
        IMPORTING
          p_parameters = rs_page-parameters
        EXCEPTIONS
          page_deleted = 1
          invalid_call = 2
          OTHERS       = 3 ).
      ASSERT sy-subrc = 0.

      lo_page->get_type_source(
        IMPORTING
          p_source     = rs_page-types
        EXCEPTIONS
          page_deleted = 1
          invalid_call = 2
          OTHERS       = 3 ).
      ASSERT sy-subrc = 0.

      lv_content = get_page_content( lo_page ).
      SPLIT is_page-pagename AT '.' INTO lv_extra lv_ext.
      REPLACE ALL OCCURRENCES OF '/' IN lv_ext WITH '_-'.
      REPLACE ALL OCCURRENCES OF '/' IN lv_extra WITH '_-'.
      mo_files->add_raw(
        iv_extra = lv_extra
        iv_ext   = lv_ext
        iv_data  = lv_content ).

      CLEAR: rs_page-attributes-implclass.

    ENDIF.

    CLEAR: rs_page-attributes-author,
           rs_page-attributes-createdon,
           rs_page-attributes-changedby,
           rs_page-attributes-changedon,
           rs_page-attributes-changetime,
           rs_page-attributes-gendate,
           rs_page-attributes-gentime,
           rs_page-attributes-devclass.

  ENDMETHOD.