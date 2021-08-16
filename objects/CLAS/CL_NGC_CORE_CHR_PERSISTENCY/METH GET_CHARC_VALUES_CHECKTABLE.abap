METHOD get_charc_values_checktable.

*--------------------------------------------------------------------*
* The implementation of this method is based on
* /PLMI/CL_CLF_BO_VALUE --> GET_VALUES_F4_CHECKTABLE
*--------------------------------------------------------------------*

  CONSTANTS:
    lc_datatype_clnt            TYPE datatype_d VALUE 'CLNT',
    lc_dynptype_lang            TYPE dynptype VALUE 'LANG',
    lc_inttype_character_string TYPE inttype VALUE 'C'.

  DATA:
    ls_charc_value     TYPE ngcs_core_charc_value,
    lr_table           TYPE REF TO data,
    lv_tabix_check     TYPE sytabix,
    lv_tabix_text      TYPE sytabix,
    lv_charcchecktable TYPE atprt.

  FIELD-SYMBOLS:
    <ls_field_check> TYPE x031l,
    <lt_checktable>  TYPE STANDARD TABLE,
    <ls_field_text>  TYPE dfies,
    <ls_field_langu> TYPE dfies,
    <ls_checktable>  TYPE any,
    <lt_texttable>   TYPE STANDARD TABLE,
    <ls_texttable>   TYPE any,
    <lv_field>       TYPE any.

  CLEAR: et_message.

  LOOP AT it_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>)
    WHERE charcchecktable IS NOT INITIAL.

    lv_charcchecktable = <ls_characteristic>-charcchecktable.

    " Check table processing
    " check if check table is available
    DATA(lv_table_exists) = mo_chr_util_chcktable->checktable_exsists( lv_charcchecktable ).

    ASSERT lv_table_exists = abap_true.

    " get key fields of check table
    mo_chr_util_chcktable->get_table_details(
      EXPORTING
        iv_table_name = lv_charcchecktable
      IMPORTING
        et_field_list = DATA(lt_field_check)
      EXCEPTIONS
        not_found     = 1 ).

    ASSERT sy-subrc = 0.

    " get first key field (not the CLIENT field)
    LOOP AT lt_field_check ASSIGNING <ls_field_check> WHERE dtyp <> lc_datatype_clnt.
      lv_tabix_check = sy-tabix.
      EXIT.
    ENDLOOP.

    TEST-SEAM parse_chcktable_data.
      " select data
      CREATE DATA lr_table TYPE (lv_charcchecktable).
      ASSIGN lr_table->* TO <ls_checktable>.

      CREATE DATA lr_table TYPE STANDARD TABLE OF (lv_charcchecktable).
      ASSIGN lr_table->* TO <lt_checktable>.
    END-TEST-SEAM.

    TEST-SEAM select_count_checktable. " TODO request exception for this!
*      SELECT COUNT( * ) FROM (lv_charcchecktable).       "#EC CI_DYNTAB
    END-TEST-SEAM.

    IF sy-dbcnt > if_ngc_core_c=>gc_max_entries_for_checktable.
      " Check table &1 has &2 entries. F4 help only supported up to &3 entries.
      MESSAGE w001(ngc_core_chr)
        WITH <ls_characteristic>-charcchecktable sy-dbcnt if_ngc_core_c=>gc_max_entries_for_checktable
        INTO DATA(lv_msg) ##NEEDED.
      APPEND VALUE #( charcinternalid = <ls_characteristic>-charcinternalid
                      key_date        = <ls_characteristic>-key_date
                      msgty           = sy-msgty
                      msgid           = sy-msgid
                      msgno           = sy-msgno
                      msgv1           = sy-msgv1
                      msgv2           = sy-msgv2
                      msgv3           = sy-msgv3
                      msgv4           = sy-msgv4 ) TO et_message.
      CONTINUE.
    ENDIF.

