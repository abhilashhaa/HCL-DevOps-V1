  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_screen_variant,
        shdsvci    TYPE shdsvci,
        shdsvtxci  TYPE STANDARD TABLE OF shdsvtxci  WITH DEFAULT KEY,
        shdsvfvci  TYPE STANDARD TABLE OF shdsvfvci  WITH DEFAULT KEY,
        shdguixt   TYPE STANDARD TABLE OF shdguixt   WITH DEFAULT KEY,
        shdgxtcode TYPE STANDARD TABLE OF shdgxtcode WITH DEFAULT KEY,
      END OF ty_screen_variant .