  METHOD prioritize_deser.

* todo, refactor this method

    FIELD-SYMBOLS: <ls_result> LIKE LINE OF it_results.

* WEBI has to be handled before SPRX.
    LOOP AT it_results ASSIGNING <ls_result> WHERE obj_type = 'WEBI'.
      APPEND <ls_result> TO rt_results.
    ENDLOOP.

* SPRX has to be handled before depended objects CLAS/INFT/TABL etc.
    LOOP AT it_results ASSIGNING <ls_result> WHERE obj_type = 'SPRX'.
      APPEND <ls_result> TO rt_results.
    ENDLOOP.

* XSLT has to be handled before CLAS/PROG
    LOOP AT it_results ASSIGNING <ls_result> WHERE obj_type = 'XSLT'.
      APPEND <ls_result> TO rt_results.
    ENDLOOP.

* PROG before internet services, as the services might use the screens
    LOOP AT it_results ASSIGNING <ls_result> WHERE obj_type = 'PROG'.
      APPEND <ls_result> TO rt_results.
    ENDLOOP.

* ISAP has to be handled before ISRP
    LOOP AT it_results ASSIGNING <ls_result> WHERE obj_type = 'IASP'.
      APPEND <ls_result> TO rt_results.
    ENDLOOP.

* ENHS has to be handled before ENHO
    LOOP AT it_results ASSIGNING <ls_result> WHERE obj_type = 'ENHS'.
      APPEND <ls_result> TO rt_results.
    ENDLOOP.

* DDLS has to be handled before DCLS
    LOOP AT it_results ASSIGNING <ls_result> WHERE obj_type = 'DDLS'.
      APPEND <ls_result> TO rt_results.
    ENDLOOP.

* IOBJ has to be handled before ODSO
    LOOP AT it_results ASSIGNING <ls_result> WHERE obj_type = 'IOBJ'.
      APPEND <ls_result> TO rt_results.
    ENDLOOP.

* TOBJ has to be handled before SCP1
    LOOP AT it_results ASSIGNING <ls_result> WHERE obj_type = 'TOBJ'.
      APPEND <ls_result> TO rt_results.
    ENDLOOP.

* OTGR has to be handled before CHAR
    LOOP AT it_results ASSIGNING <ls_result> WHERE obj_type = 'OTGR'.
      APPEND <ls_result> TO rt_results.
    ENDLOOP.

    LOOP AT it_results ASSIGNING <ls_result>
        WHERE obj_type <> 'IASP'
        AND obj_type <> 'PROG'
        AND obj_type <> 'XSLT'
        AND obj_type <> 'PINF'
        AND obj_type <> 'DEVC'
        AND obj_type <> 'ENHS'
        AND obj_type <> 'DDLS'
        AND obj_type <> 'SPRX'
        AND obj_type <> 'WEBI'
        AND obj_type <> 'IOBJ'
        AND obj_type <> 'TOBJ'
        AND obj_type <> 'OTGR'.
      APPEND <ls_result> TO rt_results.
    ENDLOOP.

* PINF after everything as it can expose objects
    LOOP AT it_results ASSIGNING <ls_result> WHERE obj_type = 'PINF'.
      APPEND <ls_result> TO rt_results.
    ENDLOOP.

* DEVC after PINF, as it can refer for package interface usage
    LOOP AT it_results ASSIGNING <ls_result> WHERE obj_type = 'DEVC'.
      APPEND <ls_result> TO rt_results.
    ENDLOOP.

  ENDMETHOD.