CLASS ltc_convert_clf_message DEFINITION
  FOR TESTING
  FINAL
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA:
      mo_cut TYPE REF TO cl_ngc_util_message.

    METHODS:
      setup.

    METHODS:
      from_core_chr FOR TESTING,
      from_core_cls FOR TESTING.

ENDCLASS.

CLASS ltc_convert_clf_message IMPLEMENTATION.

  METHOD setup.

    mo_cut = NEW #( ).

  ENDMETHOD.

  METHOD from_core_chr.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->convert_msg_corechr_to_coreclf(
      EXPORTING
        it_core_charc_msg = VALUE #(
          ( msgty    = 'E'
            msgid    = 'MSG'
            msgno    = '001'
            msgv1    = 'VALUE 1'
            key_date = '20180529' )
          ( msgty    = 'W'
            msgid    = 'MSG'
            msgno    = '002'
            msgv1    = 'VALUE 1'
            msgv2    = 'VALUE 2'
            msgv3    = 'VALUE 3'
            msgv4    = 'VALUE 4'
            key_date = '20180101' ) )
        is_classification_key = VALUE #( object_key = 'OBJECT' technical_object = 'MARA' key_date = '20180530' change_number = 'CHNG' )
      IMPORTING
        et_core_classification_msg = DATA(lt_core_clf_msg) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    DATA(lt_core_clf_msg_exp) = VALUE ngct_core_classification_msg(
      ( object_key       = 'OBJECT'
        technical_object = 'MARA'
        change_number    = 'CHNG'
        msgty            = 'E'
        msgid            = 'MSG'
        msgno            = '001'
        msgv1            = 'VALUE 1'
        key_date         = '20180530' )
      ( object_key       = 'OBJECT'
        technical_object = 'MARA'
        change_number    = 'CHNG'
        msgty            = 'W'
        msgid            = 'MSG'
        msgno            = '002'
        msgv1            = 'VALUE 1'
        msgv2            = 'VALUE 2'
        msgv3            = 'VALUE 3'
        msgv4            = 'VALUE 4'
        key_date         = '20180530' ) ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_core_clf_msg
      exp = lt_core_clf_msg_exp
      msg = 'Messages not converted as expected' ).

  ENDMETHOD.

  METHOD from_core_cls.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->convert_msg_corecls_to_coreclf(
      EXPORTING
        it_core_class_msg = VALUE #(
          ( msgty    = 'E'
            msgid    = 'MSG'
            msgno    = '001'
            msgv1    = 'VALUE 1'
            key_date = '20180529' )
          ( msgty    = 'W'
            msgid    = 'MSG'
            msgno    = '002'
            msgv1    = 'VALUE 1'
            msgv2    = 'VALUE 2'
            msgv3    = 'VALUE 3'
            msgv4    = 'VALUE 4'
            key_date = '20180101' ) )
        is_classification_key = VALUE #( object_key = 'OBJECT' technical_object = 'MARA' key_date = '20180530' change_number = 'CHNG' )
      IMPORTING
        et_core_classification_msg = DATA(lt_core_clf_msg) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    DATA(lt_core_clf_msg_exp) = VALUE ngct_core_classification_msg(
      ( object_key       = 'OBJECT'
        technical_object = 'MARA'
        change_number    = 'CHNG'
        msgty            = 'E'
        msgid            = 'MSG'
        msgno            = '001'
        msgv1            = 'VALUE 1'
        key_date         = '20180530' )
      ( object_key       = 'OBJECT'
        technical_object = 'MARA'
        change_number    = 'CHNG'
        msgty            = 'W'
        msgid            = 'MSG'
        msgno            = '002'
        msgv1            = 'VALUE 1'
        msgv2            = 'VALUE 2'
        msgv3            = 'VALUE 3'
        msgv4            = 'VALUE 4'
        key_date         = '20180530' ) ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_core_clf_msg
      exp = lt_core_clf_msg_exp
      msg = 'Messages not converted as expected' ).

  ENDMETHOD.

ENDCLASS.