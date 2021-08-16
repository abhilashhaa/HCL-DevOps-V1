  METHOD update_where_used.

    DATA: lv_class    LIKE LINE OF gt_classes,
          lo_cross    TYPE REF TO cl_wb_crossreference,
          lv_include  TYPE programm,
          li_progress TYPE REF TO zif_abapgit_progress.


    li_progress = zcl_abapgit_progress=>get_instance( lines( gt_classes ) ).

    LOOP AT gt_classes INTO lv_class.
      IF sy-tabix MOD 20 = 0.
        li_progress->show(
          iv_current = sy-tabix
          iv_text    = 'Updating where-used lists' ).
      ENDIF.

      lv_include = cl_oo_classname_service=>get_classpool_name( lv_class ).

      CREATE OBJECT lo_cross
        EXPORTING
          p_name    = lv_include
          p_include = lv_include.

      lo_cross->index_actualize( ).
    ENDLOOP.

  ENDMETHOD.