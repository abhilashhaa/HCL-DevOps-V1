  METHOD zif_abapgit_object_enho~serialize.

    DATA: lo_enh_class TYPE REF TO cl_enh_tool_class,
          lt_owr       TYPE enhmeth_tabkeys,
          lt_pre       TYPE enhmeth_tabkeys,
          lt_post      TYPE enhmeth_tabkeys,
          lt_source    TYPE rswsourcet,
          lv_class     TYPE seoclsname,
          lv_shorttext TYPE string.


    lo_enh_class ?= ii_enh_tool.

    lv_shorttext = lo_enh_class->if_enh_object_docu~get_shorttext( ).
    lt_owr = lo_enh_class->get_owr_methods( ).
    lt_pre = lo_enh_class->get_pre_methods( ).
    lt_post = lo_enh_class->get_post_methods( ).
    lt_source = lo_enh_class->get_eimp_include( ).
    lo_enh_class->get_class( IMPORTING class_name = lv_class ).

    ii_xml->add( iv_name = 'TOOL'
                 ig_data = ii_enh_tool->get_tool( ) ).
    ii_xml->add( ig_data = lv_shorttext
                 iv_name = 'SHORTTEXT' ).
    ii_xml->add( iv_name = 'CLASS'
                 ig_data = lv_class ).
    ii_xml->add( iv_name = 'OWR_METHODS'
                 ig_data = lt_owr ).
    ii_xml->add( iv_name = 'PRE_METHODS'
                 ig_data = lt_pre ).
    ii_xml->add( iv_name = 'POST_METHODS'
                 ig_data = lt_post ).

    mo_files->add_abap( lt_source ).

    zcl_abapgit_object_enho_clif=>serialize(
      io_xml   = ii_xml
      io_files = mo_files
      io_clif  = lo_enh_class ).

    serialize_includes( lo_enh_class ).

  ENDMETHOD.