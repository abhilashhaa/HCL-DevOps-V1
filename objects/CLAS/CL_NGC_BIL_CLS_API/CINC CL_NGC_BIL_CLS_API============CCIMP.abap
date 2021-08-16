CLASS lcl_handler_class DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    METHODS:
      modify FOR BEHAVIOR IMPORTING
        it_create    FOR CREATE a_clfnclassforkeydate
        it_update    FOR UPDATE a_clfnclassforkeydate
        it_delete    FOR DELETE a_clfnclassforkeydate,
      read FOR BEHAVIOR IMPORTING it_class FOR READ a_clfnclassforkeydate RESULT et_class.

ENDCLASS.

CLASS lcl_handler_class IMPLEMENTATION.

  METHOD read.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_class( ).

    DATA(lt_class) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasstp-t_read_in( it_class ).

    lo_bil_provider->read_class(
      EXPORTING
        it_class  = lt_class
      IMPORTING
        et_class  = DATA(lt_class_result)
        et_failed = DATA(lt_failed) ).

    MOVE-CORRESPONDING lt_class_result TO et_class.
    MOVE-CORRESPONDING lt_failed TO failed-a_clfnclassforkeydate.

  ENDMETHOD.

  METHOD modify.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_class( ).

    DATA(lt_create) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasstp-t_create( it_create ).

    lo_bil_provider->create_class(
      EXPORTING
        it_create   = lt_create
      IMPORTING
        et_failed   = DATA(lt_clfnclass_failed)
        et_reported = DATA(lt_clfnclass_reported)
        et_mapped   = DATA(lt_clfnclass_mapped) ).

    MOVE-CORRESPONDING lt_clfnclass_failed TO failed-a_clfnclassforkeydate.
    MOVE-CORRESPONDING lt_clfnclass_reported TO reported-a_clfnclassforkeydate.
    MOVE-CORRESPONDING lt_clfnclass_mapped TO mapped-a_clfnclassforkeydate.

    DATA(lt_delete) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasstp-t_delete( it_delete ).

    lo_bil_provider->delete_class(
      EXPORTING
        it_delete   = lt_delete
      IMPORTING
        et_failed   = lt_clfnclass_failed
        et_reported = lt_clfnclass_reported ).

    MOVE-CORRESPONDING lt_clfnclass_failed TO failed-a_clfnclassforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclass_reported TO reported-a_clfnclassforkeydate KEEPING TARGET LINES.

    DATA(lt_update) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasstp-t_update( it_update ).

    lo_bil_provider->update_class(
      EXPORTING
        it_update   = lt_update
      IMPORTING
        et_failed   = lt_clfnclass_failed
        et_reported = lt_clfnclass_reported ).

    MOVE-CORRESPONDING lt_clfnclass_failed TO failed-a_clfnclassforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclass_reported TO reported-a_clfnclassforkeydate KEEPING TARGET LINES.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_handler_classcdesc DEFINITION INHERITING FROM cl_abap_behavior_handler
  AFTER lcl_handler_class.
  PRIVATE SECTION.
    METHODS:
      modify FOR BEHAVIOR IMPORTING
        it_create    FOR CREATE a_clfnclassforkeydate\_ClassDescription
        it_create_direct FOR CREATE a_clfnclassdescforkeydate
        it_update    FOR UPDATE a_clfnclassdescforkeydate,
     read FOR BEHAVIOR IMPORTING it_class_desc FOR READ a_clfnclassdescforkeydate RESULT et_class_desc,
     read_by_class FOR READ
        IMPORTING  it_create FOR READ a_clfnclassforkeydate\_ClassDescription
           FULL iv_full
         RESULT et_class_desc
           LINK et_link.
ENDCLASS.

