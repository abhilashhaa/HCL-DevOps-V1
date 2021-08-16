CLASS lcl_handlerutil DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      add_response
        IMPORTING
          is_mapped   TYPE if_ngc_bil_clf=>ts_mapped OPTIONAL
          is_failed   TYPE if_ngc_bil_clf=>ts_failed OPTIONAL
          is_reported TYPE if_ngc_bil_clf=>ts_reported OPTIONAL
        CHANGING
          cs_mapped   TYPE if_ngc_bil_clf=>ts_mapped OPTIONAL
          cs_failed   TYPE if_ngc_bil_clf=>ts_failed OPTIONAL
          cs_reported TYPE if_ngc_bil_clf=>ts_reported OPTIONAL.

ENDCLASS.

CLASS lcl_handlerutil IMPLEMENTATION.

  METHOD add_response.

    IF is_mapped IS SUPPLIED.
      ASSERT cs_mapped IS SUPPLIED.
      APPEND LINES OF is_mapped-object           TO cs_mapped-object.
      APPEND LINES OF is_mapped-objectclass      TO cs_mapped-objectclass.
      APPEND LINES OF is_mapped-objectcharc      TO cs_mapped-objectcharc.
      APPEND LINES OF is_mapped-objectcharcvalue TO cs_mapped-objectcharcvalue.
    ENDIF.

    IF is_failed IS SUPPLIED.
      ASSERT cs_failed IS SUPPLIED.
      APPEND LINES OF is_failed-object           TO cs_failed-object.
      APPEND LINES OF is_failed-objectclass      TO cs_failed-objectclass.
      APPEND LINES OF is_failed-objectcharc      TO cs_failed-objectcharc.
      APPEND LINES OF is_failed-objectcharcvalue TO cs_failed-objectcharcvalue.
    ENDIF.

    IF is_reported IS SUPPLIED.
      ASSERT cs_reported IS SUPPLIED.
      APPEND LINES OF is_reported-object           TO cs_reported-object.
      APPEND LINES OF is_reported-objectclass      TO cs_reported-objectclass.
      APPEND LINES OF is_reported-objectcharc      TO cs_reported-objectcharc.
      APPEND LINES OF is_reported-objectcharcvalue TO cs_reported-objectcharcvalue.
      APPEND LINES OF is_reported-%other           TO cs_reported-%other.
    ENDIF.

  ENDMETHOD.

ENDCLASS.


CLASS lcl_handlerobject DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      modify          FOR BEHAVIOR IMPORTING
        it_refdata    FOR ACTION object~setrefdata
        it_conscheck  FOR ACTION object~checkconsistency,
      read            FOR BEHAVIOR IMPORTING
         it_input     FOR READ   object RESULT et_object,
      lock            FOR BEHAVIOR IMPORTING
        it_lock       FOR LOCK   object.
ENDCLASS.

