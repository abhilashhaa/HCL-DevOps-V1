  METHOD get_unnecessary_local_objs.

    DATA: lt_tadir        TYPE zif_abapgit_definitions=>ty_tadir_tt,
          lt_tadir_unique TYPE HASHED TABLE OF zif_abapgit_definitions=>ty_tadir
                               WITH UNIQUE KEY pgmid object obj_name,
          lt_status       TYPE zif_abapgit_definitions=>ty_results_tt,
          lv_package      TYPE zif_abapgit_persistence=>ty_repo-package.

    FIELD-SYMBOLS: <ls_status> TYPE zif_abapgit_definitions=>ty_result,
                   <ls_tadir>  TYPE zif_abapgit_definitions=>ty_tadir.



    " delete objects which are added locally but are not in remote repo
    lt_status = io_repo->status( ).

    lv_package = io_repo->get_package( ).
    lt_tadir = zcl_abapgit_factory=>get_tadir( )->read( lv_package ).
    SORT lt_tadir BY pgmid ASCENDING object ASCENDING obj_name ASCENDING devclass ASCENDING.

    LOOP AT lt_status ASSIGNING <ls_status>
                      WHERE lstate = zif_abapgit_definitions=>c_state-added.

      READ TABLE lt_tadir ASSIGNING <ls_tadir>
                          WITH KEY pgmid    = 'R3TR'
                                   object   = <ls_status>-obj_type
                                   obj_name = <ls_status>-obj_name
                                   devclass = <ls_status>-package
                          BINARY SEARCH.
      IF sy-subrc <> 0.
* skip objects that does not exist locally
        CONTINUE.
      ENDIF.

      INSERT <ls_tadir> INTO TABLE lt_tadir_unique.

    ENDLOOP.

    rt_unnecessary_local_objects = lt_tadir_unique.

  ENDMETHOD.