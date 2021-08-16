  METHOD skip_object.

    DATA: ls_trdir TYPE trdir.

    CASE is_obj-objtype.
      WHEN 'PROG'.

        SELECT SINGLE *
          INTO ls_trdir
          FROM trdir
          WHERE name = is_obj-objname.

        rv_skip = boolc( ls_trdir-subc = 'I' ). " Include program.

      WHEN OTHERS.
        rv_skip = abap_false.

    ENDCASE.

  ENDMETHOD.