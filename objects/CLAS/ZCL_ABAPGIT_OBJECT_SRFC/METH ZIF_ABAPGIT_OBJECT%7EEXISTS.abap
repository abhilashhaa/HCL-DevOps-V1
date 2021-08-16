  METHOD zif_abapgit_object~exists.

    DATA: li_object_data  TYPE REF TO if_wb_object_data_model,
          li_srfc_persist TYPE REF TO if_wb_object_persist.

    TRY.
        CREATE OBJECT li_srfc_persist TYPE ('CL_UCONRFC_OBJECT_PERSIST').

        li_srfc_persist->get(
          EXPORTING
            p_object_key  = |{ ms_item-obj_name }|
            p_version     = 'A'
          CHANGING
            p_object_data = li_object_data ).

      CATCH cx_root.
        rv_bool = abap_false.
        RETURN.
    ENDTRY.

    rv_bool = abap_true.

  ENDMETHOD.