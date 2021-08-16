  METHOD upload.

    " We inherit from CL_APL_ECATT_UPLOAD because CL_APL_ECATT_SP_UPLOAD
    " doesn't exist in 702

    " Downport

    "26.03.2013

    DATA: lx_ecatt    TYPE REF TO cx_ecatt_apl,
          lv_exists   TYPE etonoff,
          lv_exc_occ  TYPE etonoff,
          ls_tadir    TYPE tadir,
          lo_ecatt_sp TYPE REF TO object.

    FIELD-SYMBOLS: <lg_ecatt_sp> TYPE any,
                   <lg_d_akh>    TYPE data,
                   <lg_i_akh>    TYPE data.

    TRY.
        ch_object-i_devclass = ch_object-d_devclass.

        ASSIGN COMPONENT 'D_AKH' OF STRUCTURE ch_object
               TO <lg_d_akh>. " doesn't exist in 702
        ASSIGN COMPONENT 'I_AKH' OF STRUCTURE ch_object
               TO <lg_i_akh>. " doesn't exist in 702
        IF <lg_d_akh> IS ASSIGNED AND <lg_i_akh> IS ASSIGNED.
          <lg_i_akh> = <lg_d_akh>.
        ENDIF.

        super->upload( CHANGING ch_object = ch_object ).

        upload_data_from_stream( ch_object-filename ).

      CATCH cx_ecatt_apl INTO lx_ecatt.
        IF template_over_all IS INITIAL.
          RAISE EXCEPTION lx_ecatt.
        ELSE.
          lv_exc_occ = 'X'.
        ENDIF.
    ENDTRY.

    TRY.
        CALL METHOD ('GET_ATTRIBUTES_FROM_DOM_NEW') " doesn't exist in 720
          CHANGING
            ch_object = ch_object.
      CATCH cx_ecatt_apl INTO lx_ecatt.
        lv_exc_occ = 'X'.
    ENDTRY.

    ASSIGN me->ecatt_object TO <lg_ecatt_sp>.
    ASSERT sy-subrc = 0.

    lo_ecatt_sp = <lg_ecatt_sp>.

    TRY.
        get_ecatt_sp( ).
      CATCH cx_ecatt_apl INTO lx_ecatt.
        lv_exc_occ = 'X'.
    ENDTRY.

    TRY.
        lv_exists = cl_apl_ecatt_object=>existence_check_object(
                      im_name               = ch_object-d_obj_name
                      im_version            = ch_object-d_obj_ver
                      im_obj_type           = ch_object-s_obj_type
                      im_exists_any_version = 'X' ).

        IF lv_exists = space.
          CALL METHOD lo_ecatt_sp->('SET_TADIR_FOR_NEW_OBJECT')
            EXPORTING
              im_tadir_for_new_object = tadir_preset.
        ENDIF.
      CATCH cx_ecatt.
        CLEAR lv_exists.
    ENDTRY.

    TRY.
        CALL METHOD lo_ecatt_sp->('SAVE')
          EXPORTING
            im_do_commit = 'X'.
      CATCH cx_ecatt_apl INTO lx_ecatt.
        lv_exc_occ = 'X'.
    ENDTRY.
* Devesh,C5129871  18.07.2011  Releasing enqueu after uploading
*begin
    TRY.
        ecatt_object->close_object( im_suppress_events = 'X' ).
      CATCH cx_ecatt_apl INTO lx_ecatt.
    ENDTRY.
*end
*     get devclass from existing object
    TRY.
        cl_apl_ecatt_object=>get_tadir_entry(
          EXPORTING im_obj_name = ch_object-d_obj_name
                    im_obj_type = ch_object-s_obj_type
          IMPORTING ex_tadir = ls_tadir ).

        ch_object-d_devclass = ls_tadir-devclass.

      CATCH cx_ecatt.
        CLEAR ls_tadir.
    ENDTRY.
    IF lv_exc_occ = 'X'.
      raise_upload_exception( previous = lx_ecatt ).
    ENDIF.

  ENDMETHOD.