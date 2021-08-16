CLASS lcl_handler_charc DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    METHODS:
      modify FOR BEHAVIOR IMPORTING
        it_create     FOR CREATE a_clfncharacteristicforkeydate
        it_update     FOR UPDATE a_clfncharacteristicforkeydate
        it_delete     FOR DELETE a_clfncharacteristicforkeydate,
      read FOR BEHAVIOR IMPORTING it_charc FOR READ a_clfncharacteristicforkeydate RESULT et_charc.

ENDCLASS.

CLASS lcl_handler_charc IMPLEMENTATION.

  METHOD read.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_characteristic( ).

    DATA(lt_charc) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharctp-t_read_in( it_charc ).

    lo_bil_provider->read_charc(
      EXPORTING
        it_charc  = lt_charc
      IMPORTING
        et_charc  = DATA(lt_charc_result)
        et_failed = DATA(lt_clfncharc_failed) ).

    MOVE-CORRESPONDING lt_charc_result TO et_charc.
    MOVE-CORRESPONDING lt_clfncharc_failed TO failed-a_clfncharacteristicforkeydate.

  ENDMETHOD.

  METHOD modify.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_characteristic( ).

    DATA(lt_create) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharctp-t_create( it_create ).

    lo_bil_provider->create_charc(
      EXPORTING
        it_create   = lt_create
      IMPORTING
        et_failed   = DATA(lt_clfncharc_failed)
        et_reported = DATA(lt_clfncharc_reported)
        et_mapped   = DATA(lt_clfncharc_mapped) ).

    MOVE-CORRESPONDING lt_clfncharc_failed TO failed-a_clfncharacteristicforkeydate.
    MOVE-CORRESPONDING lt_clfncharc_reported TO reported-a_clfncharacteristicforkeydate.
    MOVE-CORRESPONDING lt_clfncharc_mapped TO mapped-a_clfncharacteristicforkeydate.

    DATA(lt_delete) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharctp-t_delete( it_delete ).

    lo_bil_provider->delete_charc(
      EXPORTING
        it_delete   = lt_delete
      IMPORTING
        et_failed   = lt_clfncharc_failed
        et_reported = lt_clfncharc_reported ).

    MOVE-CORRESPONDING lt_clfncharc_failed TO failed-a_clfncharacteristicforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharc_reported TO reported-a_clfncharacteristicforkeydate KEEPING TARGET LINES.

    DATA(lt_update) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharctp-t_update( it_update ).

    lo_bil_provider->update_charc(
      EXPORTING
        it_update   = lt_update
      IMPORTING
        et_failed   = lt_clfncharc_failed
        et_reported = lt_clfncharc_reported ).

    MOVE-CORRESPONDING lt_clfncharc_failed TO failed-a_clfncharacteristicforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharc_reported TO reported-a_clfncharacteristicforkeydate KEEPING TARGET LINES.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_handler_charcdesc DEFINITION INHERITING FROM cl_abap_behavior_handler
  AFTER lcl_handler_charc.
  PRIVATE SECTION.
    METHODS:
      modify FOR BEHAVIOR IMPORTING
        it_create        FOR CREATE a_clfncharacteristicforkeydate\_CharacteristicDesc
        it_create_direct FOR CREATE a_clfncharcdescforkeydate
        it_update        FOR UPDATE a_clfncharcdescforkeydate
        it_delete        FOR DELETE a_clfncharcdescforkeydate,
     read FOR BEHAVIOR IMPORTING it_charc_desc FOR READ a_clfncharcdescforkeydate RESULT et_charc_desc,
     read_by_charc FOR READ
        IMPORTING it_create FOR READ a_clfncharacteristicforkeydate\_CharacteristicDesc
           FULL iv_full
         RESULT et_charc_desc
           LINK et_link.
ENDCLASS.

