*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_refval_reader_general IMPLEMENTATION.
  METHOD constructor.
    mv_language       = iv_language.
    mv_in_range_limit = iv_in_range_limit.
  ENDMETHOD.

  METHOD get_reader_id.
    rv_reader_id = 'GEN'. " This is the general reader
  ENDMETHOD.

  METHOD get_obtab_filter.
    CREATE DATA rt_sel_obtab.
    rt_sel_obtab->* = VALUE cl_ngc_core_conv_ref_char=>ltr_obtab(
      ( sign = 'E'  option = 'EQ'  low = 'KKRAMERK' )
      ( sign = 'E'  option = 'EQ'  low = 'MARA' )
      ( sign = 'E'  option = 'EQ'  low = 'MCHA' )
      ( sign = 'E'  option = 'EQ'  low = 'MCH1' )
      ( sign = 'E'  option = 'EQ'  low = 'DRAW' )
    ).
  ENDMETHOD.

  METHOD get_change_of_date_supported.
    rv_supported = abap_true.
  ENDMETHOD.

  METHOD read_objects ##NEEDED.
    " In the general case, we do not read the objects
  ENDMETHOD.

  METHOD read_ref_values.
    DATA:
      lv_objchk_name TYPE rs38l_fnam,
      lv_exists      TYPE abap_bool,
      lt_otab        TYPE TABLE OF rmclobtx,
      lx_root        TYPE REF TO cx_root,
      lv_exc_text    TYPE string.

    CLEAR: lt_otab, et_attabs.
    lv_exists = abap_false.
    ev_should_exit = abap_false.

    " First we have to determine OBJECT_CHECK_<NAME>
    lv_objchk_name = me->get_objchk_name( iv_obtab = iv_obtab ).
    IF lv_objchk_name EQ gc_no_name.
      " So this name does not exist.
      ev_should_exit = abap_true.
      RETURN.
    ENDIF.

    " Fill otab.
    APPEND INITIAL LINE TO lt_otab ASSIGNING FIELD-SYMBOL(<ls_otab>).
    <ls_otab>-objek = iv_objek.

    " Get reference values for all validities.
    LOOP AT ct_refvals ASSIGNING FIELD-SYMBOL(<ls_refval>).
      " Call the OBJECT_CHECK_<NAME>.
      TRY.
        CALL FUNCTION lv_objchk_name
          EXPORTING
            called_from      = '2'
            language         = mv_language
            lock             = abap_false
            single           = abap_true
            date_of_change   = <ls_refval>-datuv
          TABLES
            otab             = lt_otab
          EXCEPTIONS
            error_message    = 1
            object_not_found = 2
            foreign_lock     = 3
            system_failure   = 4
            OTHERS           = 5.
      CATCH cx_root INTO lx_root ##CATCH_ALL.
        lv_exc_text = lx_root->get_text( ).
        sy-subrc = 6.
      ENDTRY.
      CASE sy-subrc.
        WHEN 0.
          lv_exists = abap_true.

          " Get the results.
          CALL FUNCTION 'CTMS_DDB_HAS_OBJECT_AREA'
            TABLES
              objects = <ls_refval>-reftabs.

          " Collect the available table names into a list.
          LOOP AT <ls_refval>-reftabs ASSIGNING FIELD-SYMBOL(<ls_reftable>).
            INSERT <ls_reftable>-tname INTO TABLE et_attabs.
          ENDLOOP.
        WHEN 1.
          " An error MESSAGE is raised in the FM.
          MESSAGE ID sy-msgid TYPE 'W' NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO cl_upgba_logger=>mv_logmsg.
          cl_upgba_logger=>log->trace_single( ).
          MESSAGE w035(upgba) WITH 'Error message (previous line) in ' lv_objchk_name && ':' 'objek = ' iv_objek INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
          cl_upgba_logger=>log->trace_single( ).
          READ TABLE ct_events ASSIGNING FIELD-SYMBOL(<ls_event>) WITH TABLE KEY event = cl_ngc_core_conv_ref_char=>gc_ev_bo_errmsg param = ''.
          IF sy-subrc EQ 0.
            ADD 1 TO <ls_event>-count.
          ELSE.
            APPEND VALUE #( event = cl_ngc_core_conv_ref_char=>gc_ev_bo_errmsg param = '' count = 1 ) TO ct_events.
          ENDIF.
          ev_should_exit = abap_true.
        WHEN 2.
          " The BO does not exist at this date. Maybe at an other date...
        WHEN 3.
          MESSAGE w035(upgba) WITH 'Business Object is foreign locked: obtab = ' iv_obtab ' objek = ' iv_objek INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
          cl_upgba_logger=>log->trace_single( ).
          READ TABLE ct_events ASSIGNING <ls_event> WITH TABLE KEY event = cl_ngc_core_conv_ref_char=>gc_ev_bo_flock param = ''.
          IF sy-subrc EQ 0.
            ADD 1 TO <ls_event>-count.
          ELSE.
            APPEND VALUE #( event = cl_ngc_core_conv_ref_char=>gc_ev_bo_flock param = '' count = 1 ) TO ct_events.
          ENDIF.
          ev_should_exit = abap_true.
        WHEN 4 OR
             5.
          MESSAGE w035(upgba) WITH 'Failure when accessing Business Object: obtab = ' iv_obtab ' objek = ' iv_objek INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
          cl_upgba_logger=>log->trace_single( ).
          READ TABLE ct_events ASSIGNING <ls_event> WITH TABLE KEY event = cl_ngc_core_conv_ref_char=>gc_ev_bo_sysfail param = ''.
          IF sy-subrc EQ 0.
            ADD 1 TO <ls_event>-count.
          ELSE.
            APPEND VALUE #( event = cl_ngc_core_conv_ref_char=>gc_ev_bo_sysfail param = '' count = 1 ) TO ct_events.
          ENDIF.
          ev_should_exit = abap_true.
        WHEN 6.
          MESSAGE w035(upgba) WITH `Exception got from ` && lv_objchk_name  ` objek = ` && iv_objek  `  `  lv_exc_text INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
          cl_upgba_logger=>log->trace_single( ).
          READ TABLE ct_events ASSIGNING <ls_event> WITH TABLE KEY event = cl_ngc_core_conv_ref_char=>gc_ev_bo_sysfail param = ''.
          IF sy-subrc EQ 0.
            ADD 1 TO <ls_event>-count.
          ELSE.
            APPEND VALUE #( event = cl_ngc_core_conv_ref_char=>gc_ev_bo_sysfail param = '' count = 1 ) TO ct_events.
          ENDIF.
          ev_should_exit = abap_true.
      ENDCASE.
    ENDLOOP.

    IF lv_exists = abap_false.
      " So this BO does not exist at any date. :(
      MESSAGE w035(upgba) WITH 'Business Object not found: obtab = ' iv_obtab ' objek = ' iv_objek INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
      cl_upgba_logger=>log->trace_single( ).
      READ TABLE ct_events ASSIGNING <ls_event> WITH TABLE KEY event = cl_ngc_core_conv_ref_char=>gc_ev_bo_nexist param = ''.
      IF sy-subrc EQ 0.
        ADD 1 TO <ls_event>-count.
      ELSE.
        APPEND VALUE #( event = cl_ngc_core_conv_ref_char=>gc_ev_bo_nexist param = '' count = 1 ) TO ct_events.
      ENDIF.
      ev_should_exit = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD refval_to_ausp.
    DATA:
      lr_refvalue  TYPE REF TO data.

    CLEAR: es_ausp, ev_value_exists.

    TRY.
      IF me->extract_refvalue(
        EXPORTING
          is_refval   = is_refval
          is_attab    = is_attab
        CHANGING
          cr_refvalue = lr_refvalue
      ) = abap_true.
        " So we do have a value with this datuv.
        me->create_ausp_row(
          EXPORTING
            ir_refvalue = lr_refvalue
            iv_objek    = is_attab-auspobjek
            iv_klart    = is_attab-klart
            iv_atinn    = is_attab-atinn
            iv_aennr    = is_refval-aennr
            iv_datuv    = is_refval-datuv
            iv_atfor    = is_attab-atfor
            iv_atkon    = is_attab-atkon
            iv_msehi    = is_attab-msehi
            iv_anzdz    = is_attab-anzdz
          IMPORTING
            es_ausp     = es_ausp
        ).
        ev_value_exists = abap_true.
      ENDIF.
    CATCH cx_data_conv_error.
      MESSAGE w035(upgba) WITH 'Type conversion error with Business Object: obtab=' is_attab-obtab ' objek = ' is_attab-objek INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
      cl_upgba_logger=>log->trace_single( ).
      READ TABLE ct_events ASSIGNING FIELD-SYMBOL(<ls_event>) WITH TABLE KEY event = cl_ngc_core_conv_ref_char=>gc_ev_type_conv_fail param = ''.
      IF sy-subrc EQ 0.
        ADD 1 TO <ls_event>-count.
      ELSE.
        APPEND VALUE #( event = cl_ngc_core_conv_ref_char=>gc_ev_type_conv_fail param = '' count = 1 ) TO ct_events.
      ENDIF.
    ENDTRY.
  ENDMETHOD.

  METHOD add_package_end_msgs.
    " We need an event for all the non existent OBJECT_CHECKs.
    LOOP AT mt_object_check_names ASSIGNING FIELD-SYMBOL(<ls_object_check_names>) WHERE fkbname EQ gc_no_name.
      READ TABLE ct_events TRANSPORTING NO FIELDS WITH TABLE KEY event = cl_ngc_core_conv_ref_char=>gc_ev_obj_chk_nexist param = <ls_object_check_names>-obtab.
      IF sy-subrc NE 0.
        APPEND VALUE #( event = cl_ngc_core_conv_ref_char=>gc_ev_obj_chk_nexist param = <ls_object_check_names>-obtab count = 1 ) TO ct_events.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_objchk_name.
    DATA:
      ls_object_check_name LIKE LINE OF mt_object_check_names.

    " Look in the cache first.
    READ TABLE mt_object_check_names ASSIGNING FIELD-SYMBOL(<ls_object_check_name>) WITH TABLE KEY obtab = iv_obtab.
    IF sy-subrc EQ 0.
      " So this name is already cached.
      rv_objchk_name = <ls_object_check_name>-fkbname.
    ELSE.
      " So this name is not yet cached, let's see if it exists.
      ls_object_check_name-obtab = iv_obtab.
      CALL FUNCTION 'CLOCH_FUNCTION_NAME'
        EXPORTING
          object_type = ls_object_check_name-obtab
        IMPORTING
          func_name   = ls_object_check_name-fkbname
        EXCEPTIONS
          OTHERS      = 1.
      IF sy-subrc IS NOT INITIAL.
        " So this name does not exist.
        ls_object_check_name-fkbname = gc_no_name.
      ENDIF.

      " Store the result to the cache
      INSERT ls_object_check_name INTO TABLE mt_object_check_names.

      rv_objchk_name = ls_object_check_name-fkbname.
    ENDIF.
  ENDMETHOD.

  METHOD extract_refvalue.
    DATA:
      l_ref         TYPE REF TO data.

    FIELD-SYMBOLS:
      <x1>          TYPE x,
      <x2>          TYPE x.

    rv_success = abap_false.

    " Select the reference table.
    READ TABLE is_refval-reftabs ASSIGNING FIELD-SYMBOL(<ls_iobj>) WITH KEY tname = is_attab-attab.
    IF NOT sy-subrc IS INITIAL.
      " Behaving normal characteristic as reference data is not passed. (or this chr is not valid currently)
      RETURN.
    ENDIF.

    " Convert back the selected line of ref.table to structure format.
    CALL FUNCTION 'CLUC_CONVERT_STRUCTURE_BACK'
      EXPORTING
        i_object            = <ls_iobj>-table
        i_objectid          = <ls_iobj>-tname
      IMPORTING
        e_refobject         = l_ref
      EXCEPTIONS
        assign_failed       = 1
        OTHERS              = 2.
    IF NOT sy-subrc IS INITIAL.
      RAISE EXCEPTION TYPE cx_data_conv_error.
    ENDIF.

    ASSIGN l_ref->* TO FIELD-SYMBOL(<lv_obj>).

    " Select the reference field of the structure.
    ASSIGN COMPONENT is_attab-atfel
      OF STRUCTURE <lv_obj>
      TO FIELD-SYMBOL(<lv_reference_data>).
    IF NOT sy-subrc IS INITIAL.
      RAISE EXCEPTION TYPE cx_data_conv_error.
    ENDIF.

    " Store the reference value.
    TRY.
      CREATE DATA cr_refvalue LIKE <lv_reference_data>.
      ASSIGN cr_refvalue->* TO <x1> CASTING.

      ASSIGN <lv_reference_data> TO <x2> CASTING.
      <x1> = <x2>.
    CATCH cx_root ##CATCH_ALL.
      RAISE EXCEPTION TYPE cx_data_conv_error.
    ENDTRY.

    " We do not want to store the empty string, so:
    IF is_attab-atfor EQ gc_atfor_char.
      ASSIGN cr_refvalue->* TO FIELD-SYMBOL(<lv_refvalue>).
      IF <lv_refvalue> EQ ''.
        RETURN.
      ENDIF.
    ENDIF.

    rv_success = abap_true.
  ENDMETHOD.

  METHOD create_ausp_row.
    CONSTANTS:
      lc_atcod_single TYPE string VALUE '1',
      lc_atfor_num    TYPE atfor VALUE 'NUM',
      lc_atfor_curr   TYPE atfor VALUE 'CURR',
      lc_atfor_time   TYPE atfor VALUE 'TIME',
      lc_atfor_date   TYPE atfor VALUE 'DATE'.

    DATA lv_atwrt     TYPE atwrt.

    CLEAR: es_ausp.

    ASSIGN ir_refvalue->* TO FIELD-SYMBOL(<lv_refvalue>).

    es_ausp-mandt = sy-mandt.
    es_ausp-objek = iv_objek.
    es_ausp-atinn = iv_atinn.
    es_ausp-atzhl = 1.
    es_ausp-mafid = 'O'. " Object
    es_ausp-klart = iv_klart. " CLS-type
    es_ausp-adzhl = 0. " This is an initial value, it will be updated by optimize_ausp().
    es_ausp-aennr = iv_aennr.
    es_ausp-datuv = iv_datuv.
    es_ausp-datub = cl_ngc_core_conv_ref_char=>gc_min_date. " This is an initial value, it will be updated by process_bo().

    " A reference characteristic can not be an interval type, so:
    es_ausp-atcod = lc_atcod_single.

    TRY.
      CASE iv_atfor.
        WHEN gc_atfor_char.
          IF iv_atkon NE SPACE.
            MOVE <lv_refvalue> TO es_ausp-atwrt.
          ELSE.
            WRITE <lv_refvalue> TO es_ausp-atwrt ##WRITE_MOVE.
          ENDIF.
        WHEN lc_atfor_num.
          es_ausp-atflv          = <lv_refvalue>.
          es_ausp-atawe          = iv_msehi.
          es_ausp-dec_value_from = es_ausp-dec_value_to = cl_plm_xpra_utilities=>convert_fltp_to_dec(
            iv_fltp_value = es_ausp-atflv
            iv_decimals   = iv_anzdz
          ).
        WHEN lc_atfor_curr.
          es_ausp-atflv           = <lv_refvalue>.
          es_ausp-currency        = iv_msehi." Set currency key
          es_ausp-curr_value_from = es_ausp-curr_value_to = cl_plm_xpra_utilities=>convert_fltp_to_curr(
            iv_fltp_value = es_ausp-atflv
            iv_currency   = es_ausp-currency
          ).
        WHEN lc_atfor_time.
          lv_atwrt = <lv_refvalue>.
          MOVE lv_atwrt TO es_ausp-atflv.
          es_ausp-time_from = es_ausp-time_to = cl_plm_xpra_utilities=>convert_fltp_to_time(
            iv_fltp_value = es_ausp-atflv
          ).
        WHEN lc_atfor_date.
          lv_atwrt = <lv_refvalue>.
          MOVE lv_atwrt TO es_ausp-atflv.
          es_ausp-date_from = es_ausp-date_to = cl_plm_xpra_utilities=>convert_fltp_to_date(
            iv_fltp_value = es_ausp-atflv
          ).
      ENDCASE.
    CATCH cx_root ##CATCH_ALL.
      " Something was wrong during the type conversion.
      RAISE EXCEPTION TYPE cx_data_conv_error.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.


