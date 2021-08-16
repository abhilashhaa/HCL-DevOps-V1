  PRIVATE SECTION.
    TYPES: BEGIN OF ty_style,
             header     TYPE itcda,
             paragraphs TYPE STANDARD TABLE OF itcdp WITH DEFAULT KEY,
             strings    TYPE STANDARD TABLE OF itcds WITH DEFAULT KEY,
             tabs       TYPE STANDARD TABLE OF itcdq WITH DEFAULT KEY,
           END OF ty_style.
