 
/*------------------------------------------------------------------------
   File        : CSVFileUtilty
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : domini.deliyakanthi
   Created     : Fri Jun 10 09:36:08 IST 2022
   Notes       : 
 ----------------------------------------------------------------------*/

USING Progress.Lang.*.


BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS CSVFileUtilty:
          
        
    DEFINE PUBLIC PROPERTY pFileName AS character NO-UNDO
    GET.
    SET.
    CONSTRUCTOR PUBLIC CSVFileUtilty (  ):
        SUPER ().
        
    END CONSTRUCTOR.

    CONSTRUCTOR PUBLIC CSVFileUtilty ( INPUT cFileName AS CHARACTER ):
     pFileName = cFileName.
        
        
    END CONSTRUCTOR.

    METHOD PUBLIC VOID writeCSVtoTempTable( INPUT hRecordBuffer AS HANDLE):
        
        DEFINE VARIABLE cRecord        AS CHARACTER NO-UNDO.
        DEFINE VARIABLE hFieldBuffer   AS HANDLE    NO-UNDO.
        DEFINE VARIABLE iCounter       AS INTEGER   NO-UNDO.
        DEFINE VARIABLE cDelimeter     AS CHARACTER NO-UNDO INITIAL ",".
        DEFINE VARIABLE cTrimCharacter AS CHARACTER NO-UNDO INITIAL "".
        
        INPUT from value(pFileName).

        OuterRepeat:
        REPEAT:
            IMPORT UNFORMATTED cRecord.
            DO TRANSACTION:
                hRecordBuffer:BUFFER-CREATE ().
                REPEAT iCounter= 1 TO NUM-ENTRIES (cRecord,cDelimeter) ON ERROR UNDO, LEAVE OuterRepeat:
                    ASSIGN 
                        hFieldBuffer              = hRecordBuffer:BUFFER-FIELD (iCounter)
                        hFieldBuffer:BUFFER-VALUE = TRIM(ENTRY(iCounter, cRecord,cDelimeter),cTrimCharacter).
                END.
            END.
        END.
        INPUT close.               
        RETURN.

        CATCH e AS Progress.Lang.Error:

        END CATCH.

        FINALLY:

        END FINALLY.

    END METHOD.    

    DESTRUCTOR PUBLIC CSVFileUtilty ( ):

    END DESTRUCTOR.

END CLASS.