CLASS lcl_handler_charcdesc IMPLEMENTATION.

  METHOD read_by_charc.
  ENDMETHOD.

  METHOD read.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_characteristic( ).
    DATA(lt_charc_desc) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcdesctp-t_read_in( it_charc_desc ).

    lo_bil_provider->read_charc_desc(
      EXPORTING
        it_charc_desc = lt_charc_desc
      IMPORTING
        et_charc_desc = DATA(lt_charc_desc_result)
        et_failed     = DATA(lt_clfncharcdesc_failed) ).

    MOVE-CORRESPONDING lt_charc_desc_result TO et_charc_desc.
    MOVE-CORRESPONDING lt_clfncharcdesc_failed TO failed-a_clfncharcdescforkeydate.

  ENDMETHOD.

  METHOD modify.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_characteristic( ).
    DATA(lt_create) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcdesctp-t_create( it_create ) ##BEHV_TYPE.

    lo_bil_provider->create_charc_desc(
      EXPORTING
        it_create   = lt_create
      IMPORTING
        et_failed   = DATA(lt_clfncharcdesc_failed)
        et_reported = DATA(lt_clfncharcdesc_reported)
        et_mapped   = DATA(lt_clfncharcdesc_mapped) ).

    MOVE-CORRESPONDING lt_clfncharcdesc_failed TO failed-a_clfncharcdescforkeydate.
    MOVE-CORRESPONDING lt_clfncharcdesc_reported TO reported-a_clfncharcdescforkeydate.
    MOVE-CORRESPONDING lt_clfncharcdesc_mapped TO mapped-a_clfncharcdescforkeydate.

    DATA(lt_create_direct) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcdesctp-t_create_direct( it_create_direct ).

    lo_bil_provider->create_charc_desc_direct(
      EXPORTING
        it_create   = lt_create_direct
      IMPORTING
        et_failed   = lt_clfncharcdesc_failed
        et_reported = lt_clfncharcdesc_reported
        et_mapped   = lt_clfncharcdesc_mapped ).

    MOVE-CORRESPONDING lt_clfncharcdesc_failed TO failed-a_clfncharcdescforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcdesc_reported TO reported-a_clfncharcdescforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcdesc_mapped TO mapped-a_clfncharcdescforkeydate KEEPING TARGET LINES.

    DATA(lt_delete) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcdesctp-t_delete( it_delete ).

    lo_bil_provider->delete_charc_desc(
      EXPORTING
        it_delete   = lt_delete
      IMPORTING
        et_failed   = lt_clfncharcdesc_failed
        et_reported = lt_clfncharcdesc_reported ).

    MOVE-CORRESPONDING lt_clfncharcdesc_failed TO failed-a_clfncharcdescforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcdesc_reported TO reported-a_clfncharcdescforkeydate KEEPING TARGET LINES.

    DATA(lt_update) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcdesctp-t_update( it_update ).

    lo_bil_provider->update_charc_desc(
      EXPORTING
        it_update   = lt_update
      IMPORTING
        et_failed   = lt_clfncharcdesc_failed
        et_reported = lt_clfncharcdesc_reported ).

    MOVE-CORRESPONDING lt_clfncharcdesc_failed TO failed-a_clfncharcdescforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcdesc_reported TO reported-a_clfncharcdescforkeydate KEEPING TARGET LINES.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_handler_charcrstr DEFINITION INHERITING FROM cl_abap_behavior_handler
  AFTER lcl_handler_charc.
  PRIVATE SECTION.
    METHODS:
      modify FOR BEHAVIOR IMPORTING
        it_create        FOR CREATE a_clfncharacteristicforkeydate\_CharacteristicRestriction
        it_create_direct FOR CREATE a_clfncharcrstrcnforkeydate
        it_delete        FOR DELETE a_clfncharcrstrcnforkeydate,
      read FOR BEHAVIOR IMPORTING it_charc_rstr FOR READ a_clfncharcrstrcnforkeydate RESULT et_charc_rstr,
      read_by_charc FOR READ
        IMPORTING  it_create FOR READ a_clfncharacteristicforkeydate\_CharacteristicRestriction
           FULL iv_full
         RESULT et_charc_rstr
           LINK et_link.
ENDCLASS.