*    TEST-SEAM select_checktable. " TODO request exception for this!
*      SELECT * FROM (lv_charcchecktable) INTO TABLE <lt_checktable>. "#EC CI_DYNTAB
*    END-TEST-SEAM.
    mo_chr_util_chcktable->select_table_data(
      EXPORTING
        iv_table_name = lv_charcchecktable
      IMPORTING
        et_values     = <lt_checktable> ).

    SORT <lt_checktable> BY (<ls_field_check>-fieldname).

    " Texttable processing
    " check if texttable is available
    mo_core_util->get_texttable(
      EXPORTING
        iv_table_name = lv_charcchecktable
      IMPORTING
        ev_texttable  = DATA(lv_texttable)
        ev_checkfield = DATA(lv_checkfield) ).

    IF lv_texttable IS NOT INITIAL.

      " get key fields of check table
      mo_chr_util_chcktable->get_table_details(
        EXPORTING
*          iv_table_name = lv_charcchecktable
          iv_table_name = lv_texttable
        IMPORTING
          et_field_info = DATA(lt_field_text)
        EXCEPTIONS
          not_found     = 1 ).

      ASSERT sy-subrc = 0.

      " get language field
      READ TABLE lt_field_text ASSIGNING <ls_field_langu>
        WITH KEY keyflag  = abap_true
                 datatype = lc_dynptype_lang.

      " get first description field of texttable
      READ TABLE lt_field_text ASSIGNING <ls_field_text>
        WITH KEY keyflag = abap_false
                 inttype = lc_inttype_character_string.

      lv_tabix_text = sy-tabix.

      TEST-SEAM parse_texttable_data.
        " select descriptions
        CREATE DATA lr_table TYPE (lv_texttable).
        ASSIGN lr_table->* TO <ls_texttable>.

        CREATE DATA lr_table TYPE STANDARD TABLE OF (lv_texttable).
        ASSIGN lr_table->* TO <lt_texttable>.
      END-TEST-SEAM.

      lv_table_exists = mo_chr_util_chcktable->checktable_exsists( lv_texttable ).

      ASSERT lv_table_exists = abap_true.

*      TEST-SEAM select_texttable.
*        SELECT * FROM (lv_texttable) INTO TABLE <lt_texttable>. "#EC CI_DYNTAB
*      END-TEST-SEAM.
      mo_chr_util_chcktable->select_table_data(
        EXPORTING
          iv_table_name = lv_texttable
        IMPORTING
          et_values     = <lt_texttable> ).

      SORT <lt_texttable> BY (lv_checkfield) (<ls_field_langu>-fieldname).

    ENDIF. " lv_texttable IS NOT INITIAL.

    " export data
    LOOP AT <lt_checktable> ASSIGNING <ls_checktable>.

      CLEAR: ls_charc_value.
      ASSIGN COMPONENT lv_tabix_check OF STRUCTURE <ls_checktable> TO <lv_field>.

      ls_charc_value-charcinternalid      = <ls_characteristic>-charcinternalid.
      ls_charc_value-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq.
      ls_charc_value-key_date             = <ls_characteristic>-key_date.

      WRITE <lv_field> TO ls_charc_value-charcvalue.        "#EC *

      IF <ls_characteristic>-charcdatatype <> if_ngc_core_c=>gc_charcdatatype-char.
        ls_charc_value-charcfromnumericvalue = <lv_field>.
      ENDIF.

      IF lv_texttable IS NOT INITIAL.
        READ TABLE <lt_texttable> ASSIGNING <ls_texttable>
          WITH KEY (lv_checkfield)              = <lv_field>
                   (<ls_field_langu>-fieldname) = sy-langu
          BINARY SEARCH.

        IF sy-subrc = 0.
          ASSIGN COMPONENT lv_tabix_text OF STRUCTURE <ls_texttable> TO <lv_field>.
          ls_charc_value-charcvaluedescription = <lv_field>.
        ENDIF.
      ENDIF.

      APPEND ls_charc_value TO ct_characteristic_value.
    ENDLOOP.

  ENDLOOP.

ENDMETHOD.