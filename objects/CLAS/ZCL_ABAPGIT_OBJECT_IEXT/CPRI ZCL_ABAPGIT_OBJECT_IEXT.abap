  PRIVATE SECTION.
    TYPES: BEGIN OF ty_extention,
             attributes TYPE edi_iapi01,
             t_syntax   TYPE STANDARD TABLE OF edi_iapi03 WITH NON-UNIQUE DEFAULT KEY,
           END OF ty_extention.

    CONSTANTS c_dataname_iext TYPE string VALUE 'IEXT' ##NO_TEXT.
    DATA: mv_extension TYPE edi_cimtyp.