CLASS lcl_handler_charcrstr IMPLEMENTATION.

  METHOD read_by_charc.
  ENDMETHOD.

  METHOD read.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_characteristic( ).

    DATA(lt_charc_rstr) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcrstrcntp-t_read_in( it_charc_rstr ).

    lo_bil_provider->read_charc_rstr(
      EXPORTING
        it_charc_rstr = lt_charc_rstr
      IMPORTING
        et_charc_rstr = DATA(lt_charc_rstr_result)
        et_failed     = DATA(lt_failed) ).

    MOVE-CORRESPONDING lt_charc_rstr_result TO et_charc_rstr.
    MOVE-CORRESPONDING lt_failed TO failed-a_clfncharcrstrcnforkeydate.

  ENDMETHOD.

  METHOD modify.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_characteristic( ).

    DATA(lt_create) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcrstrcntp-t_create( it_create ) ##BEHV_TYPE.

    lo_bil_provider->create_charc_rstr(
      EXPORTING
        it_create   = lt_create
      IMPORTING
        et_failed   = DATA(lt_clfncharcrstr_failed)
        et_reported = DATA(lt_clfncharcrstr_reported)
        et_mapped   = DATA(lt_clfncharcrstr_mapped) ).

    MOVE-CORRESPONDING lt_clfncharcrstr_failed TO failed-a_clfncharcrstrcnforkeydate.
    MOVE-CORRESPONDING lt_clfncharcrstr_reported TO reported-a_clfncharcrstrcnforkeydate.
    MOVE-CORRESPONDING lt_clfncharcrstr_mapped TO mapped-a_clfncharcrstrcnforkeydate.

    DATA(lt_create_direct) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcrstrcntp-t_create_direct( it_create_direct ).

    lo_bil_provider->create_charc_rstr_direct(
      EXPORTING
        it_create   = lt_create_direct
      IMPORTING
        et_failed   = lt_clfncharcrstr_failed
        et_reported = lt_clfncharcrstr_reported
        et_mapped   = lt_clfncharcrstr_mapped ).

    MOVE-CORRESPONDING lt_clfncharcrstr_failed TO failed-a_clfncharcrstrcnforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcrstr_reported TO reported-a_clfncharcrstrcnforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcrstr_mapped TO mapped-a_clfncharcrstrcnforkeydate KEEPING TARGET LINES.

    DATA(lt_delete) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcrstrcntp-t_delete( it_delete ).

    lo_bil_provider->delete_charc_rstr(
      EXPORTING
        it_delete   = lt_delete
      IMPORTING
        et_failed   = lt_clfncharcrstr_failed
        et_reported = lt_clfncharcrstr_reported ).

    MOVE-CORRESPONDING lt_clfncharcrstr_failed TO failed-a_clfncharcrstrcnforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcrstr_reported TO reported-a_clfncharcrstrcnforkeydate KEEPING TARGET LINES.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_handler_charcref DEFINITION INHERITING FROM cl_abap_behavior_handler
  AFTER lcl_handler_charc.
  PRIVATE SECTION.
    METHODS:
      modify FOR BEHAVIOR IMPORTING
        it_create        FOR CREATE a_clfncharacteristicforkeydate\_CharacteristicReference
        it_create_direct FOR CREATE a_clfncharcrefforkeydate
        it_delete        FOR DELETE a_clfncharcrefforkeydate,
      read FOR BEHAVIOR IMPORTING it_charc_ref FOR READ a_clfncharcrefforkeydate RESULT et_charc_ref,
      read_by_charc FOR READ
        IMPORTING it_create FOR READ a_clfncharacteristicforkeydate\_CharacteristicReference
           FULL iv_full
         RESULT et_charc_ref
           LINK et_link.
ENDCLASS.

