  METHOD zif_abapgit_object~delete.

    DATA:
      lv_return_code TYPE i.

    CALL METHOD ('CL_FEATURE_TOGGLE_OBJECT')=>delete
      EXPORTING
        iv_toggle_id = mv_toggle_id
      RECEIVING
        rv_rc        = lv_return_code.

    IF lv_return_code <> 0.
      zcx_abapgit_exception=>raise( |Cannot delete feature toggle { mv_toggle_id }. |
                                 && |Error {  sy-subrc } from cl_feature_toggle_object=>delete| ).
    ENDIF.

  ENDMETHOD.