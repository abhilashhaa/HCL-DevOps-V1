  METHOD zif_abapgit_oo_object_fnc~read_documentation.
    DATA: lv_state  TYPE dokstate,
          lv_object TYPE dokhl-object,
          lt_lines  TYPE tlinetab.

    lv_object = iv_class_name.

    CALL FUNCTION 'DOCU_GET'
      EXPORTING
        id                = 'CL'
        langu             = iv_language
        object            = lv_object
      IMPORTING
        dokstate          = lv_state
      TABLES
        line              = lt_lines
      EXCEPTIONS
        no_docu_on_screen = 1
        no_docu_self_def  = 2
        no_docu_temp      = 3
        ret_code          = 4
        OTHERS            = 5.
    IF sy-subrc = 0 AND lv_state = 'R'.
      rt_lines = lt_lines.
    ELSE.
      CLEAR rt_lines.
    ENDIF.
  ENDMETHOD.