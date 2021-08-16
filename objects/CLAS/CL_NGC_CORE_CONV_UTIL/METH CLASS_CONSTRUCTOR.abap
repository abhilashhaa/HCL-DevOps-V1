  METHOD class_constructor.

    " This CDS View is based on the include LCTMSF2T.
    gv_nodeleaf_view_source =
      `select distinct from inob` && cl_abap_char_utilities=>newline &&
      `  inner join tcla  on inob.klart = tcla.klart` && cl_abap_char_utilities=>newline &&
      `  inner join tclao as tclao1 on tcla.klart   =  tclao1.klart` && cl_abap_char_utilities=>newline &&
      `                            and tclao1.zaehl <> '00'` && cl_abap_char_utilities=>newline &&
      `                            and inob.obtab   =  tclao1.obtab` && cl_abap_char_utilities=>newline &&
      `  inner join tclao as tclao2 on tcla.klart   =  tclao2.klart` && cl_abap_char_utilities=>newline &&
      `                            and tclao1.zaehl <  tclao2.zaehl` && cl_abap_char_utilities=>newline &&
      `{` && cl_abap_char_utilities=>newline &&
      `  inob.cuobj,` && cl_abap_char_utilities=>newline &&
      `  inob.obtab,` && cl_abap_char_utilities=>newline &&
      `  inob.objek,` && cl_abap_char_utilities=>newline &&
      `  tcla.klart,` && cl_abap_char_utilities=>newline &&
      `  tclao1.redun` && cl_abap_char_utilities=>newline &&
      `} where tcla.multobj = 'X'` && cl_abap_char_utilities=>newline &&
      `union all` && cl_abap_char_utilities=>newline &&
      `  select distinct from inob` && cl_abap_char_utilities=>newline &&
      `  inner join tcla  on inob.klart = tcla.klart` && cl_abap_char_utilities=>newline &&
      `                  and inob.obtab = 'MARA'` && cl_abap_char_utilities=>newline &&
      `  inner join tclao on tcla.klart = tclao.klart` && cl_abap_char_utilities=>newline &&
      `                  and tclao.zaehl <> '00'` && cl_abap_char_utilities=>newline &&
      `                  and inob.obtab = tclao.obtab` && cl_abap_char_utilities=>newline &&
      `  inner join mara on inob.objek = mara.matnr` && cl_abap_char_utilities=>newline &&
      `                 and mara.kzkfg = 'X'` && cl_abap_char_utilities=>newline &&
      `{` && cl_abap_char_utilities=>newline &&
      `  inob.cuobj,` && cl_abap_char_utilities=>newline &&
      `  inob.obtab,` && cl_abap_char_utilities=>newline &&
      `  inob.objek,` && cl_abap_char_utilities=>newline &&
      `  tcla.klart,` && cl_abap_char_utilities=>newline &&
      `  tclao.redun` && cl_abap_char_utilities=>newline &&
      `} where tcla.multobj = 'X' and tcla.varklart = 'X'` && cl_abap_char_utilities=>newline &&
      `union all` && cl_abap_char_utilities=>newline &&
      `  select distinct from inob` && cl_abap_char_utilities=>newline &&
      `  inner join tcla  on inob.klart = tcla.klart` && cl_abap_char_utilities=>newline &&
      `                  and ( inob.obtab = 'ESLH'` && cl_abap_char_utilities=>newline &&
      `                     or inob.obtab = 'PLKONET'` && cl_abap_char_utilities=>newline &&
      `                     or inob.obtab = 'PLKOGMTL' )` && cl_abap_char_utilities=>newline &&
      `  inner join tclao on tcla.klart = tclao.klart` && cl_abap_char_utilities=>newline &&
      `                  and tclao.zaehl <> '00'` && cl_abap_char_utilities=>newline &&
      `                  and inob.obtab = tclao.obtab` && cl_abap_char_utilities=>newline &&
      `{` && cl_abap_char_utilities=>newline &&
      `  inob.cuobj,` && cl_abap_char_utilities=>newline &&
      `  inob.obtab,` && cl_abap_char_utilities=>newline &&
      `  inob.objek,` && cl_abap_char_utilities=>newline &&
      `  tcla.klart,` && cl_abap_char_utilities=>newline &&
      `  tclao.redun` && cl_abap_char_utilities=>newline &&
      `} where tcla.multobj = 'X' and tcla.varklart = 'X'` ##NO_TEXT.

  ENDMETHOD.