  METHOD zif_abapgit_object~delete.

    DATA:
      lr_area         TYPE REF TO object.

    CREATE OBJECT lr_area TYPE ('CL_NEW_AWB_AREA').

    CALL METHOD lr_area->('IF_RSAWBN_FOLDER_TREE~DELETE_NODE')
      EXPORTING
        i_nodename    = ms_item-obj_name
        i_with_dialog = ''.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error while deleting AREA: { ms_item-obj_name }| ).
    ENDIF.

  ENDMETHOD.