CLASS lcl_refval_reader_mara IMPLEMENTATION.
  METHOD get_reader_id.
    rv_reader_id = 'MARA'. " This is the MARA reader
  ENDMETHOD.

  METHOD get_obtab_filter.
    CREATE DATA rt_sel_obtab.
    rt_sel_obtab->* = VALUE cl_ngc_core_conv_ref_char=>ltr_obtab(
      ( sign = 'I'  option = 'EQ'  low = 'MARA' )
    ).
  ENDMETHOD.

  METHOD get_change_of_date_supported.
    rv_supported = abap_false.
  ENDMETHOD.

  METHOD read_objects.
    TYPES:
      ltr_matnr   TYPE RANGE OF matnr,
      lts_matnr   TYPE LINE OF ltr_matnr,
      ltt_matnr   TYPE SORTED TABLE OF lts_matnr WITH UNIQUE KEY low.

    DATA:
      ls_matnr    TYPE lts_matnr,
      lt_matnr_a  TYPE ltt_matnr,
      lt_matnr_p  TYPE ltr_matnr,
      lv_read     TYPE i.

    " We need all different objeks.
    ls_matnr-sign = 'I'.
    ls_matnr-option = 'EQ'.
    LOOP AT it_refbou ASSIGNING FIELD-SYMBOL(<is_refbou>).
      ls_matnr-low = <is_refbou>-objek. " Casting objek -> matnr
      INSERT ls_matnr INTO TABLE lt_matnr_a. " Here we are not adding duplicates because of UNIQUE KEY
    ENDLOOP.

    lv_read = 0.
    CLEAR: mt_mara, mt_makt.
    WHILE lv_read < lines( lt_matnr_a ).
      CLEAR lt_matnr_p.
      APPEND LINES OF lt_matnr_a
        FROM lv_read + 1 TO lv_read + mv_in_range_limit
        TO lt_matnr_p.
      ADD mv_in_range_limit TO lv_read.

      IF lines( lt_matnr_p ) > 0.
        SELECT *
          FROM mara
          WHERE matnr IN @lt_matnr_p
          APPENDING TABLE @mt_mara.

        SELECT *
          FROM makt
          WHERE matnr IN @lt_matnr_p AND spras = @mv_language
          APPENDING TABLE @mt_makt.
      ENDIF.
    ENDWHILE.
  ENDMETHOD.

  METHOD read_ref_values ##NEEDED.
    CLEAR: et_attabs.
    INSERT 'MARA                          ' INTO TABLE et_attabs.
    INSERT 'MAKT                          ' INTO TABLE et_attabs.
    ev_should_exit = abap_false.

    READ TABLE mt_mara REFERENCE INTO mr_mara WITH KEY matnr = iv_objek ##WARN_OK.
    IF sy-subrc NE 0.
      " So this BO does not exist. :(
      MESSAGE w035(upgba) WITH 'Business Object not found: obtab = ' iv_obtab ' objek = ' iv_objek INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
      cl_upgba_logger=>log->trace_single( ).
      READ TABLE ct_events ASSIGNING FIELD-SYMBOL(<ls_event>) WITH TABLE KEY event = cl_ngc_core_conv_ref_char=>gc_ev_bo_nexist param = ''.
      IF sy-subrc EQ 0.
        ADD 1 TO <ls_event>-count.
      ELSE.
        APPEND VALUE #( event = cl_ngc_core_conv_ref_char=>gc_ev_bo_nexist param = '' count = 1 ) TO ct_events.
      ENDIF.
      ev_should_exit = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD add_package_end_msgs ##NEEDED.
    " Here we need this as empty.
  ENDMETHOD.

  METHOD extract_refvalue.
    FIELD-SYMBOLS:
      <ms_mara_or_makt> TYPE any.

    rv_success = abap_false.

    IF is_attab-attab = 'MARA'.
      IF mr_mara IS BOUND AND mr_mara->matnr = is_attab-objek.
        ASSIGN mr_mara->* TO <ms_mara_or_makt>.
      ELSE.
        " Theoretically this should never happen, as extract_refvalue is called after read_ref_values.
        READ TABLE mt_mara ASSIGNING <ms_mara_or_makt> WITH KEY matnr = is_attab-objek ##WARN_OK.
        IF sy-subrc NE 0.
          RETURN.
        ENDIF.
      ENDIF.
    ELSEIF is_attab-attab = 'MAKT'.
      READ TABLE mt_makt ASSIGNING <ms_mara_or_makt> WITH KEY matnr = is_attab-objek   spras = mv_language ##WARN_OK.
      IF sy-subrc NE 0.
        " We handle no makt as if it would be empty
        ASSIGN ms_makt_empty TO <ms_mara_or_makt>.
      ENDIF.
    ELSE.
      " Behaving normal characteristic as reference data is not passed.
      RETURN.
    ENDIF.

    " Select the reference field of the structure.
    ASSIGN COMPONENT is_attab-atfel
      OF STRUCTURE <ms_mara_or_makt>
      TO FIELD-SYMBOL(<lv_reference_data>).
    IF NOT sy-subrc IS INITIAL.
      RAISE EXCEPTION TYPE cx_data_conv_error.
    ENDIF.

    cr_refvalue = REF #( <lv_reference_data> ).

    " We do not want to store the empty string, so:
    IF is_attab-atfor EQ gc_atfor_char AND <lv_reference_data> EQ ''.
      RETURN.
    ENDIF.

    rv_success = abap_true.
  ENDMETHOD.