CLASS lcl_handler_classcdesc IMPLEMENTATION.

  METHOD read_by_class.
  ENDMETHOD.

  METHOD read.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_class( ).

    DATA(lt_class_desc) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclassdesctp-t_read_in( it_class_desc ).

    lo_bil_provider->read_class_desc(
      EXPORTING
        it_class_desc = lt_class_desc
      IMPORTING
        et_class_desc = DATA(lt_class_desc_result)
        et_failed     = DATA(lt_failed) ).

    MOVE-CORRESPONDING lt_class_desc_result TO et_class_desc.
    MOVE-CORRESPONDING lt_failed TO failed-a_clfnclassdescforkeydate.

  ENDMETHOD.

  METHOD modify.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_class( ).

    DATA(lt_create) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclassdesctp-t_create( it_create ) ##BEHV_TYPE.

    lo_bil_provider->create_class_desc(
      EXPORTING
        it_create   = lt_create
      IMPORTING
        et_failed   = DATA(lt_clfnclassdesc_failed)
        et_reported = DATA(lt_clfnclassdesc_reported)
        et_mapped   = DATA(lt_clfnclassdesc_mapped) ).

    MOVE-CORRESPONDING lt_clfnclassdesc_failed TO failed-a_clfnclassdescforkeydate.
    MOVE-CORRESPONDING lt_clfnclassdesc_reported TO reported-a_clfnclassdescforkeydate.
    MOVE-CORRESPONDING lt_clfnclassdesc_mapped TO mapped-a_clfnclassdescforkeydate.

    DATA(lt_create_direct) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclassdesctp-t_create_direct( it_create_direct ).

    lo_bil_provider->create_class_desc_direct(
      EXPORTING
        it_create   = lt_create_direct
      IMPORTING
        et_failed   = lt_clfnclassdesc_failed
        et_reported = lt_clfnclassdesc_reported
        et_mapped   = lt_clfnclassdesc_mapped ).

    MOVE-CORRESPONDING lt_clfnclassdesc_failed TO failed-a_clfnclassdescforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclassdesc_reported TO reported-a_clfnclassdescforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclassdesc_mapped TO mapped-a_clfnclassdescforkeydate KEEPING TARGET LINES.

    DATA(lt_update) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclassdesctp-t_update( it_update ).

    lo_bil_provider->update_class_desc(
      EXPORTING
        it_update   = lt_update
      IMPORTING
        et_failed   = lt_clfnclassdesc_failed
        et_reported = lt_clfnclassdesc_reported ).

    MOVE-CORRESPONDING lt_clfnclassdesc_failed TO failed-a_clfnclassdescforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclassdesc_reported TO reported-a_clfnclassdescforkeydate KEEPING TARGET LINES.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_handler_classkeyword DEFINITION INHERITING FROM cl_abap_behavior_handler
  AFTER lcl_handler_classcdesc.
  PRIVATE SECTION.
    METHODS:
      modify FOR BEHAVIOR IMPORTING
        it_create    FOR CREATE a_clfnclassforkeydate\_ClassKeyword
        it_create_direct FOR CREATE a_clfnclasskeywordforkeydate
        it_delete    FOR DELETE a_clfnclasskeywordforkeydate
        it_update    FOR UPDATE a_clfnclasskeywordforkeydate,
     read FOR BEHAVIOR IMPORTING it_class_keyword FOR READ a_clfnclasskeywordforkeydate RESULT et_class_keyword,
     read_by_class FOR READ
        IMPORTING  it_create FOR READ a_clfnclassforkeydate\_ClassKeyword
           FULL iv_full
         RESULT et_class_keyword
           LINK et_link.
ENDCLASS.

