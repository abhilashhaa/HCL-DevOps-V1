  METHOD zif_abapgit_object~get_metadata.

    DATA ls_meta_data TYPE zif_abapgit_definitions=>ty_metadata.

    ls_meta_data = get_metadata( ).
    ls_meta_data-delete_tadir = abap_true.

    rs_metadata = ls_meta_data.

  ENDMETHOD.