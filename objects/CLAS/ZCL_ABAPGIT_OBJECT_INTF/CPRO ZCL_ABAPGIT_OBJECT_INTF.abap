  PROTECTED SECTION.

    METHODS deserialize_proxy
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_abap
      IMPORTING
        !ii_xml     TYPE REF TO zif_abapgit_xml_input
        !iv_package TYPE devclass
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_docu
      IMPORTING
        !ii_xml TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception .