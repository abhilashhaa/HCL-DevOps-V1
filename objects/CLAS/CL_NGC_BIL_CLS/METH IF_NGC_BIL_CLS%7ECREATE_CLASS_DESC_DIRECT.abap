  METHOD if_ngc_bil_cls~create_class_desc_direct.

    DATA:
      lt_create_from_class TYPE if_ngc_bil_cls_c=>lty_clfnclassdesctp-t_create.


    CLEAR: et_failed, et_mapped, et_reported.


    LOOP AT it_create INTO DATA(ls_create)
      GROUP BY
        ( classinternalid = ls_create-classinternalid )
      REFERENCE INTO DATA(ls_create_group).

      APPEND INITIAL LINE TO lt_create_from_class ASSIGNING FIELD-SYMBOL(<ls_create_from_class>).
      <ls_create_from_class>-classinternalid = ls_create_group->classinternalid.

      LOOP AT GROUP ls_create_group ASSIGNING FIELD-SYMBOL(<ls_create>).
        APPEND INITIAL LINE TO <ls_create_from_class>-%target ASSIGNING FIELD-SYMBOL(<ls_target>).
        <ls_target> = CORRESPONDING #( <ls_create> ).
      ENDLOOP.
    ENDLOOP.

    me->if_ngc_bil_cls~create_class_desc(
      EXPORTING
        it_create   = lt_create_from_class
      IMPORTING
        et_mapped   = et_mapped
        et_failed   = et_failed
        et_reported = et_reported
    ).

  ENDMETHOD.