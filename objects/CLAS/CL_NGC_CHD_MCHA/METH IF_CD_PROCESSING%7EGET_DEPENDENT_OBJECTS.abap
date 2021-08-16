  METHOD if_cd_processing~get_dependent_objects.

    CONSTANTS: lc_object_table_batch_chd TYPE tabelle VALUE 'MCHA'. " Change Document Object Table for Batches

    DATA:
      lv_object_table_batch TYPE tabelle,
      lt_object_id_tmp      TYPE cdobjectv_range_tab,
      lv_parent_key         TYPE cdobjectv.

    " Get the actual Object Table of the Batches
    CALL FUNCTION 'VB_BATCH_DEFINITION'
      IMPORTING
        obtab = lv_object_table_batch.

    lt_object_id_tmp = it_object_id.

    " Convert Object ID from format stored in change document to 'normal' format
    LOOP AT lt_object_id_tmp ASSIGNING FIELD-SYMBOL(<ls_object_id_tmp>).
      " convert 'low' value in the range table
      convert_object_id(
        EXPORTING
          iv_object_table_from = lc_object_table_batch_chd
          iv_object_table_to   = lv_object_table_batch
        CHANGING
          cv_object_id         = <ls_object_id_tmp>-low
      ).
      " convert 'high' value in the range table
      convert_object_id(
        EXPORTING
          iv_object_table_from = lc_object_table_batch_chd
          iv_object_table_to   = lv_object_table_batch
        CHANGING
          cv_object_id         = <ls_object_id_tmp>-high
      ).
    ENDLOOP.

    " Get Classification change document objects
    cl_ngc_chd_util=>get_instance( )->get_clf_object(
      EXPORTING
        it_object_id    = lt_object_id_tmp
        iv_object_table = lv_object_table_batch
      CHANGING
        ct_clf_object   = rt_additional_object
    ).

    " Convert Object ID from 'normal' format to format stored in change document
    LOOP AT rt_additional_object ASSIGNING FIELD-SYMBOL(<ls_additional_object>).
      lv_parent_key = <ls_additional_object>-parent_key.
      convert_object_id(
        EXPORTING
          iv_object_table_from = lv_object_table_batch
          iv_object_table_to   = lc_object_table_batch_chd
        CHANGING
          cv_object_id         = lv_parent_key
      ).
      <ls_additional_object>-parent_key = lv_parent_key.
    ENDLOOP.

  ENDMETHOD.