METHOD S0001_G01_R50 BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY.
-- rule description: Convert to base unit
-- target field: 0QUANT_B
-- *** Begin of routine - insert your code only below this line ***

-- Note the _M class are not considered for DTP execution.
-- AMDP Breakpoints must be set in the _A class instead.

-- outTab = SELECT * FROM :inTab;
            outtab =
                        select
                            case
                                when ( i.numerator = i.DENOMINTR )
                                    then i.CML_OR_QTY
                                else
                                    case
                                        when i.IMODOCCAT in ( 'H','K' )
                                            then round( (-1) * (( i.CML_OR_QTY * i.NUMERATOR ) / i.DENOMINTR), 3 )
                                        else round( ( i.CML_OR_QTY * i.NUMERATOR ) / i.DENOMINTR, 3 )
                                    end
                            end as QUANT_B,
                            RECORD,
                            SQL__PROCEDURE__SOURCE__RECORD
                        from :inTab as i;

                    errortab =
                            select '' as error_text,
                                   '' as SQL__PROCEDURE__SOURCE__RECORD
                            from DUMMY;


-- *** End of routine - insert your code only before this line ***
ENDMETHOD.
ENDCLASS.
