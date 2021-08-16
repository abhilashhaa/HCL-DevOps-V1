  PRIVATE SECTION.
    TYPES: tty_img_activity_texts TYPE STANDARD TABLE OF cus_imgact
                                       WITH NON-UNIQUE DEFAULT KEY,
           BEGIN OF ty_img_activity,
             header TYPE cus_imgach,
             texts  TYPE tty_img_activity_texts,
           END OF ty_img_activity.
    DATA: mv_img_activity TYPE cus_img_ac.
