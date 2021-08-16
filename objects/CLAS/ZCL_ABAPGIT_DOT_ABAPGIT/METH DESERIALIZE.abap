  METHOD deserialize.

    DATA: lv_xml  TYPE string,
          ls_data TYPE zif_abapgit_dot_abapgit=>ty_dot_abapgit.


    lv_xml = zcl_abapgit_convert=>xstring_to_string_utf8( iv_xstr ).

    ls_data = from_xml( lv_xml ).

    CREATE OBJECT ro_dot_abapgit
      EXPORTING
        is_data = ls_data.

  ENDMETHOD.