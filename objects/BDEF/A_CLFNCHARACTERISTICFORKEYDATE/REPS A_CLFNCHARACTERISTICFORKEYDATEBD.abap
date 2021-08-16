implementation unmanaged in class cl_ngc_bil_chr_api unique;
define behavior for A_ClfnCharacteristicForKeyDate
late numbering in place
etag CharcLastChangedDateTime
  {
    create;
    update;
    delete;

    association _CharacteristicDesc abbreviation CharcDesc { create; }
    association _CharacteristicRestriction abbreviation CharcRestr { create; }
    association _CharacteristicReference abbreviation CharcRef { create; }
    association _CharacteristicValue abbreviation CharcValue { create; }

    field ( read only ) CharcGroupName;
    field ( read only ) CharcStatusName;
    field ( mandatory ) MultipleValuesAreAllowed;
    field ( read only ) CreationDate;
    field ( read only ) LastChangeDate;
    field ( read only ) CharcLastChangedDateTime;
    field ( read only ) KeyDate;
  }

define behavior for A_ClfnCharcDescForKeyDate
late numbering in place
etag CharcLastChangedDateTime
  {
    create;
    update;
    delete;

    field ( read only ) ValidityStartDate;
    field ( read only ) ValidityEndDate;
    field ( read only ) CharcLastChangedDateTime;
    field ( read only ) KeyDate;
  }

define behavior for A_ClfnCharcRstrcnForKeyDate
late numbering in place
etag CharcLastChangedDateTime
  {
    create;
    delete;

    field ( read only ) CharcLastChangedDateTime;
    field ( read only ) KeyDate;
  }

define behavior for A_ClfnCharcRefForKeyDate
late numbering in place
etag CharcLastChangedDateTime
  {
    create;
    delete;

    field ( read only ) CharcLastChangedDateTime;
    field ( read only ) KeyDate;
  }

define behavior for A_ClfnCharcValueForKeyDate
late numbering in place
etag CharcLastChangedDateTime
  {
    create;
    update;
    delete;

    association _CharcValueDesc abbreviation ChrValDesc { create; }

    field ( read only ) ValidityStartDate;
    field ( read only ) ValidityEndDate;
    field ( read only ) CharcLastChangedDateTime;
    field ( read only ) KeyDate;
  }

define behavior for A_ClfnCharcValueDescForKeyDate
late numbering in place
etag CharcLastChangedDateTime
  {
    create;
    update;
    delete;

    field ( read only ) ValidityStartDate;
    field ( read only ) ValidityEndDate;
    field ( read only ) CharcLastChangedDateTime;
    field ( read only ) KeyDate;
  }