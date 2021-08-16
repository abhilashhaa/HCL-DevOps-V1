  METHOD if_ngc_bil_chr~create_charc_rstr_direct.

    DATA:
      lt_create_from_charc TYPE if_ngc_bil_chr_c=>lty_clfncharcrstrcntp-t_create.


    CLEAR: et_failed, et_mapped, et_reported.


    LOOP AT it_create INTO DATA(ls_create)
      GROUP BY
        ( charcinternalid = ls_create-charcinternalid )
      REFERENCE INTO DATA(ls_create_group).

      APPEND INITIAL LINE TO lt_create_from_charc ASSIGNING FIELD-SYMBOL(<ls_create_from_charc>).
      <ls_create_from_charc>-charcinternalid = ls_create_group->charcinternalid.

      LOOP AT GROUP ls_create_group ASSIGNING FIELD-SYMBOL(<ls_create>).
        APPEND INITIAL LINE TO <ls_create_from_charc>-%target ASSIGNING FIELD-SYMBOL(<ls_target>).
        <ls_target> = CORRESPONDING #( <ls_create> ).
      ENDLOOP.
    ENDLOOP.

    me->if_ngc_bil_chr~create_charc_rstr(
      EXPORTING
        it_create   = lt_create_from_charc
      IMPORTING
        et_failed   = et_failed
        et_mapped   = et_mapped
        et_reported = et_reported ).

  ENDMETHOD.