CLASS lcl_handler_classkeyword IMPLEMENTATION.

  METHOD read_by_class.
  ENDMETHOD.

  METHOD read.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_class( ).

    DATA(lt_class_keyword) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasskeywordtp-t_read_in( it_class_keyword ).

    lo_bil_provider->read_class_keyword(
      EXPORTING
        it_class_keyword = lt_class_keyword
      IMPORTING
        et_class_keyword = DATA(lt_class_keyword_result)
        et_failed        = DATA(lt_failed) ).

    MOVE-CORRESPONDING lt_class_keyword_result TO et_class_keyword.
    MOVE-CORRESPONDING lt_failed TO failed-a_clfnclasskeywordforkeydate.

  ENDMETHOD.

  METHOD modify.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_class( ).

    DATA(lt_create) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasskeywordtp-t_create( it_create ) ##BEHV_TYPE.

    lo_bil_provider->create_class_keyword(
      EXPORTING
        it_create   = lt_create
      IMPORTING
        et_failed   = DATA(lt_clfnclasskeyword_failed)
        et_reported = DATA(lt_clfnclasskeyword_reported)
        et_mapped   = DATA(lt_clfnclasskeyword_mapped) ).

    MOVE-CORRESPONDING lt_clfnclasskeyword_failed TO failed-a_clfnclasskeywordforkeydate.
    MOVE-CORRESPONDING lt_clfnclasskeyword_reported TO reported-a_clfnclasskeywordforkeydate.
    MOVE-CORRESPONDING lt_clfnclasskeyword_mapped TO mapped-a_clfnclasskeywordforkeydate.

    DATA(lt_create_direct) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasskeywordtp-t_create_direct( it_create_direct ).

    lo_bil_provider->create_class_keyword_direct(
    EXPORTING
      it_create   = lt_create_direct
    IMPORTING
      et_failed   = lt_clfnclasskeyword_failed
      et_reported = lt_clfnclasskeyword_reported
      et_mapped   = lt_clfnclasskeyword_mapped ).

    MOVE-CORRESPONDING lt_clfnclasskeyword_failed TO failed-a_clfnclasskeywordforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclasskeyword_reported TO reported-a_clfnclasskeywordforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclasskeyword_mapped TO mapped-a_clfnclasskeywordforkeydate KEEPING TARGET LINES.

    DATA(lt_delete) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasskeywordtp-t_delete( it_delete ).

    lo_bil_provider->delete_class_keyword(
      EXPORTING
        it_delete   = lt_delete
      IMPORTING
        et_failed   = lt_clfnclasskeyword_failed
        et_reported = lt_clfnclasskeyword_reported ).

    MOVE-CORRESPONDING lt_clfnclasskeyword_failed TO failed-a_clfnclasskeywordforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclasskeyword_reported TO reported-a_clfnclasskeywordforkeydate KEEPING TARGET LINES.

    DATA(lt_update) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasskeywordtp-t_update( it_update ).

    lo_bil_provider->update_class_keyword(
      EXPORTING
        it_update   = lt_update
      IMPORTING
        et_failed   = lt_clfnclasskeyword_failed
        et_reported = lt_clfnclasskeyword_reported ).

    MOVE-CORRESPONDING lt_clfnclasskeyword_failed TO failed-a_clfnclasskeywordforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclasskeyword_reported TO reported-a_clfnclasskeywordforkeydate KEEPING TARGET LINES.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_handler_classtext DEFINITION INHERITING FROM cl_abap_behavior_handler
  AFTER lcl_handler_classcdesc.
  PRIVATE SECTION.
    METHODS:
      modify FOR BEHAVIOR IMPORTING
        it_create    FOR CREATE a_clfnclassforkeydate\_ClassText
        it_create_direct FOR CREATE a_clfnclasstextforkeydate
        it_delete    FOR DELETE a_clfnclasstextforkeydate
        it_update    FOR UPDATE a_clfnclasstextforkeydate,
      read FOR BEHAVIOR IMPORTING it_class_text FOR READ a_clfnclasstextforkeydate RESULT et_class_text,
     read_by_class FOR READ
        IMPORTING  it_create FOR READ a_clfnclassforkeydate\_ClassText
           FULL iv_full
         RESULT et_class_text
           LINK et_link.

ENDCLASS.

