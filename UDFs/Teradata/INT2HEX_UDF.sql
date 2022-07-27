-- <copyright file="INT2HEX_UDF.sql" company="Mobilize.Net">
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

-- =====================================================================
-- CONVERS THE INPUT NUMERICAL VALUE TO ITS HEXADECIMAL EQUIVALENT
-- RETURNS AN STRING RESULT
-- PARAMETERS:
--     INPUT: FLOAT. THE NUMERICAL VALUE TO BE CONVERTED TO HEXADECIMAL
-- RETURNS:
--     STRING. THE HEXADECIMAL EQUIVALENT
-- EQUIVALENT:
--     TERADATA'S TO_BYTES(INPUT, 'Base10') FUNCTIONALITY
-- EXAMPLES:
--     SELECT INT2HEX_UDF('448');
--     RETURNS 01c0
-- =====================================================================
CREATE OR REPLACE FUNCTION INT2HEX_UDF (INPUT FLOAT)
RETURNS STRING
LANGUAGE JAVASCRIPT
AS
$$
    var hex = Number(INPUT).toString(16);
    if (hex.length % 2 != 0) {
        hex = "0" + hex;
    }

    return hex;
$$;
