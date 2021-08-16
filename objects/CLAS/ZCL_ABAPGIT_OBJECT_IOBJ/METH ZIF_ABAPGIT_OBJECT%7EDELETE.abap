  METHOD zif_abapgit_object~delete.

    TYPES: BEGIN OF t_iobj,
             objnm TYPE c LENGTH 30.
    TYPES END OF t_iobj.

    DATA: lt_iobjname     TYPE STANDARD TABLE OF t_iobj,
          lv_subrc        TYPE sy-subrc,
          lv_object       TYPE string,
          lv_object_class TYPE string,
          lv_transp_pkg   TYPE abap_bool.

    lv_transp_pkg = zcl_abapgit_factory=>get_sap_package( iv_package )->are_changes_recorded_in_tr_req( ).

    APPEND ms_item-obj_name TO lt_iobjname.

    CALL FUNCTION 'RSDG_IOBJ_MULTI_DELETE'
      EXPORTING
        i_t_iobjnm = lt_iobjname
      IMPORTING
        e_subrc    = lv_subrc.

    IF lv_subrc <> 0.
      zcx_abapgit_exception=>raise( |Error when deleting InfoObject { ms_item-obj_name }| ).
    ENDIF.

    IF lv_transp_pkg = abap_true.

      lv_object_class = ms_item-obj_type.
      lv_object       = ms_item-obj_name.

      CALL FUNCTION 'RS_CORR_INSERT'
        EXPORTING
          object              = lv_object
          object_class        = lv_object_class
          master_language     = mv_language
          global_lock         = abap_true
          mode                = 'D'
          suppress_dialog     = abap_true
        EXCEPTIONS
          cancelled           = 1
          permission_failure  = 2
          unknown_objectclass = 3
          OTHERS              = 4.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise_t100( ).
      ENDIF.

    ENDIF.

  ENDMETHOD.