CLASS lcl_handler_classtext IMPLEMENTATION.

  METHOD read_by_class.
  ENDMETHOD.

  METHOD read.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_class( ).

    DATA(lt_class_text) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasstexttp-t_read_in( it_class_text ).

    lo_bil_provider->read_class_text(
      EXPORTING
        it_class_text = lt_class_text
      IMPORTING
        et_class_text = DATA(lt_class_text_result)
        et_failed     = DATA(lt_failed) ).

    MOVE-CORRESPONDING lt_class_text_result TO et_class_text.
    MOVE-CORRESPONDING lt_failed TO failed-a_clfnclasstextforkeydate.

  ENDMETHOD.

  METHOD modify.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_class( ).

    DATA(lt_create) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasstexttp-t_create( it_create ) ##BEHV_TYPE.

    lo_bil_provider->create_class_text(
      EXPORTING
        it_create   = lt_create
      IMPORTING
        et_failed   = DATA(lt_clfnclasstext_failed)
        et_reported = DATA(lt_clfnclasstext_reported)
        et_mapped   = DATA(lt_clfnclasstext_mapped) ).

    MOVE-CORRESPONDING lt_clfnclasstext_failed TO failed-a_clfnclasstextforkeydate.
    MOVE-CORRESPONDING lt_clfnclasstext_reported TO reported-a_clfnclasstextforkeydate.
    MOVE-CORRESPONDING lt_clfnclasstext_mapped TO mapped-a_clfnclasstextforkeydate.

    DATA(lt_create_direct) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasstexttp-t_create_direct( it_create_direct ).

    lo_bil_provider->create_class_text_direct(
    EXPORTING
      it_create   = lt_create_direct
    IMPORTING
      et_failed   = lt_clfnclasstext_failed
      et_reported = lt_clfnclasstext_reported
      et_mapped   = lt_clfnclasstext_mapped ).

    MOVE-CORRESPONDING lt_clfnclasstext_failed TO failed-a_clfnclasstextforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclasstext_reported TO reported-a_clfnclasstextforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclasstext_mapped TO mapped-a_clfnclasstextforkeydate KEEPING TARGET LINES.

    DATA(lt_delete) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasstexttp-t_delete( it_delete ).

    lo_bil_provider->delete_class_text(
      EXPORTING
        it_delete   = lt_delete
      IMPORTING
        et_failed   = lt_clfnclasstext_failed
        et_reported = lt_clfnclasstext_reported ).

    MOVE-CORRESPONDING lt_clfnclasstext_failed TO failed-a_clfnclasstextforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclasstext_reported TO reported-a_clfnclasstextforkeydate KEEPING TARGET LINES.

    DATA(lt_update) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasstexttp-t_update( it_update ).

    lo_bil_provider->update_class_text(
      EXPORTING
        it_update   = lt_update
      IMPORTING
        et_failed   = lt_clfnclasstext_failed
        et_reported = lt_clfnclasstext_reported ).

    MOVE-CORRESPONDING lt_clfnclasstext_failed TO failed-a_clfnclasstextforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclasstext_reported TO reported-a_clfnclasstextforkeydate KEEPING TARGET LINES.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_handler_classcharc DEFINITION INHERITING FROM cl_abap_behavior_handler
  AFTER lcl_handler_classcdesc.
  PRIVATE SECTION.
    METHODS:
      modify FOR BEHAVIOR IMPORTING
        it_create    FOR CREATE a_clfnclassforkeydate\_ClassCharacteristic
        it_create_direct FOR CREATE a_clfnclasscharcforkeydate
        it_delete    FOR DELETE a_clfnclasscharcforkeydate
        it_update    FOR UPDATE a_clfnclasscharcforkeydate,
      read FOR BEHAVIOR IMPORTING it_class_charc FOR READ a_clfnclasscharcforkeydate RESULT et_class_charc,
      read_by_class FOR READ
        IMPORTING  it_create FOR READ a_clfnclassforkeydate\_ClassCharacteristic
           FULL iv_full
         RESULT et_class_charc
           LINK et_link.

ENDCLASS.

