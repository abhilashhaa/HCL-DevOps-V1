  METHOD convert_kssk_from_idx.
    LOOP AT it_relations ASSIGNING FIELD-SYMBOL(<ls_relation>).
      APPEND INITIAL LINE TO rt_relations ASSIGNING FIELD-SYMBOL(<rs_relations>).
      <rs_relations>-objek = <ls_relation>-node.
      <rs_relations>-clint = <ls_relation>-ancestor.
      <rs_relations>-datuv = <ls_relation>-datuv.
      <rs_relations>-datub = <ls_relation>-datub.
      <rs_relations>-klart = <ls_relation>-klart.
      <rs_relations>-aennr = <ls_relation>-aennr.
    ENDLOOP.
  ENDMETHOD.