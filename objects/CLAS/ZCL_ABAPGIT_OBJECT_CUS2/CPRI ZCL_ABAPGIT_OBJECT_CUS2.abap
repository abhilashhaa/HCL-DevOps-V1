  PRIVATE SECTION.
    TYPES: tty_attribute_titles        TYPE STANDARD TABLE OF cus_atrt
                                            WITH NON-UNIQUE DEFAULT KEY,
           tty_attribute_countries     TYPE STANDARD TABLE OF cus_atrcou
                                            WITH NON-UNIQUE DEFAULT KEY,
           tty_attribute_components    TYPE STANDARD TABLE OF tfm18
                                            WITH NON-UNIQUE DEFAULT KEY,
           tty_attribute_comp_variants TYPE STANDARD TABLE OF cus_atrvco
                                            WITH NON-UNIQUE DEFAULT KEY.

    TYPES: BEGIN OF ty_customizing_attribute,
             header              TYPE cus_atrh,
             titles              TYPE tty_attribute_titles,
             countries           TYPE tty_attribute_countries,
             components          TYPE tty_attribute_components,
             components_variants TYPE tty_attribute_comp_variants,
           END OF ty_customizing_attribute.

    DATA: mv_img_attribute TYPE cus_atr.
