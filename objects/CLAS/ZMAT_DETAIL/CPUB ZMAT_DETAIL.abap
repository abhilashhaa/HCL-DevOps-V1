class ZMAT_DETAIL definition
  public
  final
  create public .

public section.

  types:
    begin of ty_data,
        key type string,
        value type string,
        end of ty_data .

  class-methods EXECUTE
    returning
      value(DATA) type TY_DATA .