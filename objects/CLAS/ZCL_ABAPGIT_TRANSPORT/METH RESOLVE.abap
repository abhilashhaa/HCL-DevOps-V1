  METHOD resolve.
    DATA: lv_object     TYPE tadir-object,
          lv_obj_name   TYPE tadir-obj_name,
          lv_trobj_name TYPE trobj_name,
          ls_tadir      TYPE zif_abapgit_definitions=>ty_tadir.

    FIELD-SYMBOLS: <ls_request> LIKE LINE OF it_requests,
                   <ls_object>  LIKE LINE OF <ls_request>-objects.


    LOOP AT it_requests ASSIGNING <ls_request>.
      LOOP AT <ls_request>-objects ASSIGNING <ls_object>.
        " VARX, see https://github.com/abapGit/abapGit/issues/3107
        IF <ls_object>-pgmid = 'LIMU' AND <ls_object>-object <> 'VARX'.
          CALL FUNCTION 'GET_R3TR_OBJECT_FROM_LIMU_OBJ'
            EXPORTING
              p_limu_objtype = <ls_object>-object
              p_limu_objname = <ls_object>-obj_name
            IMPORTING
              p_r3tr_objtype = lv_object
              p_r3tr_objname = lv_trobj_name
            EXCEPTIONS
              no_mapping     = 1
              OTHERS         = 2.
          IF sy-subrc <> 0.
            zcx_abapgit_exception=>raise( 'error from GET_R3TR_OBJECT_FROM_LIMU_OBJ' ).
          ENDIF.
          lv_obj_name = lv_trobj_name.
        ELSE.
          lv_object   = <ls_object>-object.
          lv_obj_name = <ls_object>-obj_name.
        ENDIF.

        ls_tadir = zcl_abapgit_factory=>get_tadir( )->read_single(
          iv_object   = lv_object
          iv_obj_name = lv_obj_name ).

        APPEND ls_tadir TO rt_tadir.
      ENDLOOP.
    ENDLOOP.

    SORT rt_tadir BY object ASCENDING obj_name ASCENDING.
    DELETE ADJACENT DUPLICATES FROM rt_tadir COMPARING object obj_name.
    DELETE rt_tadir WHERE table_line IS INITIAL.
  ENDMETHOD.