ENDCLASS.


CLASS lcl_refval_reader_mcha IMPLEMENTATION.
  METHOD get_reader_id.
    rv_reader_id = 'MCHA'. " This is the MCHA reader
  ENDMETHOD.

  METHOD get_obtab_filter.
    CREATE DATA rt_sel_obtab.
    rt_sel_obtab->* = VALUE cl_ngc_core_conv_ref_char=>ltr_obtab(
      ( sign = 'I'  option = 'EQ'  low = 'MCHA' )
    ).
  ENDMETHOD.

  METHOD get_change_of_date_supported.
    rv_supported = abap_false.
  ENDMETHOD.

  METHOD read_objects.
    TYPES:
      ltr_matnr    TYPE RANGE OF matnr,
      lts_matnr    TYPE LINE OF ltr_matnr,
      ltt_matnr    TYPE SORTED TABLE OF lts_matnr WITH UNIQUE KEY low,
      ltt_mchakeys TYPE HASHED TABLE OF lts_mchakey WITH UNIQUE KEY matnr werks charg.

    DATA:
      ls_matnr     TYPE lts_matnr,
      lt_matnr_a   TYPE ltt_matnr,
      lt_matnr_p   TYPE ltr_matnr,
      lt_mchakeys  TYPE ltt_mchakeys,
      lv_read      TYPE i.

    FIELD-SYMBOLS:
      <ls_mchakey> TYPE lts_mchakey.

    " We need all different objeks.
    ls_matnr-sign = 'I'.
    ls_matnr-option = 'EQ'.
    LOOP AT it_refbou ASSIGNING FIELD-SYMBOL(<is_refbou>).
      ASSIGN <is_refbou>-objek TO <ls_mchakey> CASTING.
      ls_matnr-low = <ls_mchakey>-matnr.
      INSERT ls_matnr INTO TABLE lt_matnr_a. " Here we are not adding duplicates because of UNIQUE KEY
      INSERT <ls_mchakey> INTO TABLE lt_mchakeys. " Here we are not adding duplicates because of UNIQUE KEY
    ENDLOOP.

    IF lines( lt_mchakeys ) > 0.
      SELECT *
        FROM mcha
        FOR ALL ENTRIES IN @lt_mchakeys
        WHERE matnr = @lt_mchakeys-matnr AND werks = @lt_mchakeys-werks AND charg = @lt_mchakeys-charg
        INTO TABLE @mt_mcha.
    ENDIF.

    lv_read = 0.
    CLEAR: mt_mara, mt_makt.
    WHILE lv_read < lines( lt_matnr_a ).
      CLEAR lt_matnr_p.
      APPEND LINES OF lt_matnr_a
        FROM lv_read + 1 TO lv_read + mv_in_range_limit
        TO lt_matnr_p.
      ADD mv_in_range_limit TO lv_read.

      IF lines( lt_matnr_p ) > 0.
        SELECT *
          FROM mara
          WHERE matnr IN @lt_matnr_p
          APPENDING TABLE @mt_mara.

        SELECT *
          FROM makt
          WHERE matnr IN @lt_matnr_p AND spras = @mv_language
          APPENDING TABLE @mt_makt.
      ENDIF.
    ENDWHILE.
  ENDMETHOD.

  METHOD read_ref_values ##NEEDED.
    FIELD-SYMBOLS:
      <ls_mchakey> TYPE lts_mchakey.

    CLEAR: et_attabs.
    INSERT 'MCHA                          ' INTO TABLE et_attabs.
    INSERT 'MARA                          ' INTO TABLE et_attabs.
    INSERT 'MAKT                          ' INTO TABLE et_attabs.
    ev_should_exit = abap_false.

    ASSIGN iv_objek TO <ls_mchakey> CASTING.
    READ TABLE mt_mcha REFERENCE INTO mr_mcha WITH KEY matnr = <ls_mchakey>-matnr  werks = <ls_mchakey>-werks  charg = <ls_mchakey>-charg.
    IF sy-subrc NE 0.
      " So this BO does not exist. :(
      MESSAGE w035(upgba) WITH 'Business Object not found: obtab = ' iv_obtab ' objek = ' iv_objek INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
      cl_upgba_logger=>log->trace_single( ).
      READ TABLE ct_events ASSIGNING FIELD-SYMBOL(<ls_event>) WITH TABLE KEY event = cl_ngc_core_conv_ref_char=>gc_ev_bo_nexist param = ''.
      IF sy-subrc EQ 0.
        ADD 1 TO <ls_event>-count.
      ELSE.
        APPEND VALUE #( event = cl_ngc_core_conv_ref_char=>gc_ev_bo_nexist param = '' count = 1 ) TO ct_events.
      ENDIF.
      ev_should_exit = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD add_package_end_msgs ##NEEDED.
    " Here we need this as empty.
  ENDMETHOD.

  METHOD extract_refvalue.
    FIELD-SYMBOLS:
      <ms_mcha_or_mara_or_makt> TYPE any,
      <ls_mchakey>              TYPE lts_mchakey.

    rv_success = abap_false.
    ASSIGN is_attab-objek TO <ls_mchakey> CASTING.

    IF is_attab-attab = 'MCHA'.
      IF mr_mcha IS BOUND
      AND mr_mcha->matnr = <ls_mchakey>-matnr
      AND mr_mcha->werks = <ls_mchakey>-werks
      AND mr_mcha->charg = <ls_mchakey>-charg.
        ASSIGN mr_mcha->* TO <ms_mcha_or_mara_or_makt>.
      ELSE.
        " Theoretically this should never happen, as extract_refvalue is called after read_ref_values.
        READ TABLE mt_mcha ASSIGNING <ms_mcha_or_mara_or_makt> WITH KEY matnr = <ls_mchakey>-matnr  werks = <ls_mchakey>-werks  charg = <ls_mchakey>-charg.
        IF sy-subrc NE 0.
          RETURN.
        ENDIF.
      ENDIF.
    ELSEIF is_attab-attab = 'MARA'.
      READ TABLE mt_mara ASSIGNING <ms_mcha_or_mara_or_makt> WITH KEY matnr = <ls_mchakey>-matnr.
      IF sy-subrc NE 0.
        " We handle no makt as if it would be empty
        ASSIGN ms_mara_empty TO <ms_mcha_or_mara_or_makt>.
      ENDIF.
    ELSEIF is_attab-attab = 'MAKT'.
      READ TABLE mt_makt ASSIGNING <ms_mcha_or_mara_or_makt> WITH KEY matnr = <ls_mchakey>-matnr   spras = mv_language.
      IF sy-subrc NE 0.
        " We handle no makt as if it would be empty
        ASSIGN ms_makt_empty TO <ms_mcha_or_mara_or_makt>.
      ENDIF.
    ELSE.
      " Behaving normal characteristic as reference data is not passed.
      RETURN.
    ENDIF.

    " Select the reference field of the structure.
    ASSIGN COMPONENT is_attab-atfel
      OF STRUCTURE <ms_mcha_or_mara_or_makt>
      TO FIELD-SYMBOL(<lv_reference_data>).
    IF NOT sy-subrc IS INITIAL.
      RAISE EXCEPTION TYPE cx_data_conv_error.
    ENDIF.

    cr_refvalue = REF #( <lv_reference_data> ).

    " We do not want to store the empty string, so:
    IF is_attab-atfor EQ gc_atfor_char AND <lv_reference_data> EQ ''.
      RETURN.
    ENDIF.

    rv_success = abap_true.
  ENDMETHOD.