CLASS lcl_handler_charcref IMPLEMENTATION.

  METHOD read_by_charc.
  ENDMETHOD.

  METHOD read.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_characteristic( ).

    DATA(lt_charc_ref) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcreftp-t_read_in( it_charc_ref ).

    lo_bil_provider->read_charc_ref(
      EXPORTING
        it_charc_ref = lt_charc_ref
      IMPORTING
        et_charc_ref = DATA(lt_charc_ref_result)
        et_failed    = DATA(lt_charc_ref_failed) ).

    MOVE-CORRESPONDING lt_charc_ref_result TO et_charc_ref.
    MOVE-CORRESPONDING lt_charc_ref_failed TO failed-a_clfncharcrefforkeydate.

  ENDMETHOD.

  METHOD modify.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_characteristic( ).

    DATA(lt_create) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcreftp-t_create( it_create ) ##BEHV_TYPE.

    lo_bil_provider->create_charc_ref(
      EXPORTING
        it_create   = lt_create
      IMPORTING
        et_failed   = DATA(lt_clfncharcref_failed)
        et_reported = DATA(lt_clfncharcref_reported)
        et_mapped   = DATA(lt_clfncharcref_mapped) ).

    MOVE-CORRESPONDING lt_clfncharcref_failed TO failed-a_clfncharcrefforkeydate.
    MOVE-CORRESPONDING lt_clfncharcref_reported TO reported-a_clfncharcrefforkeydate.
    MOVE-CORRESPONDING lt_clfncharcref_mapped TO mapped-a_clfncharcrefforkeydate.

    DATA(lt_create_direct) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcreftp-t_create_direct( it_create_direct ).

    lo_bil_provider->create_charc_ref_direct(
      EXPORTING
        it_create   = lt_create_direct
      IMPORTING
        et_failed   = lt_clfncharcref_failed
        et_reported = lt_clfncharcref_reported
        et_mapped   = lt_clfncharcref_mapped ).

    MOVE-CORRESPONDING lt_clfncharcref_failed TO failed-a_clfncharcrefforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcref_reported TO reported-a_clfncharcrefforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcref_mapped TO mapped-a_clfncharcrefforkeydate KEEPING TARGET LINES.

    DATA(lt_delete) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcreftp-t_delete( it_delete ).

    lo_bil_provider->delete_charc_ref(
      EXPORTING
        it_delete   = lt_delete
      IMPORTING
        et_failed   = lt_clfncharcref_failed
        et_reported = lt_clfncharcref_reported ).

    MOVE-CORRESPONDING lt_clfncharcref_failed TO failed-a_clfncharcrefforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcref_reported TO reported-a_clfncharcrefforkeydate KEEPING TARGET LINES.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_handler_charcval DEFINITION INHERITING FROM cl_abap_behavior_handler
  AFTER lcl_handler_charc.
  PRIVATE SECTION.
    METHODS:
      modify FOR BEHAVIOR IMPORTING
        it_create        FOR CREATE a_clfncharacteristicforkeydate\_CharacteristicValue
        it_create_direct FOR CREATE a_clfncharcvalueforkeydate
        it_delete        FOR DELETE a_clfncharcvalueforkeydate
        it_update        FOR UPDATE a_clfncharcvalueforkeydate,
      read FOR BEHAVIOR IMPORTING it_charc_val FOR READ a_clfncharcvalueforkeydate RESULT et_charc_val,
      read_by_charc FOR READ
        IMPORTING  it_create FOR READ a_clfncharacteristicforkeydate\_CharacteristicValue
           FULL iv_full
         RESULT et_charc_val
           LINK et_link.
ENDCLASS.

