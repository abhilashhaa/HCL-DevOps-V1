  METHOD update_where_used.
* make extra sure the where-used list is updated after deletion
* Experienced some problems with the T00 include
* this method just tries to update everything

    DATA: lv_include LIKE LINE OF it_includes,
          lo_cross   TYPE REF TO cl_wb_crossreference.


    LOOP AT it_includes INTO lv_include.

      CREATE OBJECT lo_cross
        EXPORTING
          p_name    = lv_include
          p_include = lv_include.

      lo_cross->index_actualize( ).

    ENDLOOP.

  ENDMETHOD.