CLASS lcl_handler_classcharc IMPLEMENTATION.

  METHOD read_by_class.
  ENDMETHOD.

  METHOD read.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_class( ).

    DATA(lt_class_charc) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasscharctp-t_read_in( it_class_charc ).

    lo_bil_provider->read_class_charc(
      EXPORTING
        it_class_charc = lt_class_charc
      IMPORTING
        et_class_charc = DATA(lt_class_charc_result)
        et_failed      = DATA(lt_failed) ).

    MOVE-CORRESPONDING lt_class_charc_result TO et_class_charc.
    MOVE-CORRESPONDING lt_failed TO failed-a_clfnclasscharcforkeydate.

  ENDMETHOD.

  METHOD modify.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_class( ).

    DATA(lt_create) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasscharctp-t_create( it_create ) ##BEHV_TYPE.

    lo_bil_provider->create_class_charc(
      EXPORTING
        it_create   = lt_create
      IMPORTING
        et_failed   = DATA(lt_clfnclasscharc_failed)
        et_reported = DATA(lt_clfnclasscharc_reported)
        et_mapped   = DATA(lt_clfnclasscharc_mapped) ).

    MOVE-CORRESPONDING lt_clfnclasscharc_failed TO failed-a_clfnclasscharcforkeydate.
    MOVE-CORRESPONDING lt_clfnclasscharc_reported TO reported-a_clfnclasscharcforkeydate.
    MOVE-CORRESPONDING lt_clfnclasscharc_mapped TO mapped-a_clfnclasscharcforkeydate.

    DATA(lt_create_direct) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasscharctp-t_create_direct( it_create_direct ).

    lo_bil_provider->create_class_charc_direct(
    EXPORTING
      it_create   = lt_create_direct
    IMPORTING
      et_failed   = lt_clfnclasscharc_failed
      et_reported = lt_clfnclasscharc_reported
      et_mapped   = lt_clfnclasscharc_mapped ).

    MOVE-CORRESPONDING lt_clfnclasscharc_failed TO failed-a_clfnclasscharcforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclasscharc_reported TO reported-a_clfnclasscharcforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclasscharc_mapped TO mapped-a_clfnclasscharcforkeydate KEEPING TARGET LINES.

    DATA(lt_delete) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasscharctp-t_delete( it_delete ).

    lo_bil_provider->delete_class_charc(
      EXPORTING
        it_delete   = lt_delete
      IMPORTING
        et_failed   = lt_clfnclasscharc_failed
        et_reported = lt_clfnclasscharc_reported ).

    MOVE-CORRESPONDING lt_clfnclasscharc_failed TO failed-a_clfnclasscharcforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclasscharc_reported TO reported-a_clfnclasscharcforkeydate KEEPING TARGET LINES.

    DATA(lt_update) = CORRESPONDING if_ngc_bil_cls_c=>lty_clfnclasscharctp-t_update( it_update ).

    lo_bil_provider->update_class_charc(
      EXPORTING
        it_update   = lt_update
      IMPORTING
        et_failed   = lt_clfnclasscharc_failed
        et_reported = lt_clfnclasscharc_reported ).

    MOVE-CORRESPONDING lt_clfnclasscharc_failed TO failed-a_clfnclasscharcforkeydate KEEPING TARGET LINES.
    MOVE-CORRESPONDING lt_clfnclasscharc_reported TO reported-a_clfnclasscharcforkeydate KEEPING TARGET LINES.

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
      lo_bil_provider_transactional TYPE REF TO if_ngc_bil_cls_transactional.

    lo_bil_provider_transactional ?= cl_ngc_bil_factory=>get_class( ).
    lo_bil_provider_transactional->check_before_save(
      IMPORTING
        et_class_failed        = DATA(lt_class_failed)
        et_class_reported      = DATA(lt_class_reported)
        et_class_desc_failed   = DATA(lt_class_desc_failed)
        et_class_desc_reported = DATA(lt_class_desc_reported)
        et_class_text_failed   = DATA(lt_class_text_failed)
        et_class_text_reported = DATA(lt_class_text_reported) ).

    MOVE-CORRESPONDING lt_class_failed TO failed-a_clfnclassforkeydate.
    MOVE-CORRESPONDING lt_class_reported TO reported-a_clfnclassforkeydate.

    MOVE-CORRESPONDING lt_class_desc_failed TO failed-a_clfnclassdescforkeydate.
    MOVE-CORRESPONDING lt_class_desc_reported TO reported-a_clfnclassdescforkeydate.

    MOVE-CORRESPONDING lt_class_text_failed TO failed-a_clfnclasstextforkeydate.
    MOVE-CORRESPONDING lt_class_text_reported TO reported-a_clfnclasstextforkeydate.

  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD adjust_numbers.

    DATA:
      lo_bil_provider_transactional TYPE REF TO if_ngc_bil_cls_transactional.

    lo_bil_provider_transactional ?= cl_ngc_bil_factory=>get_class( ).
    lo_bil_provider_transactional->adjust_numbers(
      IMPORTING
        et_class_mapped          = DATA(lt_mapped_class)
        et_class_desc_mapped     = DATA(lt_mapped_class_desc)
        et_class_keyword_mapped  = DATA(lt_mapped_class_keyw)
        et_class_text_mapped     = DATA(lt_mapped_class_text)
        et_class_charc_mapped    = DATA(lt_mapped_class_charc) ).

    MOVE-CORRESPONDING lt_mapped_class TO mapped-a_clfnclassforkeydate.
    MOVE-CORRESPONDING lt_mapped_class_desc TO mapped-a_clfnclassdescforkeydate.
    MOVE-CORRESPONDING lt_mapped_class_keyw TO mapped-a_clfnclasskeywordforkeydate.
    MOVE-CORRESPONDING lt_mapped_class_text TO mapped-a_clfnclasstextforkeydate.
    MOVE-CORRESPONDING lt_mapped_class_charc TO mapped-a_clfnclasscharcforkeydate.

  ENDMETHOD.
ENDCLASS.