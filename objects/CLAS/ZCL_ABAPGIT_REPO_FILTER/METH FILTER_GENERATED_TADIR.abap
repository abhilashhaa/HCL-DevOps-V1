  METHOD filter_generated_tadir.

    DATA: ls_tadir     TYPE zif_abapgit_definitions=>ty_tadir,
          ls_tadir_gen TYPE zif_abapgit_definitions=>ty_tadir,
          lv_cd_object TYPE cdobjectcl,
          lt_cd_names  TYPE STANDARD TABLE OF cdnames,
          ls_cd_names  TYPE cdnames,
          lt_tcdrs     TYPE STANDARD TABLE OF tcdrs,
          ls_tcdrs     TYPE tcdrs.

    LOOP AT ct_tadir INTO ls_tadir WHERE pgmid = 'R3TR' AND object = 'CHDO'.
      CLEAR: lv_cd_object, lt_cd_names, ls_tadir_gen, lt_tcdrs, ls_tcdrs.

      lv_cd_object = ls_tadir-obj_name.

      CALL FUNCTION 'CDNAMES_GET'
        EXPORTING
          iv_object        = lv_cd_object
        TABLES
          it_names         = lt_cd_names
          it_tcdrs         = lt_tcdrs
        EXCEPTIONS
          object_space     = 1
          object_not_found = 2
          OTHERS           = 3.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      LOOP AT lt_cd_names INTO ls_cd_names.
        DELETE ct_tadir WHERE pgmid = 'R3TR'
                          AND ( ( object = 'PROG'
                              AND ( obj_name = ls_cd_names-repnamec
                                 OR obj_name = ls_cd_names-repnamet
                                 OR obj_name = ls_cd_names-repnamefix
                                 OR obj_name = ls_cd_names-repnamevar ) )
                               OR object = 'FUGR' AND obj_name = ls_cd_names-fgrp ).
      ENDLOOP.

      LOOP AT lt_tcdrs INTO ls_tcdrs.
        DELETE ct_tadir WHERE pgmid = 'R3TR' AND object = 'TABL' AND obj_name = ls_tcdrs-tabname.
      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.