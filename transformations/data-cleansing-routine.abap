METHOD GLOBAL_START BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY.
-- *** Begin of routine - insert your code only below this line ***

-- Note the _M class are not considered for DTP execution.
-- AMDP Breakpoints must be set in the _A class instead.

-- outTab = SELECT * FROM :inTab;

-- Allow Error Handling for HANA Routines is enabled

-- errorTab = ...

outTab =
            SELECT
                RECORDMODE,
                DOC_NUMBER,
                DOC_TYPE,
                ORD_REASON,
                S_ORD_ITEM,
                COMP_CODE,
                SOLD_TO,
                IMODOCCAT,
                SALESORG,
                DIVISION,
                DISTR_CHAN,
                CML_OR_QTY,
                REPLACE_REGEXPR( '([!|#])' IN "MATERIAL" WITH '' OCCURRENCE ALL ) AS MATERIAL,
                MATL_GROUP,
                MATL_TYPE,
                PLANT,
                BASE_UOM,
                NET_VALUE,
                DENOMINTR,
                NUMERATOR,
                ST_UP_DTE,
                SALES_UNIT,
                DOC_CURRCY,
                FISCVARNT,
                GN_R3_SSY,
                record,
                sql__procedure__source__record


            FROM :inTab;

            errortab =
                            select '' as error_text,
                                   '' as SQL__PROCEDURE__SOURCE__RECORD
                            from DUMMY;


-- *** End of routine - insert your code only before this line ***
ENDMETHOD.
