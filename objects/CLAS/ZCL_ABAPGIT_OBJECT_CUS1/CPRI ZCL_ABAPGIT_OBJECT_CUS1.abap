  PRIVATE SECTION.
    TYPES: tty_activity_titles TYPE STANDARD TABLE OF cus_actt
                                    WITH NON-UNIQUE DEFAULT KEY,

           tty_objects         TYPE STANDARD TABLE OF cus_actobj
                            WITH NON-UNIQUE DEFAULT KEY,

           tty_objects_title   TYPE STANDARD TABLE OF cus_actobt
                                  WITH NON-UNIQUE DEFAULT KEY,

           BEGIN OF ty_customzing_activity,
             activity_header        TYPE cus_acth,
             activity_customer_exit TYPE cus_actext,
             activity_title         TYPE tty_activity_titles,
             objects                TYPE tty_objects,
             objects_title          TYPE tty_objects_title,
           END OF ty_customzing_activity.

    DATA: mv_customizing_activity TYPE cus_img_ac.