ENDCLASS.


CLASS lcl_refval_reader_mch1 IMPLEMENTATION.
  METHOD get_reader_id.
    rv_reader_id = 'MCH1'. " This is the MCH1 reader
  ENDMETHOD.

  METHOD get_obtab_filter.
    CREATE DATA rt_sel_obtab.
    rt_sel_obtab->* = VALUE cl_ngc_core_conv_ref_char=>ltr_obtab(
      ( sign = 'I'  option = 'EQ'  low = 'MCH1' )
    ).
  ENDMETHOD.

  METHOD get_change_of_date_supported.
    rv_supported = abap_false.
  ENDMETHOD.

  METHOD read_objects.
    TYPES:
      ltr_matnr    TYPE RANGE OF matnr,
      lts_matnr    TYPE LINE OF ltr_matnr,
      ltt_matnr    TYPE SORTED TABLE OF lts_matnr WITH UNIQUE KEY low,
      ltt_mch1key  TYPE HASHED TABLE OF lts_mch1key WITH UNIQUE KEY matnr charg.

    DATA:
      ls_matnr     TYPE lts_matnr,
      lt_matnr_a   TYPE ltt_matnr,
      lt_matnr_p   TYPE ltr_matnr,
      lt_mch1keys  TYPE ltt_mch1key,
      lv_read      TYPE i.

    FIELD-SYMBOLS:
      <ls_mch1key> TYPE lts_mch1key.

    " We need all different objeks.
    ls_matnr-sign = 'I'.
    ls_matnr-option = 'EQ'.
    LOOP AT it_refbou ASSIGNING FIELD-SYMBOL(<is_refbou>).
      ASSIGN <is_refbou>-objek TO <ls_mch1key> CASTING.
      ls_matnr-low = <ls_mch1key>-matnr.
      INSERT ls_matnr INTO TABLE lt_matnr_a. " Here we are not adding duplicates because of UNIQUE KEY
      INSERT <ls_mch1key> INTO TABLE lt_mch1keys. " Here we are not adding duplicates because of UNIQUE KEY
    ENDLOOP.

    IF lines( lt_mch1keys ) > 0.
      SELECT *
        FROM mch1
        FOR ALL ENTRIES IN @lt_mch1keys
        WHERE matnr = @lt_mch1keys-matnr AND charg = @lt_mch1keys-charg
        INTO TABLE @mt_mch1.
    ENDIF.

    lv_read = 0.
    CLEAR: mt_mara, mt_makt.
    WHILE lv_read < lines( lt_matnr_a ).
      CLEAR lt_matnr_p.
      APPEND LINES OF lt_matnr_a
        FROM lv_read + 1 TO lv_read + mv_in_range_limit
        TO lt_matnr_p.
      ADD mv_in_range_limit TO lv_read.

      IF lines( lt_matnr_p ) > 0.
        SELECT *
          FROM mara
          WHERE matnr IN @lt_matnr_p
          APPENDING TABLE @mt_mara.

        SELECT *
          FROM makt
          WHERE matnr IN @lt_matnr_p AND spras = @mv_language
          APPENDING TABLE @mt_makt.
      ENDIF.
    ENDWHILE.
  ENDMETHOD.

  METHOD read_ref_values ##NEEDED.
    FIELD-SYMBOLS:
      <ls_mch1key> TYPE lts_mch1key.

    CLEAR: et_attabs.
    INSERT 'MCH1                          ' INTO TABLE et_attabs.
    INSERT 'MARA                          ' INTO TABLE et_attabs.
    INSERT 'MAKT                          ' INTO TABLE et_attabs.
    ev_should_exit = abap_false.

    ASSIGN iv_objek TO <ls_mch1key> CASTING.
    READ TABLE mt_mch1 REFERENCE INTO mr_mch1 WITH KEY matnr = <ls_mch1key>-matnr  charg = <ls_mch1key>-charg.
    IF sy-subrc NE 0.
      " So this BO does not exist. :(
      MESSAGE w035(upgba) WITH 'Business Object not found: obtab = ' iv_obtab ' objek = ' iv_objek INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
      cl_upgba_logger=>log->trace_single( ).
      READ TABLE ct_events ASSIGNING FIELD-SYMBOL(<ls_event>) WITH TABLE KEY event = cl_ngc_core_conv_ref_char=>gc_ev_bo_nexist param = ''.
      IF sy-subrc EQ 0.
        ADD 1 TO <ls_event>-count.
      ELSE.
        APPEND VALUE #( event = cl_ngc_core_conv_ref_char=>gc_ev_bo_nexist param = '' count = 1 ) TO ct_events.
      ENDIF.
      ev_should_exit = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD add_package_end_msgs ##NEEDED.
    " Here we need this as empty.
  ENDMETHOD.

  METHOD extract_refvalue.
    FIELD-SYMBOLS:
      <ms_mch1_or_mara_or_makt> TYPE any,
      <ls_mch1key>              TYPE lts_mch1key.

    rv_success = abap_false.
    ASSIGN is_attab-objek TO <ls_mch1key> CASTING.

    IF is_attab-attab = 'MCH1'.
      IF mr_mch1 IS BOUND
      AND mr_mch1->matnr = <ls_mch1key>-matnr
      AND mr_mch1->charg = <ls_mch1key>-charg.
        ASSIGN mr_mch1->* TO <ms_mch1_or_mara_or_makt>.
      ELSE.
        " Theoretically this should never happen, as extract_refvalue is called after read_ref_values.
        READ TABLE mt_mch1 ASSIGNING <ms_mch1_or_mara_or_makt> WITH KEY matnr = <ls_mch1key>-matnr  charg = <ls_mch1key>-charg.
        IF sy-subrc NE 0.
          RETURN.
        ENDIF.
      ENDIF.
    ELSEIF is_attab-attab = 'MARA'.
      READ TABLE mt_mara ASSIGNING <ms_mch1_or_mara_or_makt> WITH KEY matnr = <ls_mch1key>-matnr.
      IF sy-subrc NE 0.
        " We handle no makt as if it would be empty
        ASSIGN ms_mara_empty TO <ms_mch1_or_mara_or_makt>.
      ENDIF.
    ELSEIF is_attab-attab = 'MAKT'.
      READ TABLE mt_makt ASSIGNING <ms_mch1_or_mara_or_makt> WITH KEY matnr = <ls_mch1key>-matnr   spras = mv_language.
      IF sy-subrc NE 0.
        " We handle no makt as if it would be empty
        ASSIGN ms_makt_empty TO <ms_mch1_or_mara_or_makt>.
      ENDIF.
    ELSE.
      " Behaving normal characteristic as reference data is not passed.
      RETURN.
    ENDIF.

    " Select the reference field of the structure.
    ASSIGN COMPONENT is_attab-atfel
      OF STRUCTURE <ms_mch1_or_mara_or_makt>
      TO FIELD-SYMBOL(<lv_reference_data>).
    IF NOT sy-subrc IS INITIAL.
      RAISE EXCEPTION TYPE cx_data_conv_error.
    ENDIF.

    cr_refvalue = REF #( <lv_reference_data> ).

    " We do not want to store the empty string, so:
    IF is_attab-atfor EQ gc_atfor_char AND <lv_reference_data> EQ ''.
      RETURN.
    ENDIF.

    rv_success = abap_true.
  ENDMETHOD.
