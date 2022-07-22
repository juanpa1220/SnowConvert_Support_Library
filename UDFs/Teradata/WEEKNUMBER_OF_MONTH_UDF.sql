-- <copyright file="WEEKNUMBER_OF_MONTH_UDF.sql" company="Mobilize.Net">
--        Copyright (C) Mobilize.Net info@mobilize.net - All Rights Reserved
-- 
--        This file is part of the Mobilize Frameworks, which is
--        proprietary and confidential.
-- 
--        NOTICE:  All information contained herein is, and remains
--        the property of Mobilize.Net Corporation.
--        The intellectual and technical concepts contained herein are
--        proprietary to Mobilize.Net Corporation and may be covered
--        by U.S. Patents, and are protected by trade secret or copyright law.
--        Dissemination of this information or reproduction of this material
--        is strictly forbidden unless prior written permission is obtained
--        from Mobilize.Net Corporation.
-- </copyright>

-- ======================================================================
-- RETURNS WHICH MONTH OF THE YEAR A DATE BELONGS TO 
-- EQUIVALENT TO THE WEEKNUMBER_OF_MONTH
-- PARAMETERS:
--     INPUT: TIMESTAMP_TZ. DATE TO GET THE NUMBER OF MONTH FROM
-- RETURNS:
--     A NUMBER THAT REPRESENTS THE MONTH NUMBER THE DATE BELONGS TO
-- EQUIVALENT:
--     TERADATA'S WEEKNUMBER_OF_MONTH FUNCTIONALITY
-- EXAMPLE:
--     SELECT PUBLIC.WEEKNUMBER_OF_MONTH_UDF(DATE '2022-05-21')
--     RETURNS 3
-- ======================================================================
CREATE OR REPLACE FUNCTION PUBLIC.WEEKNUMBER_OF_MONTH_UDF(INPUT TIMESTAMP_TZ)
RETURNS NUMBER
IMMUTABLE
AS
$$
    EXTRACT(WEEK FROM INPUT) - EXTRACT(WEEK FROM DATE_TRUNC(MONTH, INPUT))
$$;