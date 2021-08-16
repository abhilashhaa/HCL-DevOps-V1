  METHOD to_icfhndlist.

    FIELD-SYMBOLS: <ls_list> LIKE LINE OF it_list.


* convert to sorted table
    LOOP AT it_list ASSIGNING <ls_list>.
      INSERT <ls_list>-icfhandler INTO TABLE rt_list.
    ENDLOOP.

  ENDMETHOD.