CLASS lcl_handler_charcval IMPLEMENTATION.

  METHOD read_by_charc.
  ENDMETHOD.

  METHOD read.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_characteristic( ).

    DATA(lt_charc_val) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcvaltp-t_read_in( it_charc_val ).

    lo_bil_provider->read_charc_val(
      EXPORTING
        it_charc_val = lt_charc_val
      IMPORTING
        et_charc_val = DATA(lt_charc_val_result)
        et_failed    = DATA(lt_clfncharcval_failed) ).

    MOVE-CORRESPONDING lt_charc_val_result TO et_charc_val.
    MOVE-CORRESPONDING lt_clfncharcval_failed TO failed-a_clfncharcvalueforkeydate.

  ENDMETHOD.

  METHOD modify.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_characteristic( ).

    DATA(lt_create) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcvaltp-t_create( it_create ) ##BEHV_TYPE.

    lo_bil_provider->create_charc_val(
      EXPORTING
        it_create   = lt_create
      IMPORTING
        et_failed   = DATA(lt_clfncharcval_failed)
        et_reported = DATA(lt_clfncharcval_reported)
        et_mapped   = DATA(lt_clfncharcval_mapped) ).

    MOVE-CORRESPONDING lt_clfncharcval_failed TO failed-a_clfncharcvalueforkeydate.
    MOVE-CORRESPONDING lt_clfncharcval_reported TO reported-a_clfncharcvalueforkeydate.
    MOVE-CORRESPONDING lt_clfncharcval_mapped TO mapped-a_clfncharcvalueforkeydate.

    DATA(lt_create_direct) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcvaltp-t_create_direct( it_create_direct ).

    lo_bil_provider->create_charc_val_direct(
      EXPORTING
        it_create   = lt_create_direct
      IMPORTING
        et_failed   = lt_clfncharcval_failed
        et_reported = lt_clfncharcval_reported
        et_mapped   = lt_clfncharcval_mapped ).

    MOVE-CORRESPONDING lt_clfncharcval_failed TO failed-a_clfncharcvalueforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcval_reported TO reported-a_clfncharcvalueforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcval_mapped TO mapped-a_clfncharcvalueforkeydate KEEPING TARGET LINES.

    DATA(lt_delete) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcvaltp-t_delete( it_delete ).

    lo_bil_provider->delete_charc_val(
      EXPORTING
        it_delete   = lt_delete
      IMPORTING
        et_failed   = lt_clfncharcval_failed
        et_reported = lt_clfncharcval_reported ).

    MOVE-CORRESPONDING lt_clfncharcval_failed TO failed-a_clfncharcvalueforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcval_reported TO reported-a_clfncharcvalueforkeydate KEEPING TARGET LINES.

    DATA(lt_update) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcvaltp-t_update( it_update ).

    lo_bil_provider->update_charc_val(
      EXPORTING
        it_update   = lt_update
      IMPORTING
        et_failed   = lt_clfncharcval_failed
        et_reported = lt_clfncharcval_reported ).

    MOVE-CORRESPONDING lt_clfncharcval_failed TO failed-a_clfncharcvalueforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcval_reported TO reported-a_clfncharcvalueforkeydate KEEPING TARGET LINES.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_handler_charcvaldesc DEFINITION INHERITING FROM cl_abap_behavior_handler
  AFTER lcl_handler_charcval.
  PRIVATE SECTION.
    METHODS:
      modify FOR BEHAVIOR IMPORTING
        it_create        FOR CREATE a_clfncharcvalueforkeydate\_CharcValueDesc
        it_create_direct FOR CREATE a_clfncharcvaluedescforkeydate
        it_delete        FOR DELETE a_clfncharcvaluedescforkeydate
        it_update        FOR UPDATE a_clfncharcvaluedescforkeydate,
      read FOR BEHAVIOR IMPORTING it_charc_val_desc FOR READ a_clfncharcvaluedescforkeydate RESULT et_charc_val_desc,
      read_by_charc FOR READ
        IMPORTING it_create FOR READ a_clfncharcvalueforkeydate\_CharcValueDesc
           FULL iv_full
         RESULT et_charc_val_desc
           LINK et_link.
ENDCLASS.

CLASS lcl_handler_charcvaldesc IMPLEMENTATION.

  METHOD read_by_charc.
  ENDMETHOD.

  METHOD read.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_characteristic( ).

    DATA(lt_charc_val_desc) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcvaldesctp-t_read_in( it_charc_val_desc ).

    lo_bil_provider->read_charc_val_desc(
      EXPORTING
        it_charc_val_desc = lt_charc_val_desc
      IMPORTING
        et_charc_val_desc = DATA(lt_charc_val_desc_result)
        et_failed         = DATA(lt_clfncharcvaldesc_failed) ).

    MOVE-CORRESPONDING lt_charc_val_desc_result TO et_charc_val_desc.
    MOVE-CORRESPONDING lt_clfncharcvaldesc_failed TO failed-a_clfncharcvaluedescforkeydate.

  ENDMETHOD.

  METHOD modify.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_characteristic( ).

    DATA(lt_create) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcvaldesctp-t_create( it_create ) ##BEHV_TYPE.

    lo_bil_provider->create_charc_val_desc(
      EXPORTING
        it_create   = lt_create
      IMPORTING
        et_failed   = DATA(lt_clfncharcvaldesc_failed)
        et_reported = DATA(lt_clfncharcvaldesc_reported)
        et_mapped   = DATA(lt_clfncharcvaldesc_mapped) ).

    MOVE-CORRESPONDING lt_clfncharcvaldesc_failed TO failed-a_clfncharcvaluedescforkeydate.
    MOVE-CORRESPONDING lt_clfncharcvaldesc_reported TO reported-a_clfncharcvaluedescforkeydate.
    MOVE-CORRESPONDING lt_clfncharcvaldesc_mapped TO mapped-a_clfncharcvaluedescforkeydate.

    DATA(lt_create_direct) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcvaldesctp-t_create_direct( it_create_direct ).

    lo_bil_provider->create_charc_val_desc_direct(
      EXPORTING
        it_create   = lt_create_direct
      IMPORTING
        et_failed   = lt_clfncharcvaldesc_failed
        et_reported = lt_clfncharcvaldesc_reported
        et_mapped   = lt_clfncharcvaldesc_mapped ).

    MOVE-CORRESPONDING lt_clfncharcvaldesc_failed TO failed-a_clfncharcvaluedescforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcvaldesc_reported TO reported-a_clfncharcvaluedescforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcvaldesc_mapped TO mapped-a_clfncharcvaluedescforkeydate KEEPING TARGET LINES.

    DATA(lt_delete) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcvaldesctp-t_delete( it_delete ).

    lo_bil_provider->delete_charc_val_desc(
      EXPORTING
        it_delete   = lt_delete
      IMPORTING
        et_failed   = lt_clfncharcvaldesc_failed
        et_reported = lt_clfncharcvaldesc_reported ).

    MOVE-CORRESPONDING lt_clfncharcvaldesc_failed TO failed-a_clfncharcvaluedescforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcvaldesc_reported TO reported-a_clfncharcvaluedescforkeydate KEEPING TARGET LINES.

    DATA(lt_update) = CORRESPONDING if_ngc_bil_chr_c=>lty_clfncharcvaldesctp-t_update( it_update ).

    lo_bil_provider->update_charc_val_desc(
      EXPORTING
        it_update   = lt_update
      IMPORTING
        et_failed   = lt_clfncharcvaldesc_failed
        et_reported = lt_clfncharcvaldesc_reported ).

    MOVE-CORRESPONDING lt_clfncharcvaldesc_failed TO failed-a_clfncharcvaluedescforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfncharcvaldesc_reported TO reported-a_clfncharcvaluedescforkeydate KEEPING TARGET LINES.

  ENDMETHOD.
