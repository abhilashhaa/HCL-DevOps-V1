  PRIVATE SECTION.
    TYPES: BEGIN OF ty_classic_badi_implementation,
             implementation_data TYPE impl_data,
             function_codes      TYPE seex_fcode_table,
             control_composites  TYPE seex_coco_table,
             customer_includes   TYPE seex_table_table,
             screens             TYPE seex_screen_table,
             filters             TYPE seex_filter_table,
           END OF ty_classic_badi_implementation.