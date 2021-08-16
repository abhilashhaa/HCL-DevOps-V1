  PROTECTED SECTION.
    TYPES tty_bdcdata TYPE STANDARD TABLE OF bdcdata
                           WITH NON-UNIQUE DEFAULT KEY.

    METHODS get_metadata REDEFINITION.

    METHODS change_bdc_jump_data ABSTRACT
      CHANGING
        ct_bdcdata TYPE tty_bdcdata.