ENDCLASS.


CLASS lcl_saver DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS check_before_save REDEFINITION.
    METHODS save              REDEFINITION.
    METHODS adjust_numbers    REDEFINITION.
ENDCLASS.

CLASS lcl_saver IMPLEMENTATION.

  METHOD check_before_save.

    DATA:
      lo_bil_provider_transactional TYPE REF TO if_ngc_bil_chr_transactional.

    lo_bil_provider_transactional ?= cl_ngc_bil_factory=>get_characteristic( ).
    lo_bil_provider_transactional->check_before_save(
      IMPORTING
        et_charc_failed        = DATA(lt_charc_failed)
        et_charc_reported      = DATA(lt_charc_reported)
        et_charc_desc_failed   = DATA(lt_charc_desc_failed)
        et_charc_desc_reported = DATA(lt_charc_desc_reported) ).

    MOVE-CORRESPONDING lt_charc_failed TO failed-a_clfncharacteristicforkeydate.
    MOVE-CORRESPONDING lt_charc_reported TO reported-a_clfncharacteristicforkeydate.

    MOVE-CORRESPONDING lt_charc_desc_failed TO failed-a_clfncharcdescforkeydate.
    MOVE-CORRESPONDING lt_charc_desc_reported TO reported-a_clfncharcdescforkeydate.

  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD adjust_numbers.

    DATA:
      lo_bil_provider_transactional TYPE REF TO if_ngc_bil_chr_transactional.

    lo_bil_provider_transactional ?= cl_ngc_bil_factory=>get_characteristic( ).
    lo_bil_provider_transactional->adjust_numbers(
      IMPORTING
        et_charc_mapped      = DATA(lt_mapped_charc)
        et_charc_desc_mapped = DATA(lt_mapped_charc_desc)
        et_charc_ref_mapped  = DATA(lt_mapped_charc_ref)
        et_charc_rstr_mapped = DATA(lt_mapped_charc_rstr)
        et_charc_val_mapped  = DATA(lt_mapped_charc_val) ).

    MOVE-CORRESPONDING lt_mapped_charc TO mapped-a_clfncharacteristicforkeydate.
    MOVE-CORRESPONDING lt_mapped_charc_desc TO mapped-a_clfncharcdescforkeydate.
    MOVE-CORRESPONDING lt_mapped_charc_ref TO mapped-a_clfncharcrefforkeydate.
    MOVE-CORRESPONDING lt_mapped_charc_rstr TO mapped-a_clfncharcrstrcnforkeydate.
    MOVE-CORRESPONDING lt_mapped_charc_val TO mapped-a_clfncharcvalueforkeydate.

  ENDMETHOD.
ENDCLASS.