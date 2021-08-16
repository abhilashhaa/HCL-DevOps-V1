  PROTECTED SECTION.
    CLASS-DATA:
      "! All authenticators managed by the registry
      gt_registered_authenticators TYPE HASHED TABLE OF REF TO zif_abapgit_2fa_authenticator
                                        WITH UNIQUE KEY table_line.
