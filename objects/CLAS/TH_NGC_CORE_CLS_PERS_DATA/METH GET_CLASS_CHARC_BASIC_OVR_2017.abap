  METHOD get_class_charc_basic_ovr_2017.

    rt_class_charc_basic = VALUE #(
      ( classinternalid                = cv_class_02_id
        charcpositionnumber            = '0001'
        timeintervalnumber             = '0000'
        charcinternalid                = cv_charc_02_id
        overwrittencharcinternalid     = cv_charc_overwritten_id
        clfnorganizationalarea         = space
        classtype                      = cv_classtype_001
        changenumber                   = space
        validitystartdate              = '20170101'
        validityenddate                = '20171231'
        isdeleted                      = abap_false
        charcorigintext                = space
        charcisproposalrelevant        = space
        charcisprptnorprodunitrelevant = space
        charcisprintrelevant           = space
        charcissearchrelevant          = space
        charcisdisplayrelevant         = space )
    ).

  ENDMETHOD.