ENDCLASS.


CLASS lcl_refval_reader_draw IMPLEMENTATION.
  METHOD get_reader_id.
    rv_reader_id = 'DRAW'. " This is the DRAW reader
  ENDMETHOD.

  METHOD get_obtab_filter.
    CREATE DATA rt_sel_obtab.
    rt_sel_obtab->* = VALUE cl_ngc_core_conv_ref_char=>ltr_obtab(
      ( sign = 'I'  option = 'EQ'  low = 'DRAW' )
    ).
  ENDMETHOD.

  METHOD get_change_of_date_supported.
    rv_supported = abap_false.
  ENDMETHOD.

  METHOD read_objects.
    TYPES:
      ltt_drawkey  TYPE HASHED TABLE OF dms_doc_key WITH UNIQUE KEY dokar doknr dokvr doktl.

    DATA:
      lt_drawkey   TYPE ltt_drawkey.

    FIELD-SYMBOLS:
      <ls_drawkey> TYPE dms_doc_key.

    " We need all different objeks.
    LOOP AT it_refbou ASSIGNING FIELD-SYMBOL(<is_refbou>).
      ASSIGN <is_refbou>-objek TO <ls_drawkey> CASTING.
      INSERT <ls_drawkey> INTO TABLE lt_drawkey. " Here we are not adding duplicates because of UNIQUE KEY
    ENDLOOP.

    IF lines( lt_drawkey ) > 0.
      SELECT *
        FROM draw
        FOR ALL ENTRIES IN @lt_drawkey
        WHERE dokar = @lt_drawkey-dokar AND doknr = @lt_drawkey-doknr AND dokvr = @lt_drawkey-dokvr AND doktl = @lt_drawkey-doktl
        INTO TABLE @mt_draw.

      SELECT *
        FROM drat
        FOR ALL ENTRIES IN @lt_drawkey
        WHERE dokar = @lt_drawkey-dokar AND doknr = @lt_drawkey-doknr AND dokvr = @lt_drawkey-dokvr AND doktl = @lt_drawkey-doktl
        INTO TABLE @mt_drat.
    ENDIF.
  ENDMETHOD.

  METHOD read_ref_values ##NEEDED.
    FIELD-SYMBOLS:
      <ls_drawkey> TYPE dms_doc_key.

    CLEAR: et_attabs.
    INSERT 'DRAW                          ' INTO TABLE et_attabs.
    INSERT 'DRAT                          ' INTO TABLE et_attabs.
    ev_should_exit = abap_false.

    ASSIGN iv_objek TO <ls_drawkey> CASTING.
    READ TABLE mt_draw REFERENCE INTO mr_draw WITH KEY dokar = <ls_drawkey>-dokar  doknr = <ls_drawkey>-doknr  dokvr = <ls_drawkey>-dokvr  doktl = <ls_drawkey>-doktl.
    IF sy-subrc NE 0.
      " So this BO does not exist. :(
      MESSAGE w035(upgba) WITH 'Business Object not found: obtab = ' iv_obtab ' objek = ' iv_objek INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
      cl_upgba_logger=>log->trace_single( ).
      READ TABLE ct_events ASSIGNING FIELD-SYMBOL(<ls_event>) WITH TABLE KEY event = cl_ngc_core_conv_ref_char=>gc_ev_bo_nexist param = ''.
      IF sy-subrc EQ 0.
        ADD 1 TO <ls_event>-count.
      ELSE.
        APPEND VALUE #( event = cl_ngc_core_conv_ref_char=>gc_ev_bo_nexist param = '' count = 1 ) TO ct_events.
      ENDIF.
      ev_should_exit = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD add_package_end_msgs ##NEEDED.
    " Here we need this as empty.
  ENDMETHOD.

  METHOD extract_refvalue.
    FIELD-SYMBOLS:
      <ms_draw_or_drat> TYPE any,
      <ls_drawkey>      TYPE dms_doc_key.

    rv_success = abap_false.
    ASSIGN is_attab-objek TO <ls_drawkey> CASTING.

    IF is_attab-attab = 'DRAW'.
      IF mr_draw IS BOUND
      AND mr_draw->dokar = <ls_drawkey>-dokar
      AND mr_draw->doknr = <ls_drawkey>-doknr
      AND mr_draw->dokvr = <ls_drawkey>-dokvr
      AND mr_draw->doktl = <ls_drawkey>-doktl.
        ASSIGN mr_draw->* TO <ms_draw_or_drat>.
      ELSE.
        " Theoretically this should never happen, as extract_refvalue is called after read_ref_values.
        READ TABLE mt_draw ASSIGNING <ms_draw_or_drat> WITH KEY dokar = <ls_drawkey>-dokar  doknr = <ls_drawkey>-doknr  dokvr = <ls_drawkey>-dokvr  doktl = <ls_drawkey>-doktl.
        IF sy-subrc NE 0.
          RETURN.
        ENDIF.
      ENDIF.
    ELSEIF is_attab-attab = 'DRAT'.
      READ TABLE mt_drat ASSIGNING <ms_draw_or_drat> WITH KEY dokar = <ls_drawkey>-dokar  doknr = <ls_drawkey>-doknr  dokvr = <ls_drawkey>-dokvr  doktl = <ls_drawkey>-doktl  langu = mv_language.
      IF sy-subrc NE 0.
        " Ok, try with ANY language, as OBJECT_CHECK_DRAW does.
        READ TABLE mt_drat ASSIGNING <ms_draw_or_drat> WITH KEY dratseckey COMPONENTS dokar = <ls_drawkey>-dokar  doknr = <ls_drawkey>-doknr  dokvr = <ls_drawkey>-dokvr  doktl = <ls_drawkey>-doktl.
        IF sy-subrc NE 0.
          " We handle no makt as if it would be empty
          ASSIGN ms_drat_empty TO <ms_draw_or_drat>.
        ENDIF.
      ENDIF.
    ELSE.
      " Behaving normal characteristic as reference data is not passed.
      RETURN.
    ENDIF.

    " Select the reference field of the structure.
    ASSIGN COMPONENT is_attab-atfel
      OF STRUCTURE <ms_draw_or_drat>
      TO FIELD-SYMBOL(<lv_reference_data>).
    IF NOT sy-subrc IS INITIAL.
      RAISE EXCEPTION TYPE cx_data_conv_error.
    ENDIF.

    cr_refvalue = REF #( <lv_reference_data> ).

    " We do not want to store the empty string, so:
    IF is_attab-atfor EQ gc_atfor_char AND <lv_reference_data> EQ ''.
      RETURN.
    ENDIF.

    rv_success = abap_true.
  ENDMETHOD.
ENDCLASS.