CLASS lcl_handlerobject IMPLEMENTATION.

  METHOD modify.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_classification( ).

    IF it_refdata IS NOT INITIAL.
      lo_bil_provider->exec_obj_setrefdata(
        EXPORTING
          it_input    = it_refdata
        IMPORTING
          es_failed   = failed
          es_reported = reported ).
    ENDIF.

    IF it_conscheck IS NOT INITIAL.
      lo_bil_provider->exec_obj_checkconsistency(
        EXPORTING
          it_input    = it_conscheck
        IMPORTING
          es_failed   = DATA(ls_failed)
          es_reported = DATA(ls_reported) ).

      lcl_handlerutil=>add_response(
        EXPORTING
          is_failed   = ls_failed
          is_reported = ls_reported
        CHANGING
          cs_failed   = failed
          cs_reported = reported ).
    ENDIF.

  ENDMETHOD.

  METHOD lock.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_classification( ).

    IF it_lock IS NOT INITIAL.
      lo_bil_provider->lock_obj(
        EXPORTING
          it_input    = it_lock
        IMPORTING
          es_failed   = failed
          es_reported = reported ).
    ENDIF.

  ENDMETHOD.

  METHOD read.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_classification( ).

    IF it_input IS NOT INITIAL.
      lo_bil_provider->read_obj(
        EXPORTING
          it_input    = it_input
        IMPORTING
          et_result   = et_object
          es_failed   = failed
          es_reported = reported ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_handlerobjectclass DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      modify              FOR BEHAVIOR IMPORTING
        it_create         FOR CREATE objectclass
        it_create_by_obj  FOR CREATE object\_objectclass
        it_delete         FOR DELETE objectclass,
      read                FOR BEHAVIOR IMPORTING
        it_object_class   FOR READ objectclass RESULT et_object_class
        it_object         FOR READ object\_objectclass FULL iv_full RESULT et_object_class_by_object LINK et_link.
ENDCLASS.

CLASS lcl_handlerobjectclass IMPLEMENTATION.

  METHOD modify.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_classification( ).

    IF it_create_by_obj IS NOT INITIAL.
      lo_bil_provider->create_obj_objclass(
        EXPORTING
          it_input    = it_create_by_obj
        IMPORTING
          es_failed   = failed
          es_reported = reported
          es_mapped   = mapped ).
    ENDIF.

    IF it_create IS NOT INITIAL.
      lo_bil_provider->create_objclass(
        EXPORTING
          it_input    = it_create
        IMPORTING
          es_mapped   = DATA(ls_mapped)
          es_failed   = DATA(ls_failed)
          es_reported = DATA(ls_reported) ).

      lcl_handlerutil=>add_response(
        EXPORTING
          is_mapped   = ls_mapped
          is_failed   = ls_failed
          is_reported = ls_reported
        CHANGING
          cs_mapped   = mapped
          cs_failed   = failed
          cs_reported = reported ).
    ENDIF.

    IF it_delete IS NOT INITIAL.
      lo_bil_provider->delete_objclass(
        EXPORTING
          it_input    = it_delete
        IMPORTING
          es_failed   = ls_failed
          es_reported = ls_reported ).

      lcl_handlerutil=>add_response(
        EXPORTING
          is_failed   = ls_failed
          is_reported = ls_reported
        CHANGING
          cs_failed   = failed
          cs_reported = reported ).
    ENDIF.

  ENDMETHOD.

  METHOD read.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_classification( ).

    IF it_object_class IS NOT INITIAL.
      lo_bil_provider->read_objclass(
        EXPORTING
          it_input    = it_object_class
        IMPORTING
          et_result   = et_object_class
          es_failed   = failed
          es_reported = reported ).
    ENDIF.

    IF it_object IS NOT INITIAL.
      " Using iv_full is currently not supported by NGC API so it is not passed
      lo_bil_provider->read_obj_objclass(
        EXPORTING
          it_input    = it_object
        IMPORTING
          et_result   = et_object_class_by_object
          et_link     = et_link
          es_failed   = DATA(ls_failed)
          es_reported = DATA(ls_reported) ).

      lcl_handlerutil=>add_response(
        EXPORTING
          is_failed   = ls_failed
          is_reported = ls_reported
        CHANGING
          cs_failed   = failed
          cs_reported = reported ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_handlerobjectcharc DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      read              FOR BEHAVIOR IMPORTING
        it_object_charc FOR READ objectcharc RESULT et_object_charc
        it_object       FOR READ object\_objectcharc FULL iv_full RESULT et_object_charc_by_object LINK et_link.
ENDCLASS.

CLASS lcl_handlerobjectcharc IMPLEMENTATION.

  METHOD read.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_classification( ).

    IF it_object_charc IS NOT INITIAL.
      lo_bil_provider->read_objcharc(
        EXPORTING
          it_input    = it_object_charc
        IMPORTING
          et_result   = et_object_charc
          es_failed   = failed
          es_reported = reported ).
    ENDIF.

    IF it_object IS NOT INITIAL.
      " Using iv_full is currently not supported by NGC API so it is not passed
      lo_bil_provider->read_obj_objcharc(
        EXPORTING
          it_input    = it_object
        IMPORTING
          et_result   = et_object_charc_by_object
          et_link     = et_link
          es_failed   = DATA(ls_failed)
          es_reported = DATA(ls_reported) ).

      lcl_handlerutil=>add_response(
        EXPORTING
          is_failed   = ls_failed
          is_reported = ls_reported
        CHANGING
          cs_failed   = failed
          cs_reported = reported ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_handlerobjectcharcvalue DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      modify                  FOR BEHAVIOR IMPORTING
        it_create             FOR CREATE objectcharcvalue
        it_create_by_charc    FOR CREATE objectcharc\_objectcharcvalue
        it_update             FOR UPDATE objectcharcvalue
        it_delete             FOR DELETE objectcharcvalue,
      read                    FOR BEHAVIOR IMPORTING
        it_object_charc_value FOR READ objectcharcvalue RESULT et_object_charc_value
        it_object             FOR READ objectcharc\_objectcharcvalue FULL iv_full RESULT et_object_charcval_by_charc LINK et_link.
ENDCLASS.

CLASS lcl_handlerobjectcharcvalue IMPLEMENTATION.

  METHOD modify.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_classification( ).

    IF it_create IS NOT INITIAL.
      lo_bil_provider->create_objcharcval(
        EXPORTING
          it_input    = it_create
        IMPORTING
          es_mapped   = mapped
          es_failed   = failed
          es_reported = reported ).
    ENDIF.

    IF it_update IS NOT INITIAL.
      lo_bil_provider->update_objcharcval(
        EXPORTING
          it_input    = it_update
        IMPORTING
          es_failed   = DATA(ls_failed)
          es_reported = DATA(ls_reported) ).

      lcl_handlerutil=>add_response(
        EXPORTING
          is_failed   = ls_failed
          is_reported = ls_reported
        CHANGING
          cs_failed   = failed
          cs_reported = reported ).
    ENDIF.

    IF it_delete IS NOT INITIAL.
      lo_bil_provider->delete_objcharcval(
        EXPORTING
          it_input    = it_delete
        IMPORTING
          es_failed   = ls_failed
          es_reported = ls_reported ).

      lcl_handlerutil=>add_response(
        EXPORTING
          is_failed   = ls_failed
          is_reported = ls_reported
        CHANGING
          cs_failed   = failed
          cs_reported = reported ).
    ENDIF.

    IF it_create_by_charc IS NOT INITIAL.
      lo_bil_provider->create_objcharc_objcharcval(
        EXPORTING
          it_input    = it_create_by_charc
        IMPORTING
          es_mapped   = DATA(ls_mapped)
          es_failed   = ls_failed
          es_reported = ls_reported ).

      lcl_handlerutil=>add_response(
        EXPORTING
          is_mapped   = ls_mapped
          is_failed   = ls_failed
          is_reported = ls_reported
        CHANGING
          cs_mapped   = mapped
          cs_failed   = failed
          cs_reported = reported ).
    ENDIF.

  ENDMETHOD.

  METHOD read.

    DATA(lo_bil_provider) = cl_ngc_bil_factory=>get_classification( ).

    IF it_object_charc_value IS NOT INITIAL.
      lo_bil_provider->read_objcharcval(
        EXPORTING
          it_input    = it_object_charc_value
        IMPORTING
          et_result   = et_object_charc_value
          es_failed   = failed
          es_reported = reported ).
    ENDIF.

    IF it_object IS NOT INITIAL.
      " Using iv_full is currently not supported by NGC API so it is not passed
      lo_bil_provider->read_objcharc_objcharcval(
        EXPORTING
          it_input    = it_object
        IMPORTING
          et_result   = et_object_charcval_by_charc
          et_link     = et_link
          es_failed   = DATA(ls_failed)
          es_reported = DATA(ls_reported) ).

      lcl_handlerutil=>add_response(
        EXPORTING
          is_failed   = ls_failed
          is_reported = ls_reported
        CHANGING
          cs_failed   = failed
          cs_reported = reported ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_saver DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS save              REDEFINITION.
    METHODS cleanup           REDEFINITION.
ENDCLASS.

CLASS lcl_saver IMPLEMENTATION.

  METHOD save.
    cl_ngc_bil_factory=>get_classification( )->finalize( ).
    cl_ngc_bil_factory=>get_classification( )->save( ).
  ENDMETHOD.

  METHOD cleanup.
    cl_ngc_bil_factory=>get_classification( )->cleanup( ).
  ENDMETHOD.

ENDCLASS.