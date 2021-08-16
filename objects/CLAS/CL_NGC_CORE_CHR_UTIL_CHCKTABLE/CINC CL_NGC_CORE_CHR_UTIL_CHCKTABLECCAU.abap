CLASS ltd_table_data_handler DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_handle_table_data.
ENDCLASS.

CLASS ltc_chr_util_chcktable DEFINITION DEFERRED.
CLASS cl_ngc_core_chr_util_chcktable DEFINITION LOCAL FRIENDS ltc_chr_util_chcktable.

CLASS ltc_chr_util_chcktable DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_util_chcktable TYPE REF TO cl_ngc_core_chr_util_chcktable.

    METHODS:
      setup.

    METHODS:
      get_key_field_successful FOR TESTING,
      get_key_field_error FOR TESTING,
      load_from_buffer_success FOR TESTING.

ENDCLASS.


CLASS ltd_table_data_handler IMPLEMENTATION.

  METHOD lif_handle_table_data~check_table_exists.

    IF iv_table_name = 'EXISTING_TABLE'.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.

  ENDMETHOD.

  METHOD lif_handle_table_data~get_table_details.

    et_field_list = VALUE #(
      ( dtyp = 'CLNT'  fieldname = 'MANDT' convexit = ''     exlength = '000A' dblength = '0014' )
      ( dtyp = 'CUOB'  fieldname = 'KEY'   convexit = 'CONV' exlength = '000A' dblength = '0014' ) ).

  ENDMETHOD.

ENDCLASS.

CLASS ltc_chr_util_chcktable IMPLEMENTATION.

  METHOD setup.

    mo_util_chcktable = cl_ngc_core_chr_util_chcktable=>get_instance( ).
    mo_util_chcktable->mo_table_data_handler = NEW ltd_table_data_handler( ).

  ENDMETHOD.

  METHOD get_key_field_successful.

    mo_util_chcktable->if_ngc_core_chr_util_chcktable~get_key_field(
      EXPORTING
        iv_check_table_name = 'EXISTING_TABLE'
      IMPORTING
        ev_conversion_exit  = DATA(lv_conversion_exit)
        ev_key_field_name   = DATA(lv_key_field_name)
        ev_length           = DATA(lv_length) ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_conversion_exit
      exp = 'CONV'
      msg = 'Conversion exit invalid' ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_key_field_name
      exp = 'KEY'
      msg = 'Key name invalid' ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_length
      exp = '20'
      msg = 'Length invalid' ).

  ENDMETHOD.

  METHOD get_key_field_error.

    mo_util_chcktable->if_ngc_core_chr_util_chcktable~get_key_field(
      EXPORTING
        iv_check_table_name = 'NOT_EXISTING_TABLE'
      IMPORTING
        ev_conversion_exit  = DATA(lv_conversion_exit)
        ev_key_field_name   = DATA(lv_key_field_name)
        ev_length           = DATA(lv_length)
      EXCEPTIONS
        table_not_found     = 1 ).

    cl_abap_unit_assert=>assert_subrc(
      act = sy-subrc
      exp = 1
      msg = 'Table not found' ).

  ENDMETHOD.

  METHOD load_from_buffer_success.

    mo_util_chcktable->mt_table_data = VALUE #(
      ( conversion_exit = 'CONV1' check_table_name = 'BUFFERED_TABLE_1' length = 200 key_field_name = 'KEY_1' )
      ( conversion_exit = 'CONV2' check_table_name = 'BUFFERED_TABLE_2' length = 300 key_field_name = 'KEY_2' ) ).

    mo_util_chcktable->if_ngc_core_chr_util_chcktable~get_key_field(
      EXPORTING
        iv_check_table_name = 'BUFFERED_TABLE_1'
      IMPORTING
        ev_conversion_exit  = DATA(lv_conversion_exit)
        ev_key_field_name   = DATA(lv_key_field_name)
        ev_length           = DATA(lv_length)
      EXCEPTIONS
        table_not_found     = 1 ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_conversion_exit
      exp = 'CONV1'
      msg = 'Conversion exit invalid' ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_key_field_name
      exp = 'KEY_1'
      msg = 'Key name invalid' ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_length
      exp = '200'
      msg = 'Length invalid' ).

  ENDMETHOD.

ENDCLASS.