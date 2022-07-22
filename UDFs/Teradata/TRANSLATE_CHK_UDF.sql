﻿-- <copyright file="TRANSLATE_CHK_UDF.sql" company="Mobilize.Net">
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

-- ===================================================================================================
-- DETERMINES IF A TRANSLATE CONVERSION CAN BE PERFORMED WITHOUT PRODUCING ERRORS.
-- RETURNS AN INTEGER RESULT
-- PARAMETERS:
--     COL_NAME: STRING. THE COLUMN TO BE CHECKED
--     SOURCE_REPERTOIRE_NAME: STRING. THE SOURCE REPERTOIRE NAME
-- RETURNS:
--     0: THE STRING CAN BE TRANSLATED WITHOUT ERROR.
--     NULL: THE STRING RESULT IS NULL.
--     ANYTHING ELSE: THE POSITION OF THE FIRST CHARACTER IN THE STRING CAUSING A TRANSLATION ERROR.
-- EQUIVALENT:
--     TERADATA'S TRANSLATE_CHK FUNCTIONALITY
-- EXAMPLES:
--     1) SELECT PUBLIC.TRANSLATE_CHK_UDF('ABC', 'UNICODE_TO_LATIN');
--        RETURNS 0
--     2) SELECT PUBLIC.TRANSLATE_CHK_UDF('KOÇER İNŞAAT SAN.', 'UNICODE_TO_LATIN');
--        RETURNS 7
--     3) SELECT PUBLIC.TRANSLATE_CHK_UDF('Κ/Ξ', 'UNICODE_TO_LATIN');
--        RETURNS 1
-- ===================================================================================================
CREATE OR REPLACE FUNCTION PUBLIC.TRANSLATE_CHK_UDF(COL_NAME STRING, SOURCE_REPERTOIRE_NAME STRING) 
RETURNS NUMBER
AS 
$$ 
    SELECT 
    CASE 
        WHEN SOURCE_REPERTOIRE_NAME = 'UNICODE_TO_LATIN' THEN
            REGEXP_INSTR(COL_NAME, '[^\u0000-\u007f\u0086-\u00ff\u0152\u0153\u0160\u0161\u0178\u039c\u20ac\ufffd]')
        WHEN SOURCE_REPERTOIRE_NAME = 'GRAPHIC_TO_KANJISJIS' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'GRAPHIC_TO_LATIN' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'GRAPHIC_TO_UNICODE' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'GRAPHIC_TO_UNICODE_PadSpace' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'KANJI1_KanjiEBCDIC_TO_UNICODE' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'KANJI1_KanjiEUC_TO_UNICODE' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'KANJI1_KANJISJIS_TO_UNICODE' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'KANJI1_SBC_TO_UNICODE' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'KANJISJIS_TO_GRAPHIC' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'KANJISJIS_TO_LATIN' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'KANJISJIS_TO_UNICODE' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'LATIN_TO_GRAPHIC' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'LATIN_TO_KANJISJIS' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'LATIN_TO_UNICODE' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'LOCALE_TO_UNICODE' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'UNICODE_TO_GRAPHIC' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'UNICODE_TO_GRAPHIC_PadGraphic' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'UNICODE_TO_GRAPHIC_VarGraphic' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'UNICODE_TO_KANJI1_KanjiEBCDIC' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'UNICODE_TO_KANJI1_KanjiEUC' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'UNICODE_TO_KANJI1_KANJISJIS' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'UNICODE_TO_KANJI1_SBC' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'UNICODE_TO_KANJISJIS' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'UNICODE_TO_LOCALE' THEN -1
        WHEN SOURCE_REPERTOIRE_NAME = 'UNICODE_TO_UNICODE_FoldSpace' THEN -1
        ELSE 0
    END
$$;