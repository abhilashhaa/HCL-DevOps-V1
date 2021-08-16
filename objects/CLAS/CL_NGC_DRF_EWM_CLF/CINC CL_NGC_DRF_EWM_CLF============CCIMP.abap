*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_cif_functions DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES lif_cif_functions.
ENDCLASS.

CLASS lcl_cif_functions IMPLEMENTATION.
  METHOD lif_cif_functions~/sapapo/cif_claf_inb.
    CLEAR: ct_return.

    CALL FUNCTION '/SAPAPO/CIF_CLAF_INB'
      IN BACKGROUND TASK DESTINATION iv_rfc_dest
      EXPORTING
        is_control_parameter = is_control_parameter
        iv_logsrcsys         = iv_logsrcsys
      TABLES
        it_kssk              = ct_kssk
        it_inob              = ct_inob
        it_ausp              = ct_ausp
        it_allocation        = ct_allocation
        it_value             = ct_value
        it_delob             = ct_delob
        it_extensionin       = ct_extensionin
*       it_atnam_source      = ct_atnam_source
*       it_class_source      = ct_class_source
*       it_matcfgs           = ct_matcfgs
        et_return            = ct_return.
    IF 1 = 2.
      " in foreground - for debugging purposes
      CALL FUNCTION '/SAPAPO/CIF_CLAF_INB'
        DESTINATION iv_rfc_dest
        EXPORTING
          is_control_parameter = is_control_parameter
          iv_logsrcsys         = iv_logsrcsys
        TABLES
          it_kssk              = ct_kssk
          it_inob              = ct_inob
          it_ausp              = ct_ausp
          it_allocation        = ct_allocation
          it_value             = ct_value
          it_delob             = ct_delob
          it_extensionin       = ct_extensionin
*         it_atnam_source      = ct_atnam_source
*         it_class_source      = ct_class_source
*         it_matcfgs           = ct_matcfgs
          et_return            = ct_return.
    ENDIF.
  ENDMETHOD.
ENDCLASS.


CLASS lcl_db_access DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES lif_db_access.
ENDCLASS.

CLASS lcl_db_access IMPLEMENTATION.
  METHOD lif_db_access~get_clf_data.
    DATA:
      ls_tcla TYPE tcla.

    CLEAR: et_ausp, et_inob, et_kssk.

    SELECT SINGLE *
      FROM tcla
      INTO ls_tcla
      WHERE klart = iv_class_type.

    IF ls_tcla-multobj = 'X'.
      " At this point, we assume a consistent input data, so: iv_object_table = ls_tcla-obtab
      "   or: there is a row in tclao with this condition: iv_object_table = tclao.obtab

      SELECT *
        FROM inob
        APPENDING TABLE et_inob
        WHERE klart = iv_class_type
          AND obtab = iv_object_table
          AND cuobj = iv_object_key. " iv_object_key is a CUOBJ in this case!

      " Here we filter out incosistent kssk entries, which do not have a corresponding inob entry
      " KSSK~MAFID?
      SELECT kssk~*
        FROM ( kssk INNER JOIN inob ON kssk~klart = inob~klart AND kssk~objek = inob~cuobj )
        APPENDING CORRESPONDING FIELDS OF TABLE @et_kssk
        WHERE inob~klart = @iv_class_type
          AND inob~obtab = @iv_object_table
          AND inob~cuobj = @iv_object_key. " iv_object_key is a CUOBJ in this case!

      " At this point, we assume a consistent DB, so every ausp row should have a corresponding row in kssk
      " But we filter out incosistent ausp entries, which do not have a corresponding inob entry
      " AUSP~MAFID?
      SELECT ausp~*
        FROM ( ausp INNER JOIN inob ON ausp~klart = inob~klart AND ausp~objek = inob~cuobj )
        APPENDING CORRESPONDING FIELDS OF TABLE @et_ausp
        WHERE inob~klart = @iv_class_type
          AND inob~obtab = @iv_object_table
          AND inob~cuobj = @iv_object_key. " iv_object_key is a CUOBJ in this case!
    ELSE.
      " At this point, we assume a consistent input data, so: iv_object_table = ls_tcla-obtab

      " KSSK~MAFID?
      SELECT *
        FROM kssk
        APPENDING TABLE @et_kssk
        WHERE klart = @iv_class_type
          AND objek = @iv_object_key.

      " At this point, we assume a consistent DB, so every ausp row should have a corresponding row in kssk
      " AUSP~MAFID?
      SELECT *
        FROM ausp
        APPENDING TABLE @et_ausp
        WHERE klart = @iv_class_type
          AND objek = @iv_object_key.
    ENDIF.
  ENDMETHOD.
  METHOD lif_db_access~clse_select_cabn.
    CALL FUNCTION 'CLSE_SELECT_CABN'
      EXPORTING
        key_date                     = key_date
        bypassing_buffer             = bypassing_buffer
        with_prepared_pattern        = with_prepared_pattern
      IMPORTING
        ambiguous_obj_characteristic = ambiguous_obj_characteristic
      TABLES
        in_cabn                      = in_cabn
        t_cabn                       = t_cabn
      EXCEPTIONS
        no_entry_found               = 1
        OTHERS                       = 2.
    ev_subrc = sy-subrc.
  ENDMETHOD.
  METHOD lif_db_access~clcv_convert_object_to_fields.
    CALL FUNCTION 'CLCV_CONVERT_OBJECT_TO_FIELDS'
      EXPORTING
        rmclfstru      = cs_rmclfstru
        table          = iv_table
      IMPORTING
        rmclfstru      = cs_rmclfstru
      EXCEPTIONS
        tclo_not_found = 1
        OTHERS         = 2.
    ev_subrc = sy-subrc.
  ENDMETHOD.
ENDCLASS.