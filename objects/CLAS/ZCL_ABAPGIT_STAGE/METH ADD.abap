  METHOD add.

    append( iv_path     = iv_path
            iv_filename = iv_filename
            iv_method   = zif_abapgit_definitions=>c_method-add
            is_status   = is_status
            iv_data     = iv_data ).

  ENDMETHOD.