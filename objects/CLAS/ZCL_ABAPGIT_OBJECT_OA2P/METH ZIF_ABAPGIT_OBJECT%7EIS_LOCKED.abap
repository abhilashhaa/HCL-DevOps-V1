  METHOD zif_abapgit_object~is_locked.

    DATA: lv_profile_name TYPE eqegraarg,
          lv_lock_number  TYPE i,
          lt_locks        TYPE STANDARD TABLE OF seqg3.

    lv_profile_name = mv_profile.

    CALL FUNCTION 'ENQUEUE_READ'
      EXPORTING
        gclient = sy-mandt    " Client
        gname   = 'OA2C_PROFILES'    " Granularity name (-> table name)
        garg    = lv_profile_name    " Granularity value(->values of key fields)
      IMPORTING
        number  = lv_lock_number
      TABLES
        enq     = lt_locks.    " Number of chosen lock entries


    rv_is_locked = boolc( lv_lock_number > 0 ).

  ENDMETHOD.