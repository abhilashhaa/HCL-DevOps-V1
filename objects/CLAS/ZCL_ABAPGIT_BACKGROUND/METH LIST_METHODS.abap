  METHOD list_methods.

    DATA: ls_method       LIKE LINE OF rt_methods,
          ls_key          TYPE seoclskey,
          lt_implementing TYPE seor_implementing_keys,
          ls_implementing LIKE LINE OF lt_implementing.

    FIELD-SYMBOLS: <ls_method> LIKE LINE OF rt_methods.


* in order to handle local classes in the compiled report
    ls_method-class = 'ZCL_ABAPGIT_BACKGROUND_PULL'.
    INSERT ls_method INTO TABLE rt_methods.
    ls_method-class = 'ZCL_ABAPGIT_BACKGROUND_PUSH_AU'.
    INSERT ls_method INTO TABLE rt_methods.
    ls_method-class = 'ZCL_ABAPGIT_BACKGROUND_PUSH_FI'.
    INSERT ls_method INTO TABLE rt_methods.

    ls_key-clsname = 'ZIF_ABAPGIT_BACKGROUND'.

    CALL FUNCTION 'SEO_INTERFACE_IMPLEM_GET_ALL'
      EXPORTING
        intkey       = ls_key
      IMPORTING
        impkeys      = lt_implementing
      EXCEPTIONS
        not_existing = 1
        OTHERS       = 2 ##FM_SUBRC_OK.
    LOOP AT lt_implementing INTO ls_implementing.
      ls_method-class = ls_implementing-clsname.
      INSERT ls_method INTO TABLE rt_methods.
    ENDLOOP.

    LOOP AT rt_methods ASSIGNING <ls_method>.
      CALL METHOD (<ls_method>-class)=>zif_abapgit_background~get_description
        RECEIVING
          rv_description = <ls_method>-description.
    ENDLOOP.

  ENDMETHOD.