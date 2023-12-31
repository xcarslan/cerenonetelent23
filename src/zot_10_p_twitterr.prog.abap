*&---------------------------------------------------------------------*
*& Report zot_10_p_twitterr
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_10_p_twitterr.




SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_id   TYPE c LENGTH 2,
              p_twit TYPE c LENGTH 256.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_twat  RADIOBUTTON GROUP g1 DEFAULT 'X' USER-COMMAND g1,
              p_tcha RADIOBUTTON GROUP g1,
              p_tsil RADIOBUTTON GROUP g1,
              p_tgr   RADIOBUTTON GROUP g1.

SELECTION-SCREEN END OF BLOCK b2.


DATA lt_tweet_modify TYPE TABLE OF zot_10_t_twitter.

START-OF-SELECTION.

  IF
          p_id = space
          AND p_twat EQ 'X'
          OR p_id = space
          AND p_tcha EQ 'X'
          oR p_id = space
          AND p_tsil EQ 'X'.
          cl_demo_output=>display( 'ID BOŞ  BIRAKILAMAZ!' ).
  ELSE.


    CASE 'X'.

      WHEN p_twat.

        TRY.
                        APPEND VALUE #(
                             id = p_id
                             tweet = p_twit )
                             TO lt_tweet_modify.

                                INSERT zot_10_t_twitter  FROM TABLE lt_tweet_modify.
                                CATCH cx_sy_open_sql_db.
                                cl_demo_output=>display( 'Aynı ID Tweet var. ' ).
       ENDTRY.
                        WHEN p_tcha.
                        UPDATE zot_10_t_twitter SET tweet = p_twit
                         WHERE id = p_id.

                         WHEN p_tsil.
                         DELETE FROM zot_10_t_twitter WHERE id = p_id.
                        COMMIT WORK AND WAIT.

                        WHEN p_tgr.
                        SELECT tweet
                        FROM zot_10_t_twitter

                        INTO TABLE @DATA(abapitter).
                        cl_demo_output=>display( abapitter ).


     ENDCASE.



     ENDIF.
