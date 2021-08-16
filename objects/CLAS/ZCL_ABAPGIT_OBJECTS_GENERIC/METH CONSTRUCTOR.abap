  METHOD constructor.

    CONSTANTS lc_logical_transport_object TYPE c LENGTH 1 VALUE 'L'.


    SELECT SINGLE * FROM objh INTO ms_object_header
      WHERE objectname = is_item-obj_type
      AND objecttype = lc_logical_transport_object.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Not found in OBJH, or not supported' ).
    ENDIF.

* object tables
    SELECT * FROM objsl INTO CORRESPONDING FIELDS OF TABLE mt_object_table
      WHERE objectname = is_item-obj_type
      AND objecttype = lc_logical_transport_object
      AND tobject = 'TABU'
      ORDER BY PRIMARY KEY.
    IF mt_object_table IS INITIAL.
      zcx_abapgit_exception=>raise( |Obviously corrupted object-type { is_item-obj_type }: No tables defined| ).
    ENDIF.
* only unique tables
    SORT mt_object_table BY tobj_name ASCENDING.
    DELETE ADJACENT DUPLICATES FROM mt_object_table COMPARING tobj_name.

* object methods
    SELECT * FROM objm INTO TABLE mt_object_method
      WHERE objectname = is_item-obj_type
      AND objecttype = lc_logical_transport_object
      ORDER BY PRIMARY KEY.

    ms_item = is_item.

  ENDMETHOD.