  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_sap_package,
        package  TYPE devclass,
        instance TYPE REF TO zif_abapgit_sap_package,
      END OF ty_sap_package .
    TYPES:
      tty_sap_package TYPE HASHED TABLE OF ty_sap_package
                                    WITH UNIQUE KEY package .
    TYPES:
      BEGIN OF ty_code_inspector,
        package  TYPE devclass,
        instance TYPE REF TO zif_abapgit_code_inspector,
      END OF ty_code_inspector .
    TYPES:
      tty_code_inspector TYPE HASHED TABLE OF ty_code_inspector
                                       WITH UNIQUE KEY package .

    CLASS-DATA gi_tadir TYPE REF TO zif_abapgit_tadir .
    CLASS-DATA gt_sap_package TYPE tty_sap_package .
    CLASS-DATA gt_code_inspector TYPE tty_code_inspector .
    CLASS-DATA gi_stage_logic TYPE REF TO zif_abapgit_stage_logic .
    CLASS-DATA gi_cts_api TYPE REF TO zif_abapgit_cts_api .
    CLASS-DATA gi_environment TYPE REF TO zif_abapgit_environment .
    CLASS-DATA gi_longtext TYPE REF TO zif_abapgit_longtexts .
    CLASS-DATA gi_http_agent TYPE REF TO zif_abapgit_http_agent .