METHOD convert_d34n_uom_to_buom.

  " This method expect the numerator, denominator, add_const
  " determined by the BUoM  => UoM conversion.
  " BUoM =>  UoM  :  [(value * numerator) / denominator ] + add_const

  " Here we try to convert back the value.
  " [(value - add_const) * denominator] / numerator

  rv_d34n = ( iv_d34n - iv_buom2uom_add_const ) * iv_buom2uom_denominator / iv_buom2uom_numerator.

ENDMETHOD.