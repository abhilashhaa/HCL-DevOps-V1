  METHOD zif_abapgit_object~serialize.

    DATA: lo_switch    TYPE REF TO cl_sfw_sw,
          ls_header    TYPE sfw_switch,
          lv_name_32   TYPE sfw_name32,
          lv_name_80   TYPE sfw_name80,
          lt_parent_bf TYPE sfw_bf_sw_outtab,
          lt_conflicts TYPE sfw_confl_outtab.


    IF zif_abapgit_object~exists( ) = abap_false.
      RETURN.
    ENDIF.

    lo_switch = get( ).

    ls_header = lo_switch->get_header_data( ).
    CLEAR: ls_header-author,
           ls_header-createdon,
           ls_header-changedby,
           ls_header-changedon,
           ls_header-timestamp.

    lo_switch->get_texts(
      IMPORTING
        p_32 = lv_name_32
        p_80 = lv_name_80 ).

    lt_parent_bf = lo_switch->get_parent_bf( ).
    lt_conflicts = lo_switch->get_conflicts( ).

    io_xml->add( ig_data = ls_header
                 iv_name = 'HEADER' ).
    io_xml->add( ig_data = lv_name_32
                 iv_name = 'NAME32' ).
    io_xml->add( ig_data = lv_name_80
                 iv_name = 'NAME80' ).

    io_xml->add( ig_data = lt_parent_bf
                 iv_name = 'PARENT_BF' ).
    io_xml->add( ig_data = lt_conflicts
                 iv_name = 'CONFLICTS' ).

  ENDMETHOD.