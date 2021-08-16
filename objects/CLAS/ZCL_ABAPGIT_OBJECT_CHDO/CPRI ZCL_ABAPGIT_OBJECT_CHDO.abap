  PRIVATE SECTION.
    TYPES: BEGIN OF ty_change_document,
             reports_generated TYPE SORTED TABLE OF tcdrps WITH UNIQUE KEY object reportname,
             objects           TYPE SORTED TABLE OF tcdobs WITH UNIQUE KEY object tabname,
             objects_text      TYPE SORTED TABLE OF tcdobts WITH UNIQUE KEY spras object,
           END OF ty_change_document.

    DATA: mv_object TYPE cdobjectcl.
