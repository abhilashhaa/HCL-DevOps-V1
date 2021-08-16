  METHOD zif_abapgit_object~get_comparator.

    DATA: li_local_version_output TYPE REF TO zif_abapgit_xml_output,
          li_local_version_input  TYPE REF TO zif_abapgit_xml_input.


    CREATE OBJECT li_local_version_output TYPE zcl_abapgit_xml_output.

    me->zif_abapgit_object~serialize( li_local_version_output ).

    CREATE OBJECT li_local_version_input
      TYPE zcl_abapgit_xml_input
      EXPORTING
        iv_xml = li_local_version_output->render( ).

    CREATE OBJECT ri_comparator TYPE zcl_abapgit_object_tabl_compar
      EXPORTING
        ii_local = li_local_version_input.

  ENDMETHOD.