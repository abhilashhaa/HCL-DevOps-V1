  METHOD get_package.
    IF me->zif_abapgit_object~exists( ) = abap_true.
      ri_package = load_package( mv_local_devclass ).
    ENDIF.
  ENDMETHOD.