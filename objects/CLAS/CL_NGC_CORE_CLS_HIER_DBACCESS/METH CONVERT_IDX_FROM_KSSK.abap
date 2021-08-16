  METHOD convert_idx_from_kssk.
    LOOP AT it_relations ASSIGNING FIELD-SYMBOL(<ls_kssk_relation>).
      APPEND INITIAL LINE TO rt_relations ASSIGNING FIELD-SYMBOL(<rs_relation>).
      <rs_relation>-node     = <ls_kssk_relation>-objek.
      <rs_relation>-ancestor = <ls_kssk_relation>-clint.
      <rs_relation>-datuv    = <ls_kssk_relation>-datuv.
      <rs_relation>-datub    = <ls_kssk_relation>-datub.
      <rs_relation>-klart    = <ls_kssk_relation>-klart.
      <rs_relation>-aennr    = <ls_kssk_relation>-aennr.
    ENDLOOP.
  ENDMETHOD.