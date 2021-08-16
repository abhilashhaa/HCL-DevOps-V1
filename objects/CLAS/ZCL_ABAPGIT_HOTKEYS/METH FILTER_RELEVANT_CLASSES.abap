  METHOD filter_relevant_classes.

    DATA lv_this_class_name TYPE seoclsname.
    DATA lv_this_class_pkg TYPE devclass.
    DATA lv_class_pkg TYPE devclass.
    DATA lo_dummy TYPE REF TO zcl_abapgit_hotkeys.

    FIELD-SYMBOLS <ls_class> LIKE LINE OF it_classes.

    lv_this_class_name = get_referred_class_name( lo_dummy ).
    lv_this_class_pkg = get_class_package( lv_this_class_name ).

    LOOP AT it_classes ASSIGNING <ls_class>.
      lv_class_pkg = get_class_package( <ls_class>-clsname ).
      IF lv_class_pkg = lv_this_class_pkg.
        APPEND <ls_class> TO rt_classes.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.