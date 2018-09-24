
_saveConf:

;SE9M.c,456 :: 		void    saveConf()
;SE9M.c,469 :: 		}
L_end_saveConf:
	RETURN      0
; end of _saveConf

_int2str:

;SE9M.c,471 :: 		void    int2str(long l, unsigned char *s)
;SE9M.c,475 :: 		if(l == 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       FARG_int2str_l+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str589
	MOVF        R0, 0 
	XORWF       FARG_int2str_l+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str589
	MOVF        R0, 0 
	XORWF       FARG_int2str_l+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str589
	MOVF        FARG_int2str_l+0, 0 
	XORLW       0
L__int2str589:
	BTFSS       STATUS+0, 2 
	GOTO        L_int2str0
;SE9M.c,477 :: 		s[0] = '0' ;
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVLW       48
	MOVWF       POSTINC1+0 
;SE9M.c,478 :: 		s[1] = 0 ;
	MOVLW       1
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SE9M.c,479 :: 		}
	GOTO        L_int2str1
L_int2str0:
;SE9M.c,482 :: 		if(l < 0)
	MOVLW       128
	XORWF       FARG_int2str_l+3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str590
	MOVLW       0
	SUBWF       FARG_int2str_l+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str590
	MOVLW       0
	SUBWF       FARG_int2str_l+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str590
	MOVLW       0
	SUBWF       FARG_int2str_l+0, 0 
L__int2str590:
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str2
;SE9M.c,484 :: 		l *= -1 ;
	MOVF        FARG_int2str_l+0, 0 
	MOVWF       R0 
	MOVF        FARG_int2str_l+1, 0 
	MOVWF       R1 
	MOVF        FARG_int2str_l+2, 0 
	MOVWF       R2 
	MOVF        FARG_int2str_l+3, 0 
	MOVWF       R3 
	MOVLW       255
	MOVWF       R4 
	MOVLW       255
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVF        R1, 0 
	MOVWF       FARG_int2str_l+1 
	MOVF        R2, 0 
	MOVWF       FARG_int2str_l+2 
	MOVF        R3, 0 
	MOVWF       FARG_int2str_l+3 
;SE9M.c,485 :: 		n = 1 ;
	MOVLW       1
	MOVWF       int2str_n_L0+0 
;SE9M.c,486 :: 		}
	GOTO        L_int2str3
L_int2str2:
;SE9M.c,489 :: 		n = 0 ;
	CLRF        int2str_n_L0+0 
;SE9M.c,490 :: 		}
L_int2str3:
;SE9M.c,491 :: 		s[0] = 0 ;
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	CLRF        POSTINC1+0 
;SE9M.c,492 :: 		i = 0 ;
	CLRF        int2str_i_L0+0 
;SE9M.c,493 :: 		while(l > 0)
L_int2str4:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_int2str_l+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str591
	MOVF        FARG_int2str_l+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str591
	MOVF        FARG_int2str_l+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str591
	MOVF        FARG_int2str_l+0, 0 
	SUBLW       0
L__int2str591:
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str5
;SE9M.c,495 :: 		for(j = i + 1 ; j > 0 ; j--)
	MOVF        int2str_i_L0+0, 0 
	ADDLW       1
	MOVWF       int2str_j_L0+0 
L_int2str6:
	MOVF        int2str_j_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str7
;SE9M.c,497 :: 		s[j] = s[j - 1] ;
	MOVF        int2str_j_L0+0, 0 
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR1H 
	DECF        int2str_j_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,495 :: 		for(j = i + 1 ; j > 0 ; j--)
	DECF        int2str_j_L0+0, 1 
;SE9M.c,498 :: 		}
	GOTO        L_int2str6
L_int2str7:
;SE9M.c,499 :: 		s[0] = l % 10 ;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_int2str_l+0, 0 
	MOVWF       R0 
	MOVF        FARG_int2str_l+1, 0 
	MOVWF       R1 
	MOVF        FARG_int2str_l+2, 0 
	MOVWF       R2 
	MOVF        FARG_int2str_l+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,500 :: 		s[0] += '0' ;
	MOVFF       FARG_int2str_s+0, FSR0
	MOVFF       FARG_int2str_s+1, FSR0H
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVLW       48
	ADDWF       POSTINC0+0, 1 
;SE9M.c,501 :: 		i++ ;
	INCF        int2str_i_L0+0, 1 
;SE9M.c,502 :: 		l /= 10 ;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_int2str_l+0, 0 
	MOVWF       R0 
	MOVF        FARG_int2str_l+1, 0 
	MOVWF       R1 
	MOVF        FARG_int2str_l+2, 0 
	MOVWF       R2 
	MOVF        FARG_int2str_l+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVF        R1, 0 
	MOVWF       FARG_int2str_l+1 
	MOVF        R2, 0 
	MOVWF       FARG_int2str_l+2 
	MOVF        R3, 0 
	MOVWF       FARG_int2str_l+3 
;SE9M.c,503 :: 		}
	GOTO        L_int2str4
L_int2str5:
;SE9M.c,504 :: 		if(n)
	MOVF        int2str_n_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_int2str9
;SE9M.c,506 :: 		for(j = i + 1 ; j > 0 ; j--)
	MOVF        int2str_i_L0+0, 0 
	ADDLW       1
	MOVWF       int2str_j_L0+0 
L_int2str10:
	MOVF        int2str_j_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str11
;SE9M.c,508 :: 		s[j] = s[j - 1] ;
	MOVF        int2str_j_L0+0, 0 
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR1H 
	DECF        int2str_j_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,506 :: 		for(j = i + 1 ; j > 0 ; j--)
	DECF        int2str_j_L0+0, 1 
;SE9M.c,509 :: 		}
	GOTO        L_int2str10
L_int2str11:
;SE9M.c,510 :: 		s[0] = '-' ;
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVLW       45
	MOVWF       POSTINC1+0 
;SE9M.c,511 :: 		}
L_int2str9:
;SE9M.c,512 :: 		}
L_int2str1:
;SE9M.c,513 :: 		}
L_end_int2str:
	RETURN      0
; end of _int2str

_ts2str:

;SE9M.c,514 :: 		void    ts2str(unsigned char *s, TimeStruct *t, unsigned char m)
;SE9M.c,521 :: 		if(m & TS2STR_DATE)
	BTFSS       FARG_ts2str_m+0, 0 
	GOTO        L_ts2str13
;SE9M.c,523 :: 		strcpy(s, wday[t->wd]) ;        // week day
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcpy_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcpy_to+1 
	MOVLW       4
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _wday+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_wday+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcpy_from+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,524 :: 		danuned = t->wd;
	MOVLW       4
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _danuned+0 
;SE9M.c,525 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr45_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr45_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,526 :: 		ByteToStr(t->md, tmp) ;         // day num
	MOVLW       3
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,527 :: 		dan = t->md;
	MOVLW       3
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _dan+0 
;SE9M.c,528 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,529 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr46_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr46_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,530 :: 		strcat(s, mon[t->mo]) ;        // month
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       5
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _mon+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_mon+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcat_from+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,531 :: 		mesec = t->mo;
	MOVLW       5
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _mesec+0 
;SE9M.c,532 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr47_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr47_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,533 :: 		WordToStr(t->yy, tmp) ;         // year
	MOVLW       6
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;SE9M.c,534 :: 		godina = t->yy;
	MOVLW       6
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__ts2str+4 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__ts2str+5 
	MOVF        FLOC__ts2str+4, 0 
	MOVWF       _godina+0 
	MOVF        FLOC__ts2str+5, 0 
	MOVWF       _godina+1 
;SE9M.c,535 :: 		godyear1 = godina / 1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FLOC__ts2str+4, 0 
	MOVWF       R0 
	MOVF        FLOC__ts2str+5, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _godyear1+0 
;SE9M.c,536 :: 		godyear2 = (godina - godyear1 * 1000) / 100;
	MOVLW       0
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__ts2str+2 
	MOVF        R1, 0 
	MOVWF       FLOC__ts2str+3 
	MOVF        FLOC__ts2str+2, 0 
	SUBWF       FLOC__ts2str+4, 0 
	MOVWF       R0 
	MOVF        FLOC__ts2str+3, 0 
	SUBWFB      FLOC__ts2str+5, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _godyear2+0 
;SE9M.c,537 :: 		godyear3 = (godina - godyear1 * 1000 - godyear2 * 100) / 10;
	MOVF        FLOC__ts2str+2, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R2, 0 
	SUBWF       FLOC__ts2str+4, 0 
	MOVWF       R2 
	MOVF        R3, 0 
	SUBWFB      FLOC__ts2str+5, 0 
	MOVWF       R3 
	MOVLW       100
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       FLOC__ts2str+0 
	MOVF        PRODH+0, 0 
	MOVWF       FLOC__ts2str+1 
	MOVF        FLOC__ts2str+0, 0 
	SUBWF       R2, 0 
	MOVWF       R0 
	MOVF        FLOC__ts2str+1, 0 
	SUBWFB      R3, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _godyear3+0 
;SE9M.c,538 :: 		godyear4 = godina - godyear1 * 1000 - godyear2 * 100 - godyear3 * 10;
	MOVF        FLOC__ts2str+2, 0 
	SUBWF       FLOC__ts2str+4, 0 
	MOVWF       R2 
	MOVF        FLOC__ts2str+0, 0 
	SUBWF       R2, 1 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	SUBWF       R2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _godyear4+0 
;SE9M.c,539 :: 		fingodina = godyear3 * 10 + godyear4;
	MOVF        R1, 0 
	MOVWF       _fingodina+0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       _fingodina+0 
;SE9M.c,540 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,541 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr48_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr48_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,542 :: 		}
	GOTO        L_ts2str14
L_ts2str13:
;SE9M.c,545 :: 		*s = 0 ;
	MOVFF       FARG_ts2str_s+0, FSR1
	MOVFF       FARG_ts2str_s+1, FSR1H
	CLRF        POSTINC1+0 
;SE9M.c,546 :: 		}
L_ts2str14:
;SE9M.c,551 :: 		if(m & TS2STR_TIME)
	BTFSS       FARG_ts2str_m+0, 1 
	GOTO        L_ts2str15
;SE9M.c,553 :: 		ByteToStr(t->hh, tmp) ;         // hour
	MOVLW       2
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,554 :: 		sati = t->hh;
	MOVLW       2
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _sati+0 
;SE9M.c,555 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,556 :: 		strcat(s, ":") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr49_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr49_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,557 :: 		ByteToStr(t->mn, tmp) ;         // minute
	MOVLW       1
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,558 :: 		minuti = (t->mn);
	MOVLW       1
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _minuti+0 
;SE9M.c,559 :: 		if(*(tmp + 1) == ' ')
	MOVF        ts2str_tmp_L0+1, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_ts2str16
;SE9M.c,561 :: 		*(tmp + 1) = '0' ;
	MOVLW       48
	MOVWF       ts2str_tmp_L0+1 
;SE9M.c,562 :: 		}
L_ts2str16:
;SE9M.c,563 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,564 :: 		strcat(s, ":") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr50_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr50_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,565 :: 		ByteToStr(t->ss, tmp) ;         // second
	MOVFF       FARG_ts2str_t+0, FSR0
	MOVFF       FARG_ts2str_t+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,566 :: 		sekundi = t->ss;
	MOVFF       FARG_ts2str_t+0, FSR0
	MOVFF       FARG_ts2str_t+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       _sekundi+0 
;SE9M.c,567 :: 		if(*(tmp + 1) == ' ')
	MOVF        ts2str_tmp_L0+1, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_ts2str17
;SE9M.c,569 :: 		*(tmp + 1) = '0' ;
	MOVLW       48
	MOVWF       ts2str_tmp_L0+1 
;SE9M.c,570 :: 		}
L_ts2str17:
;SE9M.c,571 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,572 :: 		}
L_ts2str15:
;SE9M.c,577 :: 		if(m & TS2STR_TZ)
	BTFSS       FARG_ts2str_m+0, 2 
	GOTO        L_ts2str18
;SE9M.c,579 :: 		strcat(s, " GMT") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr51_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr51_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,580 :: 		if(conf.tz > 0)
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _conf+2, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ts2str19
;SE9M.c,582 :: 		strcat(s, "+") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr52_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr52_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,583 :: 		}
L_ts2str19:
;SE9M.c,584 :: 		int2str(conf.tz, s + strlen(s)) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_ts2str_s+0, 0 
	MOVWF       FARG_int2str_s+0 
	MOVF        R1, 0 
	ADDWFC      FARG_ts2str_s+1, 0 
	MOVWF       FARG_int2str_s+1 
	MOVF        _conf+2, 0 
	MOVWF       FARG_int2str_l+0 
	MOVLW       0
	BTFSC       _conf+2, 7 
	MOVLW       255
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	CALL        _int2str+0, 0
;SE9M.c,585 :: 		}
L_ts2str18:
;SE9M.c,586 :: 		}
L_end_ts2str:
	RETURN      0
; end of _ts2str

_mkSNTPrequest:

;SE9M.c,590 :: 		void    mkSNTPrequest(){
;SE9M.c,594 :: 		epoch_fract = presTmr * 274877.906944 ;// zbog tajmera i 2^32
	MOVF        _presTmr+0, 0 
	MOVWF       R0 
	MOVF        _presTmr+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       189
	MOVWF       R4 
	MOVLW       55
	MOVWF       R5 
	MOVLW       6
	MOVWF       R6 
	MOVLW       145
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2longint+0, 0
	MOVF        R0, 0 
	MOVWF       _epoch_fract+0 
	MOVF        R1, 0 
	MOVWF       _epoch_fract+1 
	MOVF        R2, 0 
	MOVWF       _epoch_fract+2 
	MOVF        R3, 0 
	MOVWF       _epoch_fract+3 
;SE9M.c,595 :: 		if (sntpSync)
	MOVF        _sntpSync+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest20
;SE9M.c,596 :: 		if (SPI_Ethernet_UserTimerSec >= sntpTimer)
	MOVF        _sntpTimer+3, 0 
	SUBWF       _SPI_Ethernet_UserTimerSec+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkSNTPrequest594
	MOVF        _sntpTimer+2, 0 
	SUBWF       _SPI_Ethernet_UserTimerSec+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkSNTPrequest594
	MOVF        _sntpTimer+1, 0 
	SUBWF       _SPI_Ethernet_UserTimerSec+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkSNTPrequest594
	MOVF        _sntpTimer+0, 0 
	SUBWF       _SPI_Ethernet_UserTimerSec+0, 0 
L__mkSNTPrequest594:
	BTFSS       STATUS+0, 0 
	GOTO        L_mkSNTPrequest21
;SE9M.c,597 :: 		if (!sync_flag) {
	MOVF        _sync_flag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_mkSNTPrequest22
;SE9M.c,598 :: 		sntpSync = 0;
	CLRF        _sntpSync+0 
;SE9M.c,599 :: 		if (!memcmp(conf.sntpIP, "\0\0\0\0", 4))
	MOVLW       _conf+3
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr53_SE9M+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr53_SE9M+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       4
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_mkSNTPrequest23
;SE9M.c,600 :: 		reloadDNS = 1 ; // force to solve DNS
	MOVLW       1
	MOVWF       _reloadDNS+0 
L_mkSNTPrequest23:
;SE9M.c,601 :: 		}
L_mkSNTPrequest22:
L_mkSNTPrequest21:
L_mkSNTPrequest20:
;SE9M.c,603 :: 		if(reloadDNS)   // is SNTP ip address to be reloaded from DNS ?
	MOVF        _reloadDNS+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest24
;SE9M.c,606 :: 		if(isalpha(*conf.sntpServer))   // doest host name start with an alphabetic character ?
	MOVF        _conf+7, 0 
	MOVWF       FARG_isalpha_character+0 
	CALL        _isalpha+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest25
;SE9M.c,609 :: 		memset(conf.sntpIP, 0, 4);
	MOVLW       _conf+3
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       4
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;SE9M.c,610 :: 		if(remoteIpAddr = SPI_Ethernet_dnsResolve(conf.sntpServer, 5))
	MOVLW       _conf+7
	MOVWF       FARG_SPI_Ethernet_dnsResolve_host+0 
	MOVLW       hi_addr(_conf+7)
	MOVWF       FARG_SPI_Ethernet_dnsResolve_host+1 
	MOVLW       5
	MOVWF       FARG_SPI_Ethernet_dnsResolve_tmax+0 
	CALL        _SPI_Ethernet_dnsResolve+0, 0
	MOVF        R0, 0 
	MOVWF       mkSNTPrequest_remoteIpAddr_L0+0 
	MOVF        R1, 0 
	MOVWF       mkSNTPrequest_remoteIpAddr_L0+1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest26
;SE9M.c,613 :: 		memcpy(conf.sntpIP, remoteIpAddr, 4) ;
	MOVLW       _conf+3
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_memcpy_d1+1 
	MOVF        mkSNTPrequest_remoteIpAddr_L0+0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        mkSNTPrequest_remoteIpAddr_L0+1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,614 :: 		}
L_mkSNTPrequest26:
;SE9M.c,615 :: 		}
	GOTO        L_mkSNTPrequest27
L_mkSNTPrequest25:
;SE9M.c,619 :: 		unsigned char *ptr = conf.sntpServer ;
	MOVLW       _conf+7
	MOVWF       mkSNTPrequest_ptr_L2+0 
	MOVLW       hi_addr(_conf+7)
	MOVWF       mkSNTPrequest_ptr_L2+1 
;SE9M.c,621 :: 		conf.sntpIP[0] = atoi(ptr) ;
	MOVF        mkSNTPrequest_ptr_L2+0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        mkSNTPrequest_ptr_L2+1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+3 
;SE9M.c,622 :: 		ptr = strchr(ptr, '.') + 1 ;
	MOVF        mkSNTPrequest_ptr_L2+0, 0 
	MOVWF       FARG_strchr_ptr+0 
	MOVF        mkSNTPrequest_ptr_L2+1, 0 
	MOVWF       FARG_strchr_ptr+1 
	MOVLW       46
	MOVWF       FARG_strchr_chr+0 
	CALL        _strchr+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       mkSNTPrequest_ptr_L2+0 
	MOVF        R1, 0 
	MOVWF       mkSNTPrequest_ptr_L2+1 
;SE9M.c,623 :: 		conf.sntpIP[1] = atoi(ptr) ;
	MOVF        R0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+4 
;SE9M.c,624 :: 		ptr = strchr(ptr, '.') + 1 ;
	MOVF        mkSNTPrequest_ptr_L2+0, 0 
	MOVWF       FARG_strchr_ptr+0 
	MOVF        mkSNTPrequest_ptr_L2+1, 0 
	MOVWF       FARG_strchr_ptr+1 
	MOVLW       46
	MOVWF       FARG_strchr_chr+0 
	CALL        _strchr+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       mkSNTPrequest_ptr_L2+0 
	MOVF        R1, 0 
	MOVWF       mkSNTPrequest_ptr_L2+1 
;SE9M.c,625 :: 		conf.sntpIP[2] = atoi(ptr) ;
	MOVF        R0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+5 
;SE9M.c,626 :: 		ptr = strchr(ptr, '.') + 1 ;
	MOVF        mkSNTPrequest_ptr_L2+0, 0 
	MOVWF       FARG_strchr_ptr+0 
	MOVF        mkSNTPrequest_ptr_L2+1, 0 
	MOVWF       FARG_strchr_ptr+1 
	MOVLW       46
	MOVWF       FARG_strchr_chr+0 
	CALL        _strchr+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       mkSNTPrequest_ptr_L2+0 
	MOVF        R1, 0 
	MOVWF       mkSNTPrequest_ptr_L2+1 
;SE9M.c,627 :: 		conf.sntpIP[3] = atoi(ptr) ;
	MOVF        R0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+6 
;SE9M.c,628 :: 		}
L_mkSNTPrequest27:
;SE9M.c,630 :: 		saveConf() ;            // store to EEPROM
	CALL        _saveConf+0, 0
;SE9M.c,632 :: 		reloadDNS = 0 ;         // no further call to DNS
	CLRF        _reloadDNS+0 
;SE9M.c,634 :: 		sntpSync = 0 ;          // clock is not sync for now
	CLRF        _sntpSync+0 
;SE9M.c,635 :: 		}
L_mkSNTPrequest24:
;SE9M.c,637 :: 		if(sntpSync)                    // is clock already synchronized from sntp ?
	MOVF        _sntpSync+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest28
;SE9M.c,639 :: 		return ;                // yes, no need to request time
	GOTO        L_end_mkSNTPrequest
;SE9M.c,640 :: 		}
L_mkSNTPrequest28:
;SE9M.c,645 :: 		memset(sntpPkt, 0, 48) ;        // clear sntp packet
	MOVLW       mkSNTPrequest_sntpPkt_L0+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(mkSNTPrequest_sntpPkt_L0+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       48
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;SE9M.c,648 :: 		sntpPkt[0] = 0b00011001 ;       // LI = 0 ; VN = 3 ; MODE = 1
	MOVLW       25
	MOVWF       mkSNTPrequest_sntpPkt_L0+0 
;SE9M.c,653 :: 		sntpPkt[2] = 0x0a ;             // 1024 sec (arbitrary value)
	MOVLW       10
	MOVWF       mkSNTPrequest_sntpPkt_L0+2 
;SE9M.c,656 :: 		sntpPkt[3] = 0xfa ;             // 0.015625 sec (arbitrary value)
	MOVLW       250
	MOVWF       mkSNTPrequest_sntpPkt_L0+3 
;SE9M.c,659 :: 		sntpPkt[6] = 0x44 ;
	MOVLW       68
	MOVWF       mkSNTPrequest_sntpPkt_L0+6 
;SE9M.c,662 :: 		sntpPkt[9] = 0x10 ;
	MOVLW       16
	MOVWF       mkSNTPrequest_sntpPkt_L0+9 
;SE9M.c,667 :: 		sntpPkt[16] = Highest(lastSync);
	MOVF        _lastSync+3, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+16 
;SE9M.c,668 :: 		sntpPkt[17] = Higher(lastSync);
	MOVF        _lastSync+2, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+17 
;SE9M.c,669 :: 		sntpPkt[18] = Hi(lastSync);
	MOVF        _lastSync+1, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+18 
;SE9M.c,670 :: 		sntpPkt[19] = Lo(lastSync);
	MOVF        _lastSync+0, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+19 
;SE9M.c,677 :: 		sntpPkt[40] = Highest(epoch);
	MOVF        _epoch+3, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+40 
;SE9M.c,678 :: 		sntpPkt[41] = Higher(epoch);
	MOVF        _epoch+2, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+41 
;SE9M.c,679 :: 		sntpPkt[42] = Hi(epoch);
	MOVF        _epoch+1, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+42 
;SE9M.c,680 :: 		sntpPkt[43] = Lo(epoch);
	MOVF        _epoch+0, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+43 
;SE9M.c,681 :: 		sntpPkt[44] = Highest(epoch_fract);
	MOVF        _epoch_fract+3, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+44 
;SE9M.c,682 :: 		sntpPkt[45] = Higher(epoch_fract);
	MOVF        _epoch_fract+2, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+45 
;SE9M.c,683 :: 		sntpPkt[46] = Hi(epoch_fract);
	MOVF        _epoch_fract+1, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+46 
;SE9M.c,684 :: 		sntpPkt[47] = Lo(epoch_fract);
	MOVF        _epoch_fract+0, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+47 
;SE9M.c,687 :: 		LongtoStr(lastSync,rez);
	MOVF        _lastSync+0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        _lastSync+1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        _lastSync+2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        _lastSync+3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       _rez+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;SE9M.c,688 :: 		UART_Write_Text("Ovo je T_ref:");
	MOVLW       ?lstr54_SE9M+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr54_SE9M+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,689 :: 		UART_Write_Text(rez);
	MOVLW       _rez+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,690 :: 		UART_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,691 :: 		UART_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,693 :: 		Time_EpochtoDate(epoch + 3600 *tmzn , &t1_c);
	MOVLW       16
	MOVWF       R0 
	MOVLW       14
	MOVWF       R1 
	MOVF        _tmzn+0, 0 
	MOVWF       R4 
	MOVLW       0
	BTFSC       _tmzn+0, 7 
	MOVLW       255
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       _epoch+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        R1, 0 
	ADDWFC      _epoch+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _epoch+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _epoch+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVLW       mkSNTPrequest_t1_c_L0+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(mkSNTPrequest_t1_c_L0+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,694 :: 		ts2str(res,&t1_c,TS2STR_TIME);
	MOVLW       _res+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(_res+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       mkSNTPrequest_t1_c_L0+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(mkSNTPrequest_t1_c_L0+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       2
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,695 :: 		strcat (res, ".");
	MOVLW       _res+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_res+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr55_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr55_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,696 :: 		LongtoStr(epoch_fract,fract);
	MOVF        _epoch_fract+0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        _epoch_fract+1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        _epoch_fract+2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        _epoch_fract+3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       _fract+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(_fract+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;SE9M.c,697 :: 		strcat(res,fract);
	MOVLW       _res+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_res+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _fract+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_fract+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,698 :: 		UART_Write_Text("Ovo je T1 sa klijenta:");
	MOVLW       ?lstr56_SE9M+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr56_SE9M+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,699 :: 		UART_Write_Text(res);
	MOVLW       _res+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(_res+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,700 :: 		UART_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,701 :: 		UART_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,704 :: 		SPI_Ethernet_sendUDP(conf.sntpIP, 123, 123, sntpPkt, 48) ; // transmit UDP packet
	MOVLW       _conf+3
	MOVWF       FARG_SPI_Ethernet_sendUDP_destIP+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_SPI_Ethernet_sendUDP_destIP+1 
	MOVLW       123
	MOVWF       FARG_SPI_Ethernet_sendUDP_sourcePort+0 
	MOVLW       0
	MOVWF       FARG_SPI_Ethernet_sendUDP_sourcePort+1 
	MOVLW       123
	MOVWF       FARG_SPI_Ethernet_sendUDP_destPort+0 
	MOVLW       0
	MOVWF       FARG_SPI_Ethernet_sendUDP_destPort+1 
	MOVLW       mkSNTPrequest_sntpPkt_L0+0
	MOVWF       FARG_SPI_Ethernet_sendUDP_pkt+0 
	MOVLW       hi_addr(mkSNTPrequest_sntpPkt_L0+0)
	MOVWF       FARG_SPI_Ethernet_sendUDP_pkt+1 
	MOVLW       48
	MOVWF       FARG_SPI_Ethernet_sendUDP_pktLen+0 
	MOVLW       0
	MOVWF       FARG_SPI_Ethernet_sendUDP_pktLen+1 
	CALL        _SPI_Ethernet_sendUDP+0, 0
;SE9M.c,706 :: 		sntpSync = 1 ;  // done
	MOVLW       1
	MOVWF       _sntpSync+0 
;SE9M.c,707 :: 		sync_flag = 0 ;
	CLRF        _sync_flag+0 
;SE9M.c,708 :: 		sntpTimer = SPI_Ethernet_UserTimerSec + 2;
	MOVLW       2
	ADDWF       _SPI_Ethernet_UserTimerSec+0, 0 
	MOVWF       _sntpTimer+0 
	MOVLW       0
	ADDWFC      _SPI_Ethernet_UserTimerSec+1, 0 
	MOVWF       _sntpTimer+1 
	MOVLW       0
	ADDWFC      _SPI_Ethernet_UserTimerSec+2, 0 
	MOVWF       _sntpTimer+2 
	MOVLW       0
	ADDWFC      _SPI_Ethernet_UserTimerSec+3, 0 
	MOVWF       _sntpTimer+3 
;SE9M.c,709 :: 		}
L_end_mkSNTPrequest:
	RETURN      0
; end of _mkSNTPrequest

_Eth_Obrada:

;SE9M.c,719 :: 		void Eth_Obrada() {
;SE9M.c,721 :: 		if (conf.dhcpen == 0) {
	MOVF        _conf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada29
;SE9M.c,723 :: 		if (lease_time >= 60) {
	MOVLW       60
	SUBWF       _lease_time+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Eth_Obrada30
;SE9M.c,724 :: 		lease_time = 0;
	CLRF        _lease_time+0 
;SE9M.c,725 :: 		while (!SPI_Ethernet_renewDHCP(5));  // try to renew until it works
L_Eth_Obrada31:
	MOVLW       5
	MOVWF       FARG_SPI_Ethernet_renewDHCP_tmax+0 
	CALL        _SPI_Ethernet_renewDHCP+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada32
	GOTO        L_Eth_Obrada31
L_Eth_Obrada32:
;SE9M.c,726 :: 		}
L_Eth_Obrada30:
;SE9M.c,727 :: 		}
L_Eth_Obrada29:
;SE9M.c,728 :: 		if (link == 1) {
	MOVF        _link+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada33
;SE9M.c,729 :: 		if (sync_flag == 1) {
	MOVF        _sync_flag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada34
;SE9M.c,730 :: 		sync_flag = 0;
	CLRF        _sync_flag+0 
;SE9M.c,731 :: 		mkSNTPrequest();
	CALL        _mkSNTPrequest+0, 0
;SE9M.c,732 :: 		}
L_Eth_Obrada34:
;SE9M.c,733 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;SE9M.c,734 :: 		Spi_Ethernet_doPacket() ;
	CALL        _SPI_Ethernet_doPacket+0, 0
;SE9M.c,736 :: 		}
L_Eth_Obrada33:
;SE9M.c,737 :: 		}
L_end_Eth_Obrada:
	RETURN      0
; end of _Eth_Obrada

_mkMarquee:

;SE9M.c,743 :: 		void    mkMarquee(unsigned char l)
;SE9M.c,748 :: 		if((*marquee == 0) || (marquee == 0))
	MOVFF       _marquee+0, FSR0
	MOVFF       _marquee+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__mkMarquee524
	MOVLW       0
	XORWF       _marquee+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkMarquee597
	MOVLW       0
	XORWF       _marquee+0, 0 
L__mkMarquee597:
	BTFSC       STATUS+0, 2 
	GOTO        L__mkMarquee524
	GOTO        L_mkMarquee37
L__mkMarquee524:
;SE9M.c,750 :: 		marquee = bufInfo ;
	MOVLW       _bufInfo+0
	MOVWF       _marquee+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       _marquee+1 
;SE9M.c,751 :: 		}
L_mkMarquee37:
;SE9M.c,752 :: 		if((len=strlen(marquee)) < 16) {
	MOVF        _marquee+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        _marquee+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       mkMarquee_len_L0+0 
	MOVLW       16
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_mkMarquee38
;SE9M.c,753 :: 		memcpy(marqeeBuff, marquee, len) ;
	MOVLW       mkMarquee_marqeeBuff_L0+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(mkMarquee_marqeeBuff_L0+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVF        _marquee+0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        _marquee+1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVF        mkMarquee_len_L0+0, 0 
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,754 :: 		memcpy(marqeeBuff+len, bufInfo, 16-len) ;
	MOVLW       mkMarquee_marqeeBuff_L0+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(mkMarquee_marqeeBuff_L0+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVF        mkMarquee_len_L0+0, 0 
	ADDWF       FARG_memcpy_d1+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FARG_memcpy_d1+1, 1 
	MOVLW       _bufInfo+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVF        mkMarquee_len_L0+0, 0 
	SUBLW       16
	MOVWF       FARG_memcpy_n+0 
	CLRF        FARG_memcpy_n+1 
	MOVLW       0
	SUBWFB      FARG_memcpy_n+1, 1 
	CALL        _memcpy+0, 0
;SE9M.c,755 :: 		}
	GOTO        L_mkMarquee39
L_mkMarquee38:
;SE9M.c,757 :: 		memcpy(marqeeBuff, marquee, 16) ;
	MOVLW       mkMarquee_marqeeBuff_L0+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(mkMarquee_marqeeBuff_L0+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVF        _marquee+0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        _marquee+1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_mkMarquee39:
;SE9M.c,758 :: 		marqeeBuff[16] = 0 ;
	CLRF        mkMarquee_marqeeBuff_L0+16 
;SE9M.c,761 :: 		}
L_end_mkMarquee:
	RETURN      0
; end of _mkMarquee

_DNSavings:

;SE9M.c,791 :: 		void DNSavings() {
;SE9M.c,792 :: 		tmzn = 0;
	CLRF        _tmzn+0 
;SE9M.c,794 :: 		}
L_end_DNSavings:
	RETURN      0
; end of _DNSavings

_ip2str:

;SE9M.c,804 :: 		void    ip2str(unsigned char *s, unsigned char *ip)
;SE9M.c,809 :: 		*s = 0 ;
	MOVFF       FARG_ip2str_s+0, FSR1
	MOVFF       FARG_ip2str_s+1, FSR1H
	CLRF        POSTINC1+0 
;SE9M.c,810 :: 		for(i = 0 ; i < 4 ; i++)
	CLRF        ip2str_i_L0+0 
L_ip2str40:
	MOVLW       4
	SUBWF       ip2str_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ip2str41
;SE9M.c,812 :: 		int2str(ip[i], buf) ;
	MOVF        ip2str_i_L0+0, 0 
	ADDWF       FARG_ip2str_ip+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ip2str_ip+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVLW       0
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       0
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       ip2str_buf_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(ip2str_buf_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,813 :: 		strcat(s, buf) ;
	MOVF        FARG_ip2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ip2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ip2str_buf_L0+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ip2str_buf_L0+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,814 :: 		if(i != 3)
	MOVF        ip2str_i_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_ip2str43
;SE9M.c,815 :: 		strcat(s, ".") ;
	MOVF        FARG_ip2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ip2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr57_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr57_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
L_ip2str43:
;SE9M.c,810 :: 		for(i = 0 ; i < 4 ; i++)
	INCF        ip2str_i_L0+0, 1 
;SE9M.c,816 :: 		}
	GOTO        L_ip2str40
L_ip2str41:
;SE9M.c,817 :: 		}
L_end_ip2str:
	RETURN      0
; end of _ip2str

_nibble2hex:

;SE9M.c,828 :: 		unsigned char nibble2hex(unsigned char n)
;SE9M.c,830 :: 		n &= 0x0f ;
	MOVLW       15
	ANDWF       FARG_nibble2hex_n+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_nibble2hex_n+0 
;SE9M.c,831 :: 		if(n >= 0x0a)
	MOVLW       10
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_nibble2hex44
;SE9M.c,833 :: 		return(n + '7') ;
	MOVLW       55
	ADDWF       FARG_nibble2hex_n+0, 0 
	MOVWF       R0 
	GOTO        L_end_nibble2hex
;SE9M.c,834 :: 		}
L_nibble2hex44:
;SE9M.c,835 :: 		return(n + '0') ;
	MOVLW       48
	ADDWF       FARG_nibble2hex_n+0, 0 
	MOVWF       R0 
;SE9M.c,836 :: 		}
L_end_nibble2hex:
	RETURN      0
; end of _nibble2hex

_byte2hex:

;SE9M.c,841 :: 		void    byte2hex(unsigned char *s, unsigned char v)
;SE9M.c,843 :: 		*s++ = nibble2hex(v >> 4) ;
	MOVF        FARG_byte2hex_v+0, 0 
	MOVWF       FARG_nibble2hex_n+0 
	RRCF        FARG_nibble2hex_n+0, 1 
	BCF         FARG_nibble2hex_n+0, 7 
	RRCF        FARG_nibble2hex_n+0, 1 
	BCF         FARG_nibble2hex_n+0, 7 
	RRCF        FARG_nibble2hex_n+0, 1 
	BCF         FARG_nibble2hex_n+0, 7 
	RRCF        FARG_nibble2hex_n+0, 1 
	BCF         FARG_nibble2hex_n+0, 7 
	CALL        _nibble2hex+0, 0
	MOVFF       FARG_byte2hex_s+0, FSR1
	MOVFF       FARG_byte2hex_s+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_byte2hex_s+0, 1 
	INCF        FARG_byte2hex_s+1, 1 
;SE9M.c,844 :: 		*s++ = nibble2hex(v) ;
	MOVF        FARG_byte2hex_v+0, 0 
	MOVWF       FARG_nibble2hex_n+0 
	CALL        _nibble2hex+0, 0
	MOVFF       FARG_byte2hex_s+0, FSR1
	MOVFF       FARG_byte2hex_s+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_byte2hex_s+0, 1 
	INCF        FARG_byte2hex_s+1, 1 
;SE9M.c,845 :: 		*s = '.' ;
	MOVFF       FARG_byte2hex_s+0, FSR1
	MOVFF       FARG_byte2hex_s+1, FSR1H
	MOVLW       46
	MOVWF       POSTINC1+0 
;SE9M.c,846 :: 		}
L_end_byte2hex:
	RETURN      0
; end of _byte2hex

_mkLCDselect:

;SE9M.c,851 :: 		unsigned int    mkLCDselect(unsigned char l, unsigned char m)
;SE9M.c,856 :: 		len = putConstString("<select onChange=\\\"document.location.href = '/admin/") ;
	MOVLW       ?lstr_58_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_58_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_58_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       mkLCDselect_len_L0+0 
	MOVF        R1, 0 
	MOVWF       mkLCDselect_len_L0+1 
;SE9M.c,857 :: 		SPI_Ethernet_putByte('0' + l) ; len++ ;
	MOVF        FARG_mkLCDselect_l+0, 0 
	ADDLW       48
	MOVWF       FARG_SPI_Ethernet_putByte_v+0 
	CALL        _SPI_Ethernet_putByte+0, 0
	INFSNZ      mkLCDselect_len_L0+0, 1 
	INCF        mkLCDselect_len_L0+1, 1 
;SE9M.c,858 :: 		len += putConstString("/' + this.selectedIndex\\\">") ;
	MOVLW       ?lstr_59_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_59_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_59_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,859 :: 		for(i = 0 ; i < 2 ; i++)
	CLRF        mkLCDselect_i_L0+0 
L_mkLCDselect45:
	MOVLW       2
	SUBWF       mkLCDselect_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_mkLCDselect46
;SE9M.c,861 :: 		len += putConstString("<option ") ;
	MOVLW       ?lstr_60_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_60_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_60_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,862 :: 		if(i == m)
	MOVF        mkLCDselect_i_L0+0, 0 
	XORWF       FARG_mkLCDselect_m+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_mkLCDselect48
;SE9M.c,864 :: 		len += putConstString(" selected") ;
	MOVLW       ?lstr_61_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_61_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_61_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,865 :: 		}
L_mkLCDselect48:
;SE9M.c,866 :: 		len += putConstString(">") ;
	MOVLW       ?lstr_62_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_62_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_62_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,867 :: 		len += putConstString(LCDoption[i]) ;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        mkLCDselect_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _LCDoption+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_LCDoption+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,859 :: 		for(i = 0 ; i < 2 ; i++)
	INCF        mkLCDselect_i_L0+0, 1 
;SE9M.c,868 :: 		}
	GOTO        L_mkLCDselect45
L_mkLCDselect46:
;SE9M.c,869 :: 		len += putConstString("</select>\";") ;
	MOVLW       ?lstr_63_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_63_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_63_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        mkLCDselect_len_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        mkLCDselect_len_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       mkLCDselect_len_L0+0 
	MOVF        R1, 0 
	MOVWF       mkLCDselect_len_L0+1 
;SE9M.c,870 :: 		return(len) ;
;SE9M.c,871 :: 		}
L_end_mkLCDselect:
	RETURN      0
; end of _mkLCDselect

_mkLCDLine:

;SE9M.c,876 :: 		void mkLCDLine(unsigned char l, unsigned char m){
;SE9M.c,877 :: 		switch(m)
	GOTO        L_mkLCDLine49
;SE9M.c,879 :: 		case 0:
L_mkLCDLine51:
;SE9M.c,881 :: 		memset(bufInfo, 0, sizeof(bufInfo)) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       200
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;SE9M.c,882 :: 		if(sync_flag)
	MOVF        _sync_flag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine52
;SE9M.c,885 :: 		strcpy(bufInfo, "Today is ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr64_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr64_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,886 :: 		ts2str(bufInfo + strlen(bufInfo), &ts, TS2STR_DATE) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       _bufInfo+0
	ADDWF       R0, 0 
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _ts+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       1
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,887 :: 		strcat(bufInfo, ". Please visit www.micro-examples.com for more details about the Ethernal Clock. You can browse ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr65_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr65_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,888 :: 		ip2str(bufInfo + strlen(bufInfo), ipAddr) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       _bufInfo+0
	ADDWF       R0, 0 
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,889 :: 		strcat(bufInfo, " to set the clock preferences.    ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr66_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr66_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,890 :: 		}
	GOTO        L_mkLCDLine53
L_mkLCDLine52:
;SE9M.c,894 :: 		strcpy(bufInfo, "The SNTP server did not respond, please browse ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr67_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr67_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,895 :: 		ip2str(bufInfo + strlen(bufInfo), ipAddr) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       _bufInfo+0
	ADDWF       R0, 0 
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,896 :: 		strcat(bufInfo, " to check clock settings.    ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr68_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr68_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,897 :: 		}
L_mkLCDLine53:
;SE9M.c,898 :: 		mkMarquee(l) ;           // display marquee
	MOVF        FARG_mkLCDLine_l+0, 0 
	MOVWF       FARG_mkMarquee_l+0 
	CALL        _mkMarquee+0, 0
;SE9M.c,899 :: 		break ;
	GOTO        L_mkLCDLine50
;SE9M.c,900 :: 		case 1:
L_mkLCDLine54:
;SE9M.c,904 :: 		ts2str(bufInfo, &ts, TS2STR_DATE) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _ts+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       1
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,910 :: 		break ;
	GOTO        L_mkLCDLine50
;SE9M.c,911 :: 		case 2:
L_mkLCDLine55:
;SE9M.c,915 :: 		ts2str(bufInfo, &ts, TS2STR_TIME) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _ts+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       2
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,921 :: 		break ;
	GOTO        L_mkLCDLine50
;SE9M.c,922 :: 		}
L_mkLCDLine49:
	MOVF        FARG_mkLCDLine_m+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine51
	MOVF        FARG_mkLCDLine_m+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine54
	MOVF        FARG_mkLCDLine_m+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine55
L_mkLCDLine50:
;SE9M.c,923 :: 		}
L_end_mkLCDLine:
	RETURN      0
; end of _mkLCDLine

_Rst_Eth:

;SE9M.c,925 :: 		void Rst_Eth() {
;SE9M.c,926 :: 		SPI_Ethernet_Rst = 0;
	BCF         RA5_bit+0, BitPos(RA5_bit+0) 
;SE9M.c,927 :: 		reset_eth = 1;
	MOVLW       1
	MOVWF       _reset_eth+0 
;SE9M.c,929 :: 		}
L_end_Rst_Eth:
	RETURN      0
; end of _Rst_Eth

_SPI_Ethernet_UserTCP:

;SE9M.c,934 :: 		unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
;SE9M.c,939 :: 		unsigned int    len = 0 ;
	CLRF        SPI_Ethernet_UserTCP_len_L0+0 
	CLRF        SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,949 :: 		if (localPort != 80)                    // I listen only to web request on port 80
	MOVLW       0
	XORWF       FARG_SPI_Ethernet_UserTCP_localPort+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP606
	MOVLW       80
	XORWF       FARG_SPI_Ethernet_UserTCP_localPort+0, 0 
L__SPI_Ethernet_UserTCP606:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP56
;SE9M.c,951 :: 		return(0) ;                     // return without reply
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;SE9M.c,952 :: 		}
L_SPI_Ethernet_UserTCP56:
;SE9M.c,957 :: 		if (HTTP_getRequest(getRequest, &reqLength, HTTP_REQUEST_SIZE) == 0)
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+0
	MOVWF       FARG_HTTP_getRequest_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+0)
	MOVWF       FARG_HTTP_getRequest_ptr+1 
	MOVLW       FARG_SPI_Ethernet_UserTCP_reqLength+0
	MOVWF       FARG_HTTP_getRequest_len+0 
	MOVLW       hi_addr(FARG_SPI_Ethernet_UserTCP_reqLength+0)
	MOVWF       FARG_HTTP_getRequest_len+1 
	MOVLW       128
	MOVWF       FARG_HTTP_getRequest_max+0 
	MOVLW       0
	MOVWF       FARG_HTTP_getRequest_max+1 
	CALL        _HTTP_getRequest+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP57
;SE9M.c,959 :: 		return(0) ;                     // no reply if no GET request
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;SE9M.c,960 :: 		}
L_SPI_Ethernet_UserTCP57:
;SE9M.c,966 :: 		if(memcmp(getRequest, path_private, sizeof(path_private) - 1) == 0)   // is path under private section ?
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _path_private+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_path_private+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       6
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP607
	MOVLW       0
	XORWF       R0, 0 
L__SPI_Ethernet_UserTCP607:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP58
;SE9M.c,975 :: 		if(getRequest[sizeof(path_private)] == 's')
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       115
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP59
;SE9M.c,979 :: 		len = putConstString(httpHeader) ;              // HTTP header
	MOVLW       _httpHeader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,980 :: 		len += putConstString(httpMimeTypeScript) ;     // with script MIME type
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,982 :: 		if (admin == 0) {
	MOVF        _admin+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP60
;SE9M.c,985 :: 		len += putConstString("var PASS=\"") ;
	MOVLW       ?lstr_69_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_69_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_69_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,986 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_70_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_70_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_70_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,987 :: 		len += putString("password") ;
	MOVLW       ?lstr71_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(?lstr71_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,988 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/v/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_72_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_72_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_72_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,989 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_73_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_73_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_73_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,991 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP61
L_SPI_Ethernet_UserTCP60:
;SE9M.c,993 :: 		uzobyte = 1;
	MOVLW       1
	MOVWF       _uzobyte+0 
;SE9M.c,995 :: 		len += putConstString("var DHCPEN=\"") ;
	MOVLW       ?lstr_74_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_74_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_74_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,996 :: 		len += mkLCDselect(1, conf.dhcpen) ;
	MOVLW       1
	MOVWF       FARG_mkLCDselect_l+0 
	MOVF        _conf+0, 0 
	MOVWF       FARG_mkLCDselect_m+0 
	CALL        _mkLCDselect+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1000 :: 		len += putConstString("var PASS0=\"") ;
	MOVLW       ?lstr_75_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_75_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_75_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1001 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_76_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_76_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_76_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1002 :: 		len += putString(oldSifra) ;
	MOVLW       _oldSifra+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1003 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/x/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_77_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_77_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_77_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1004 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_78_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_78_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_78_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1007 :: 		len += putConstString("var PASS1=\"") ;
	MOVLW       ?lstr_79_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_79_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_79_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1008 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_80_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_80_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_80_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1009 :: 		len += putString(newSifra) ;
	MOVLW       _newSifra+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1010 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/y/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_81_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_81_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_81_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1011 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_82_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_82_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_82_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1015 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP62
;SE9M.c,1017 :: 		len += putConstString("var SIP=\"") ;
	MOVLW       ?lstr_83_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_83_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_83_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1018 :: 		len += putConstString("<select onChange=\\\"document.location.href = '/admin/u/' + this.selectedIndex\\\">") ;
	MOVLW       ?lstr_84_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_84_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_84_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1019 :: 		for(i = 1 ; i < 5 ; i++)
	MOVLW       1
	MOVWF       SPI_Ethernet_UserTCP_i_L0+0 
	MOVLW       0
	MOVWF       SPI_Ethernet_UserTCP_i_L0+1 
L_SPI_Ethernet_UserTCP63:
	MOVLW       128
	XORWF       SPI_Ethernet_UserTCP_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP608
	MOVLW       5
	SUBWF       SPI_Ethernet_UserTCP_i_L0+0, 0 
L__SPI_Ethernet_UserTCP608:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP64
;SE9M.c,1021 :: 		len += putConstString("<option ") ;
	MOVLW       ?lstr_85_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_85_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_85_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1022 :: 		if(i == s_ip)
	MOVLW       0
	XORWF       SPI_Ethernet_UserTCP_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP609
	MOVF        _s_ip+0, 0 
	XORWF       SPI_Ethernet_UserTCP_i_L0+0, 0 
L__SPI_Ethernet_UserTCP609:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP66
;SE9M.c,1024 :: 		len += putConstString(" selected") ;
	MOVLW       ?lstr_86_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_86_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_86_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1025 :: 		}
L_SPI_Ethernet_UserTCP66:
;SE9M.c,1026 :: 		len += putConstString(">") ;
	MOVLW       ?lstr_87_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_87_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_87_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1027 :: 		len += putConstString(IPoption[i-1]) ;
	MOVLW       1
	SUBWF       SPI_Ethernet_UserTCP_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      SPI_Ethernet_UserTCP_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _IPoption+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_IPoption+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1019 :: 		for(i = 1 ; i < 5 ; i++)
	INFSNZ      SPI_Ethernet_UserTCP_i_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_i_L0+1, 1 
;SE9M.c,1030 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP63
L_SPI_Ethernet_UserTCP64:
;SE9M.c,1031 :: 		len += putConstString("</select>\";") ;
	MOVLW       ?lstr_88_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_88_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_88_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1032 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP67
L_SPI_Ethernet_UserTCP62:
;SE9M.c,1033 :: 		s_ip = 1;
	MOVLW       1
	MOVWF       _s_ip+0 
;SE9M.c,1034 :: 		}
L_SPI_Ethernet_UserTCP67:
;SE9M.c,1036 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP68
;SE9M.c,1038 :: 		len += putConstString("var IP0=\"") ;
	MOVLW       ?lstr_89_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_89_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_89_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1039 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_90_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_90_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_90_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1040 :: 		len += putString(ipAddrPom0) ;
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1041 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP69
;SE9M.c,1042 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_91_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_91_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_91_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1043 :: 		}
L_SPI_Ethernet_UserTCP69:
;SE9M.c,1044 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP70
;SE9M.c,1045 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_92_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_92_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_92_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1046 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP71
L_SPI_Ethernet_UserTCP70:
;SE9M.c,1047 :: 		len += putConstString(">\";") ;
	MOVLW       ?lstr_93_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_93_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_93_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1048 :: 		}
L_SPI_Ethernet_UserTCP71:
;SE9M.c,1050 :: 		len += putConstString("var IP1=\"") ;
	MOVLW       ?lstr_94_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_94_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_94_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1051 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_95_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_95_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_95_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1052 :: 		len += putString(ipAddrPom1) ;
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1053 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP72
;SE9M.c,1054 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_96_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_96_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_96_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1055 :: 		}
L_SPI_Ethernet_UserTCP72:
;SE9M.c,1056 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP73
;SE9M.c,1057 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_97_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_97_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_97_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1058 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP74
L_SPI_Ethernet_UserTCP73:
;SE9M.c,1059 :: 		len += putConstString(">\";") ;
	MOVLW       ?lstr_98_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_98_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_98_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1060 :: 		}
L_SPI_Ethernet_UserTCP74:
;SE9M.c,1062 :: 		len += putConstString("var IP2=\"") ;
	MOVLW       ?lstr_99_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_99_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_99_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1063 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_100_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_100_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_100_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1064 :: 		len += putString(ipAddrPom2) ;
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1065 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP75
;SE9M.c,1066 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_101_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_101_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_101_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1067 :: 		}
L_SPI_Ethernet_UserTCP75:
;SE9M.c,1068 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP76
;SE9M.c,1069 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_102_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_102_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_102_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1070 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP77
L_SPI_Ethernet_UserTCP76:
;SE9M.c,1071 :: 		len += putConstString(">\";") ;
	MOVLW       ?lstr_103_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_103_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_103_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1072 :: 		}
L_SPI_Ethernet_UserTCP77:
;SE9M.c,1074 :: 		len += putConstString("var IP3=\"") ;
	MOVLW       ?lstr_104_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_104_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_104_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1075 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_105_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_105_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_105_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1076 :: 		len += putString(ipAddrPom3) ;
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1077 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP78
;SE9M.c,1078 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_106_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_106_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_106_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1079 :: 		}
L_SPI_Ethernet_UserTCP78:
;SE9M.c,1080 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP79
;SE9M.c,1081 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_107_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_107_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_107_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1082 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP80
L_SPI_Ethernet_UserTCP79:
;SE9M.c,1083 :: 		len += putConstString(">\";") ;
	MOVLW       ?lstr_108_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_108_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_108_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1084 :: 		}
L_SPI_Ethernet_UserTCP80:
;SE9M.c,1085 :: 		}
L_SPI_Ethernet_UserTCP68:
;SE9M.c,1088 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP81
;SE9M.c,1090 :: 		len += putConstString("var M0=\"") ;
	MOVLW       ?lstr_109_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_109_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_109_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1091 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP82
;SE9M.c,1092 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_110_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_110_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_110_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1093 :: 		len += putString(ipMaskPom0) ;
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1094 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_111_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_111_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_111_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1095 :: 		}
L_SPI_Ethernet_UserTCP82:
;SE9M.c,1098 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP83
;SE9M.c,1099 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_112_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_112_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_112_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1100 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP84
L_SPI_Ethernet_UserTCP83:
;SE9M.c,1101 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_113_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_113_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_113_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1102 :: 		}
L_SPI_Ethernet_UserTCP84:
;SE9M.c,1104 :: 		len += putConstString("var M1=\"") ;
	MOVLW       ?lstr_114_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_114_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_114_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1105 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP85
;SE9M.c,1106 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_115_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_115_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_115_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1107 :: 		len += putString(ipMaskPom1) ;
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1108 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_116_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_116_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_116_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1109 :: 		}
L_SPI_Ethernet_UserTCP85:
;SE9M.c,1112 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP86
;SE9M.c,1113 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_117_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_117_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_117_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1114 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP87
L_SPI_Ethernet_UserTCP86:
;SE9M.c,1115 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_118_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_118_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_118_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1116 :: 		}
L_SPI_Ethernet_UserTCP87:
;SE9M.c,1118 :: 		len += putConstString("var M2=\"") ;
	MOVLW       ?lstr_119_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_119_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_119_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1119 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP88
;SE9M.c,1120 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_120_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_120_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_120_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1121 :: 		len += putString(ipMaskPom2) ;
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1122 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_121_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_121_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_121_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1123 :: 		}
L_SPI_Ethernet_UserTCP88:
;SE9M.c,1126 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP89
;SE9M.c,1127 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_122_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_122_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_122_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1128 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP90
L_SPI_Ethernet_UserTCP89:
;SE9M.c,1129 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_123_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_123_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_123_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1130 :: 		}
L_SPI_Ethernet_UserTCP90:
;SE9M.c,1132 :: 		len += putConstString("var M3=\"") ;
	MOVLW       ?lstr_124_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_124_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_124_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1133 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP91
;SE9M.c,1134 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_125_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_125_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_125_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1135 :: 		len += putString(ipMaskPom3) ;
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1136 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_126_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_126_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_126_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1137 :: 		}
L_SPI_Ethernet_UserTCP91:
;SE9M.c,1140 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP92
;SE9M.c,1141 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_127_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_127_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_127_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1142 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP93
L_SPI_Ethernet_UserTCP92:
;SE9M.c,1143 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_128_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_128_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_128_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1144 :: 		}
L_SPI_Ethernet_UserTCP93:
;SE9M.c,1145 :: 		}
L_SPI_Ethernet_UserTCP81:
;SE9M.c,1148 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP94
;SE9M.c,1150 :: 		len += putConstString("var G0=\"") ;
	MOVLW       ?lstr_129_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_129_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_129_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1151 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP95
;SE9M.c,1152 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_130_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_130_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_130_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1153 :: 		len += putString(gwIpAddrPom0) ;
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1154 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_131_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_131_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_131_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1155 :: 		}
L_SPI_Ethernet_UserTCP95:
;SE9M.c,1158 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP96
;SE9M.c,1159 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_132_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_132_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_132_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1160 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP97
L_SPI_Ethernet_UserTCP96:
;SE9M.c,1161 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_133_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_133_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_133_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1162 :: 		}
L_SPI_Ethernet_UserTCP97:
;SE9M.c,1164 :: 		len += putConstString("var G1=\"") ;
	MOVLW       ?lstr_134_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_134_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_134_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1165 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP98
;SE9M.c,1166 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_135_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_135_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_135_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1167 :: 		len += putString(gwIpAddrPom1) ;
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1168 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_136_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_136_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_136_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1169 :: 		}
L_SPI_Ethernet_UserTCP98:
;SE9M.c,1172 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP99
;SE9M.c,1173 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_137_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_137_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_137_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1174 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP100
L_SPI_Ethernet_UserTCP99:
;SE9M.c,1175 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_138_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_138_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_138_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1176 :: 		}
L_SPI_Ethernet_UserTCP100:
;SE9M.c,1178 :: 		len += putConstString("var G2=\"") ;
	MOVLW       ?lstr_139_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_139_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_139_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1179 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP101
;SE9M.c,1180 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_140_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_140_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_140_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1181 :: 		len += putString(gwIpAddrPom2) ;
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1182 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_141_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_141_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_141_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1183 :: 		}
L_SPI_Ethernet_UserTCP101:
;SE9M.c,1186 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP102
;SE9M.c,1187 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_142_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_142_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_142_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1188 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP103
L_SPI_Ethernet_UserTCP102:
;SE9M.c,1189 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_143_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_143_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_143_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1190 :: 		}
L_SPI_Ethernet_UserTCP103:
;SE9M.c,1192 :: 		len += putConstString("var G3=\"") ;
	MOVLW       ?lstr_144_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_144_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_144_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1193 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP104
;SE9M.c,1194 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_145_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_145_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_145_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1195 :: 		len += putString(gwIpAddrPom3) ;
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1196 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_146_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_146_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_146_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1197 :: 		}
L_SPI_Ethernet_UserTCP104:
;SE9M.c,1200 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP105
;SE9M.c,1201 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_147_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_147_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_147_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1202 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP106
L_SPI_Ethernet_UserTCP105:
;SE9M.c,1203 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_148_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_148_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_148_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1204 :: 		}
L_SPI_Ethernet_UserTCP106:
;SE9M.c,1205 :: 		}
L_SPI_Ethernet_UserTCP94:
;SE9M.c,1207 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP107
;SE9M.c,1209 :: 		len += putConstString("var D0=\"") ;
	MOVLW       ?lstr_149_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_149_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_149_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1210 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP108
;SE9M.c,1211 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_150_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_150_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_150_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1212 :: 		len += putString(dnsIpAddrPom0) ;
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1213 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_151_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_151_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_151_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1214 :: 		}
L_SPI_Ethernet_UserTCP108:
;SE9M.c,1217 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP109
;SE9M.c,1218 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_152_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_152_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_152_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1219 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP110
L_SPI_Ethernet_UserTCP109:
;SE9M.c,1220 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_153_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_153_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_153_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1221 :: 		}
L_SPI_Ethernet_UserTCP110:
;SE9M.c,1223 :: 		len += putConstString("var D1=\"") ;
	MOVLW       ?lstr_154_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_154_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_154_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1224 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP111
;SE9M.c,1225 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_155_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_155_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_155_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1226 :: 		len += putString(dnsIpAddrPom1) ;
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1227 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_156_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_156_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_156_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1228 :: 		}
L_SPI_Ethernet_UserTCP111:
;SE9M.c,1231 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP112
;SE9M.c,1232 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_157_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_157_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_157_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1233 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP113
L_SPI_Ethernet_UserTCP112:
;SE9M.c,1234 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_158_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_158_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_158_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1235 :: 		}
L_SPI_Ethernet_UserTCP113:
;SE9M.c,1237 :: 		len += putConstString("var D2=\"") ;
	MOVLW       ?lstr_159_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_159_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_159_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1238 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP114
;SE9M.c,1239 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_160_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_160_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_160_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1240 :: 		len += putString(dnsIpAddrPom2) ;
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1241 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_161_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_161_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_161_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1242 :: 		}
L_SPI_Ethernet_UserTCP114:
;SE9M.c,1244 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP115
;SE9M.c,1245 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_162_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_162_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_162_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1246 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP116
L_SPI_Ethernet_UserTCP115:
;SE9M.c,1247 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_163_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_163_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_163_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1248 :: 		}
L_SPI_Ethernet_UserTCP116:
;SE9M.c,1250 :: 		len += putConstString("var D3=\"") ;
	MOVLW       ?lstr_164_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_164_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_164_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1251 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP117
;SE9M.c,1252 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_165_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_165_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_165_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1253 :: 		len += putString(dnsIpAddrPom3) ;
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1254 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_166_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_166_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_166_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1255 :: 		}
L_SPI_Ethernet_UserTCP117:
;SE9M.c,1257 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP118
;SE9M.c,1258 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_167_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_167_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_167_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1259 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP119
L_SPI_Ethernet_UserTCP118:
;SE9M.c,1260 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_168_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_168_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_168_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1261 :: 		}
L_SPI_Ethernet_UserTCP119:
;SE9M.c,1262 :: 		}
L_SPI_Ethernet_UserTCP107:
;SE9M.c,1264 :: 		}
L_SPI_Ethernet_UserTCP61:
;SE9M.c,1266 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP120
L_SPI_Ethernet_UserTCP59:
;SE9M.c,1270 :: 		switch(getRequest[sizeof(path_private)])
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1272 :: 		case '1' :
L_SPI_Ethernet_UserTCP123:
;SE9M.c,1274 :: 		conf.dhcpen = getRequest[sizeof(path_private) + 2] - '0' ;
	MOVLW       48
	SUBWF       SPI_Ethernet_UserTCP_getRequest_L0+9, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _conf+0 
;SE9M.c,1275 :: 		EEPROM_Write(103, conf.dhcpen);
	MOVLW       103
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1276 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_SPI_Ethernet_UserTCP124:
	DECFSZ      R13, 1, 1
	BRA         L_SPI_Ethernet_UserTCP124
	DECFSZ      R12, 1, 1
	BRA         L_SPI_Ethernet_UserTCP124
	DECFSZ      R11, 1, 1
	BRA         L_SPI_Ethernet_UserTCP124
;SE9M.c,1277 :: 		Rst_Eth();
	CALL        _Rst_Eth+0, 0
;SE9M.c,1278 :: 		saveConf() ;
	CALL        _saveConf+0, 0
;SE9M.c,1279 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP122
;SE9M.c,1281 :: 		case 'r':
L_SPI_Ethernet_UserTCP125:
;SE9M.c,1283 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP126
;SE9M.c,1288 :: 		if ( (ipAddrPom0[0] >= '1') && (ipAddrPom0[0] <= '9') && (ipAddrPom0[1] >= '0') && (ipAddrPom0[1] <= '9') && (ipAddrPom0[2] >= '0') && (ipAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP129
	MOVF        _ipAddrPom0+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP129
	MOVLW       48
	SUBWF       _ipAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP129
	MOVF        _ipAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP129
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP129
	MOVF        _ipAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP129
L__SPI_Ethernet_UserTCP572:
;SE9M.c,1289 :: 		EEPROM_Write(1, (ipAddrPom0[0]-48)*100 + (ipAddrPom0[1]-48)*10 + (ipAddrPom0[2]-48));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom0+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1290 :: 		}
L_SPI_Ethernet_UserTCP129:
;SE9M.c,1291 :: 		if ( (ipAddrPom0[0] < '1') && (ipAddrPom0[1] >= '1') && (ipAddrPom0[1] <= '9') && (ipAddrPom0[2] >= '0') && (ipAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP132
	MOVLW       49
	SUBWF       _ipAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP132
	MOVF        _ipAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP132
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP132
	MOVF        _ipAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP132
L__SPI_Ethernet_UserTCP571:
;SE9M.c,1292 :: 		EEPROM_Write(1, (ipAddrPom0[1]-48)*10 + (ipAddrPom0[2]-48));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom0+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1293 :: 		}
L_SPI_Ethernet_UserTCP132:
;SE9M.c,1294 :: 		if ( (ipAddrPom0[0] < '1') && (ipAddrPom0[1] < '1') && (ipAddrPom0[2] >= '0') && (ipAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP135
	MOVLW       49
	SUBWF       _ipAddrPom0+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP135
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP135
	MOVF        _ipAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP135
L__SPI_Ethernet_UserTCP570:
;SE9M.c,1295 :: 		EEPROM_Write(1, (ipAddrPom0[2]-48));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1296 :: 		}
L_SPI_Ethernet_UserTCP135:
;SE9M.c,1298 :: 		if ( (ipAddrPom1[0] >= '1') && (ipAddrPom1[0] <= '9') && (ipAddrPom1[1] >= '0') && (ipAddrPom1[1] <= '9') && (ipAddrPom1[2] >= '0') && (ipAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP138
	MOVF        _ipAddrPom1+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP138
	MOVLW       48
	SUBWF       _ipAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP138
	MOVF        _ipAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP138
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP138
	MOVF        _ipAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP138
L__SPI_Ethernet_UserTCP569:
;SE9M.c,1299 :: 		EEPROM_Write(2, (ipAddrPom1[0]-48)*100 + (ipAddrPom1[1]-48)*10 + (ipAddrPom1[2]-48));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom1+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1300 :: 		}
L_SPI_Ethernet_UserTCP138:
;SE9M.c,1301 :: 		if ( (ipAddrPom1[0] < '1') && (ipAddrPom1[1] >= '1') && (ipAddrPom1[1] <= '9') && (ipAddrPom1[2] >= '0') && (ipAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP141
	MOVLW       49
	SUBWF       _ipAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP141
	MOVF        _ipAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP141
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP141
	MOVF        _ipAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP141
L__SPI_Ethernet_UserTCP568:
;SE9M.c,1302 :: 		EEPROM_Write(2, (ipAddrPom1[1]-48)*10 + (ipAddrPom1[2]-48));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom1+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1303 :: 		}
L_SPI_Ethernet_UserTCP141:
;SE9M.c,1304 :: 		if ( (ipAddrPom1[0] < '1') && (ipAddrPom1[1] < '1') && (ipAddrPom1[2] >= '0') && (ipAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP144
	MOVLW       49
	SUBWF       _ipAddrPom1+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP144
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP144
	MOVF        _ipAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP144
L__SPI_Ethernet_UserTCP567:
;SE9M.c,1305 :: 		EEPROM_Write(2, (ipAddrPom1[2]-48));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1306 :: 		}
L_SPI_Ethernet_UserTCP144:
;SE9M.c,1308 :: 		if ( (ipAddrPom2[0] >= '1') && (ipAddrPom2[0] <= '9') && (ipAddrPom2[1] >= '0') && (ipAddrPom2[1] <= '9') && (ipAddrPom2[2] >= '0') && (ipAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP147
	MOVF        _ipAddrPom2+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP147
	MOVLW       48
	SUBWF       _ipAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP147
	MOVF        _ipAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP147
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP147
	MOVF        _ipAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP147
L__SPI_Ethernet_UserTCP566:
;SE9M.c,1309 :: 		EEPROM_Write(3, (ipAddrPom2[0]-48)*100 + (ipAddrPom2[1]-48)*10 + (ipAddrPom2[2]-48));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom2+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1310 :: 		}
L_SPI_Ethernet_UserTCP147:
;SE9M.c,1311 :: 		if ( (ipAddrPom2[0] < '1') && (ipAddrPom2[1] >= '1') && (ipAddrPom2[1] <= '9') && (ipAddrPom2[2] >= '0') && (ipAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP150
	MOVLW       49
	SUBWF       _ipAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP150
	MOVF        _ipAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP150
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP150
	MOVF        _ipAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP150
L__SPI_Ethernet_UserTCP565:
;SE9M.c,1312 :: 		EEPROM_Write(3, (ipAddrPom2[1]-48)*10 + (ipAddrPom2[2]-48));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom2+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1313 :: 		}
L_SPI_Ethernet_UserTCP150:
;SE9M.c,1314 :: 		if ( (ipAddrPom2[0] < '1') && (ipAddrPom2[1] < '1') && (ipAddrPom2[2] >= '0') && (ipAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP153
	MOVLW       49
	SUBWF       _ipAddrPom2+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP153
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP153
	MOVF        _ipAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP153
L__SPI_Ethernet_UserTCP564:
;SE9M.c,1315 :: 		EEPROM_Write(3, (ipAddrPom2[2]-48));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1316 :: 		}
L_SPI_Ethernet_UserTCP153:
;SE9M.c,1318 :: 		if ( (ipAddrPom3[0] >= '1') && (ipAddrPom3[0] <= '9') && (ipAddrPom3[1] >= '0') && (ipAddrPom3[1] <= '9') && (ipAddrPom3[2] >= '0') && (ipAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom3+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP156
	MOVF        _ipAddrPom3+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP156
	MOVLW       48
	SUBWF       _ipAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP156
	MOVF        _ipAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP156
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP156
	MOVF        _ipAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP156
L__SPI_Ethernet_UserTCP563:
;SE9M.c,1319 :: 		EEPROM_Write(4, (ipAddrPom3[0]-48)*100 + (ipAddrPom3[1]-48)*10 + (ipAddrPom3[2]-48));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom3+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom3+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1320 :: 		}
L_SPI_Ethernet_UserTCP156:
;SE9M.c,1321 :: 		if ( (ipAddrPom3[0] < '1') && (ipAddrPom3[1] >= '1') && (ipAddrPom3[1] <= '9') && (ipAddrPom3[2] >= '0') && (ipAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP159
	MOVLW       49
	SUBWF       _ipAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP159
	MOVF        _ipAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP159
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP159
	MOVF        _ipAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP159
L__SPI_Ethernet_UserTCP562:
;SE9M.c,1322 :: 		EEPROM_Write(4, (ipAddrPom3[1]-48)*10 + (ipAddrPom3[2]-48));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom3+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1323 :: 		}
L_SPI_Ethernet_UserTCP159:
;SE9M.c,1324 :: 		if ( (ipAddrPom3[0] < '1') && (ipAddrPom3[1] < '1') && (ipAddrPom3[2] >= '0') && (ipAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP162
	MOVLW       49
	SUBWF       _ipAddrPom3+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP162
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP162
	MOVF        _ipAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP162
L__SPI_Ethernet_UserTCP561:
;SE9M.c,1325 :: 		EEPROM_Write(4, (ipAddrPom3[2]-48));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1326 :: 		}
L_SPI_Ethernet_UserTCP162:
;SE9M.c,1330 :: 		if ( (gwIpAddrPom0[0] >= '1') && (gwIpAddrPom0[0] <= '9') && (gwIpAddrPom0[1] >= '0') && (gwIpAddrPom0[1] <= '9') && (gwIpAddrPom0[2] >= '0') && (gwIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP165
	MOVF        _gwIpAddrPom0+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP165
	MOVLW       48
	SUBWF       _gwIpAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP165
	MOVF        _gwIpAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP165
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP165
	MOVF        _gwIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP165
L__SPI_Ethernet_UserTCP560:
;SE9M.c,1331 :: 		EEPROM_Write(5, (gwIpAddrPom0[0]-48)*100 + (gwIpAddrPom0[1]-48)*10 + (gwIpAddrPom0[2]-48));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1332 :: 		}
L_SPI_Ethernet_UserTCP165:
;SE9M.c,1333 :: 		if ( (gwIpAddrPom0[0] < '1') && (gwIpAddrPom0[1] >= '1') && (gwIpAddrPom0[1] <= '9') && (gwIpAddrPom0[2] >= '0') && (gwIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP168
	MOVLW       49
	SUBWF       _gwIpAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP168
	MOVF        _gwIpAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP168
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP168
	MOVF        _gwIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP168
L__SPI_Ethernet_UserTCP559:
;SE9M.c,1334 :: 		EEPROM_Write(5, (gwIpAddrPom0[1]-48)*10 + (gwIpAddrPom0[2]-48));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1335 :: 		}
L_SPI_Ethernet_UserTCP168:
;SE9M.c,1336 :: 		if ( (gwIpAddrPom0[0] < '1') && (gwIpAddrPom0[1] < '1') && (gwIpAddrPom0[2] >= '0') && (gwIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP171
	MOVLW       49
	SUBWF       _gwIpAddrPom0+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP171
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP171
	MOVF        _gwIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP171
L__SPI_Ethernet_UserTCP558:
;SE9M.c,1337 :: 		EEPROM_Write(5, (gwIpAddrPom0[2]-48));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1338 :: 		}
L_SPI_Ethernet_UserTCP171:
;SE9M.c,1340 :: 		if ( (gwIpAddrPom1[0] >= '1') && (gwIpAddrPom1[0] <= '9') && (gwIpAddrPom1[1] >= '0') && (gwIpAddrPom1[1] <= '9') && (gwIpAddrPom1[2] >= '0') && (gwIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP174
	MOVF        _gwIpAddrPom1+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP174
	MOVLW       48
	SUBWF       _gwIpAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP174
	MOVF        _gwIpAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP174
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP174
	MOVF        _gwIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP174
L__SPI_Ethernet_UserTCP557:
;SE9M.c,1341 :: 		EEPROM_Write(6, (gwIpAddrPom1[0]-48)*100 + (gwIpAddrPom1[1]-48)*10 + (gwIpAddrPom1[2]-48));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1342 :: 		}
L_SPI_Ethernet_UserTCP174:
;SE9M.c,1343 :: 		if ( (gwIpAddrPom1[0] < '1') && (gwIpAddrPom1[1] >= '1') && (gwIpAddrPom1[1] <= '9') && (gwIpAddrPom1[2] >= '0') && (gwIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP177
	MOVLW       49
	SUBWF       _gwIpAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP177
	MOVF        _gwIpAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP177
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP177
	MOVF        _gwIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP177
L__SPI_Ethernet_UserTCP556:
;SE9M.c,1344 :: 		EEPROM_Write(6, (gwIpAddrPom1[1]-48)*10 + (gwIpAddrPom1[2]-48));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1345 :: 		}
L_SPI_Ethernet_UserTCP177:
;SE9M.c,1346 :: 		if ( (gwIpAddrPom1[0] < '1') && (gwIpAddrPom1[1] < '1') && (gwIpAddrPom1[2] >= '0') && (gwIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP180
	MOVLW       49
	SUBWF       _gwIpAddrPom1+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP180
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP180
	MOVF        _gwIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP180
L__SPI_Ethernet_UserTCP555:
;SE9M.c,1347 :: 		EEPROM_Write(6, (gwIpAddrPom1[2]-48));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1348 :: 		}
L_SPI_Ethernet_UserTCP180:
;SE9M.c,1350 :: 		if ( (gwIpAddrPom2[0] >= '1') && (gwIpAddrPom2[0] <= '9') && (gwIpAddrPom2[1] >= '0') && (gwIpAddrPom2[1] <= '9') && (gwIpAddrPom2[2] >= '0') && (gwIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP183
	MOVF        _gwIpAddrPom2+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP183
	MOVLW       48
	SUBWF       _gwIpAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP183
	MOVF        _gwIpAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP183
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP183
	MOVF        _gwIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP183
L__SPI_Ethernet_UserTCP554:
;SE9M.c,1351 :: 		EEPROM_Write(7, (gwIpAddrPom2[0]-48)*100 + (gwIpAddrPom2[1]-48)*10 + (gwIpAddrPom2[2]-48));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1352 :: 		}
L_SPI_Ethernet_UserTCP183:
;SE9M.c,1353 :: 		if ( (gwIpAddrPom2[0] < '1') && (gwIpAddrPom2[1] >= '1') && (gwIpAddrPom2[1] <= '9') && (gwIpAddrPom2[2] >= '0') && (gwIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP186
	MOVLW       49
	SUBWF       _gwIpAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP186
	MOVF        _gwIpAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP186
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP186
	MOVF        _gwIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP186
L__SPI_Ethernet_UserTCP553:
;SE9M.c,1354 :: 		EEPROM_Write(7, (gwIpAddrPom2[1]-48)*10 + (gwIpAddrPom2[2]-48));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1355 :: 		}
L_SPI_Ethernet_UserTCP186:
;SE9M.c,1356 :: 		if ( (gwIpAddrPom2[0] < '1') && (gwIpAddrPom2[1] < '1') && (gwIpAddrPom2[2] >= '0') && (gwIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP189
	MOVLW       49
	SUBWF       _gwIpAddrPom2+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP189
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP189
	MOVF        _gwIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP189
L__SPI_Ethernet_UserTCP552:
;SE9M.c,1357 :: 		EEPROM_Write(7, (gwIpAddrPom2[2]-48));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1358 :: 		}
L_SPI_Ethernet_UserTCP189:
;SE9M.c,1360 :: 		if ( (gwIpAddrPom3[0] >= '1') && (gwIpAddrPom3[0] <= '9') && (gwIpAddrPom3[1] >= '0') && (gwIpAddrPom3[1] <= '9') && (gwIpAddrPom3[2] >= '0') && (gwIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom3+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP192
	MOVF        _gwIpAddrPom3+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP192
	MOVLW       48
	SUBWF       _gwIpAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP192
	MOVF        _gwIpAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP192
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP192
	MOVF        _gwIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP192
L__SPI_Ethernet_UserTCP551:
;SE9M.c,1361 :: 		EEPROM_Write(8, (gwIpAddrPom3[0]-48)*100 + (gwIpAddrPom3[1]-48)*10 + (gwIpAddrPom3[2]-48));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1362 :: 		}
L_SPI_Ethernet_UserTCP192:
;SE9M.c,1363 :: 		if ( (gwIpAddrPom3[0] < '1') && (gwIpAddrPom3[1] >= '1') && (gwIpAddrPom3[1] <= '9') && (gwIpAddrPom3[2] >= '0') && (gwIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP195
	MOVLW       49
	SUBWF       _gwIpAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP195
	MOVF        _gwIpAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP195
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP195
	MOVF        _gwIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP195
L__SPI_Ethernet_UserTCP550:
;SE9M.c,1364 :: 		EEPROM_Write(8, (gwIpAddrPom3[1]-48)*10 + (gwIpAddrPom3[2]-48));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1365 :: 		}
L_SPI_Ethernet_UserTCP195:
;SE9M.c,1366 :: 		if ( (gwIpAddrPom3[0] < '1') && (gwIpAddrPom3[1] < '1') && (gwIpAddrPom3[2] >= '0') && (gwIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP198
	MOVLW       49
	SUBWF       _gwIpAddrPom3+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP198
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP198
	MOVF        _gwIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP198
L__SPI_Ethernet_UserTCP549:
;SE9M.c,1367 :: 		EEPROM_Write(8, (gwIpAddrPom3[2]-48));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1368 :: 		}
L_SPI_Ethernet_UserTCP198:
;SE9M.c,1372 :: 		if ( (ipMaskPom0[0] >= '1') && (ipMaskPom0[0] <= '9') && (ipMaskPom0[1] >= '0') && (ipMaskPom0[1] <= '9') && (ipMaskPom0[2] >= '0') && (ipMaskPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP201
	MOVF        _ipMaskPom0+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP201
	MOVLW       48
	SUBWF       _ipMaskPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP201
	MOVF        _ipMaskPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP201
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP201
	MOVF        _ipMaskPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP201
L__SPI_Ethernet_UserTCP548:
;SE9M.c,1373 :: 		EEPROM_Write(9, (ipMaskPom0[0]-48)*100 + (ipMaskPom0[1]-48)*10 + (ipMaskPom0[2]-48));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom0+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1374 :: 		}
L_SPI_Ethernet_UserTCP201:
;SE9M.c,1375 :: 		if ( (ipMaskPom0[0] < '1') && (ipMaskPom0[1] >= '1') && (ipMaskPom0[1] <= '9') && (ipMaskPom0[2] >= '0') && (ipMaskPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP204
	MOVLW       49
	SUBWF       _ipMaskPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP204
	MOVF        _ipMaskPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP204
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP204
	MOVF        _ipMaskPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP204
L__SPI_Ethernet_UserTCP547:
;SE9M.c,1376 :: 		EEPROM_Write(9, (ipMaskPom0[1]-48)*10 + (ipMaskPom0[2]-48));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom0+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1377 :: 		}
L_SPI_Ethernet_UserTCP204:
;SE9M.c,1378 :: 		if ( (ipMaskPom0[0] < '1') && (ipMaskPom0[1] < '1') && (ipMaskPom0[2] >= '0') && (ipMaskPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP207
	MOVLW       49
	SUBWF       _ipMaskPom0+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP207
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP207
	MOVF        _ipMaskPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP207
L__SPI_Ethernet_UserTCP546:
;SE9M.c,1379 :: 		EEPROM_Write(9, (ipMaskPom0[2]-48));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1380 :: 		}
L_SPI_Ethernet_UserTCP207:
;SE9M.c,1382 :: 		if ( (ipMaskPom1[0] >= '1') && (ipMaskPom1[0] <= '9') && (ipMaskPom1[1] >= '0') && (ipMaskPom1[1] <= '9') && (ipMaskPom1[2] >= '0') && (ipMaskPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP210
	MOVF        _ipMaskPom1+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP210
	MOVLW       48
	SUBWF       _ipMaskPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP210
	MOVF        _ipMaskPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP210
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP210
	MOVF        _ipMaskPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP210
L__SPI_Ethernet_UserTCP545:
;SE9M.c,1383 :: 		EEPROM_Write(10, (ipMaskPom1[0]-48)*100 + (ipMaskPom1[1]-48)*10 + (ipMaskPom1[2]-48));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom1+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1384 :: 		}
L_SPI_Ethernet_UserTCP210:
;SE9M.c,1385 :: 		if ( (ipMaskPom1[0] < '1') && (ipMaskPom1[1] >= '1') && (ipMaskPom1[1] <= '9') && (ipMaskPom1[2] >= '0') && (ipMaskPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP213
	MOVLW       49
	SUBWF       _ipMaskPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP213
	MOVF        _ipMaskPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP213
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP213
	MOVF        _ipMaskPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP213
L__SPI_Ethernet_UserTCP544:
;SE9M.c,1386 :: 		EEPROM_Write(10, (ipMaskPom1[1]-48)*10 + (ipMaskPom1[2]-48));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom1+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1387 :: 		}
L_SPI_Ethernet_UserTCP213:
;SE9M.c,1388 :: 		if ( (ipMaskPom1[0] < '1') && (ipMaskPom1[1] < '1') && (ipMaskPom1[2] >= '0') && (ipMaskPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP216
	MOVLW       49
	SUBWF       _ipMaskPom1+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP216
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP216
	MOVF        _ipMaskPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP216
L__SPI_Ethernet_UserTCP543:
;SE9M.c,1389 :: 		EEPROM_Write(10, (ipMaskPom1[2]-48));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1390 :: 		}
L_SPI_Ethernet_UserTCP216:
;SE9M.c,1392 :: 		if ( (ipMaskPom2[0] >= '1') && (ipMaskPom2[0] <= '9') && (ipMaskPom2[1] >= '0') && (ipMaskPom2[1] <= '9') && (ipMaskPom2[2] >= '0') && (ipMaskPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP219
	MOVF        _ipMaskPom2+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP219
	MOVLW       48
	SUBWF       _ipMaskPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP219
	MOVF        _ipMaskPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP219
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP219
	MOVF        _ipMaskPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP219
L__SPI_Ethernet_UserTCP542:
;SE9M.c,1393 :: 		EEPROM_Write(11, (ipMaskPom2[0]-48)*100 + (ipMaskPom2[1]-48)*10 + (ipMaskPom2[2]-48));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom2+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1394 :: 		}
L_SPI_Ethernet_UserTCP219:
;SE9M.c,1395 :: 		if ( (ipMaskPom2[0] < '1') && (ipMaskPom2[1] >= '1') && (ipMaskPom2[1] <= '9') && (ipMaskPom2[2] >= '0') && (ipMaskPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP222
	MOVLW       49
	SUBWF       _ipMaskPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP222
	MOVF        _ipMaskPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP222
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP222
	MOVF        _ipMaskPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP222
L__SPI_Ethernet_UserTCP541:
;SE9M.c,1396 :: 		EEPROM_Write(11, (ipMaskPom2[1]-48)*10 + (ipMaskPom2[2]-48));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom2+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1397 :: 		}
L_SPI_Ethernet_UserTCP222:
;SE9M.c,1398 :: 		if ( (ipMaskPom2[0] < '1') && (ipMaskPom2[1] < '1') && (ipMaskPom2[2] >= '0') && (ipMaskPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP225
	MOVLW       49
	SUBWF       _ipMaskPom2+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP225
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP225
	MOVF        _ipMaskPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP225
L__SPI_Ethernet_UserTCP540:
;SE9M.c,1399 :: 		EEPROM_Write(11, (ipMaskPom2[2]-48));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1400 :: 		}
L_SPI_Ethernet_UserTCP225:
;SE9M.c,1402 :: 		if ( (ipMaskPom3[0] >= '1') && (ipMaskPom3[0] <= '9') && (ipMaskPom3[1] >= '0') && (ipMaskPom3[1] <= '9') && (ipMaskPom3[2] >= '0') && (ipMaskPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom3+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP228
	MOVF        _ipMaskPom3+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP228
	MOVLW       48
	SUBWF       _ipMaskPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP228
	MOVF        _ipMaskPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP228
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP228
	MOVF        _ipMaskPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP228
L__SPI_Ethernet_UserTCP539:
;SE9M.c,1403 :: 		EEPROM_Write(12, (ipMaskPom3[0]-48)*100 + (ipMaskPom3[1]-48)*10 + (ipMaskPom3[2]-48));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom3+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom3+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1404 :: 		}
L_SPI_Ethernet_UserTCP228:
;SE9M.c,1405 :: 		if ( (ipMaskPom3[0] < '1') && (ipMaskPom3[1] >= '1') && (ipMaskPom3[1] <= '9') && (ipMaskPom3[2] >= '0') && (ipMaskPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP231
	MOVLW       49
	SUBWF       _ipMaskPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP231
	MOVF        _ipMaskPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP231
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP231
	MOVF        _ipMaskPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP231
L__SPI_Ethernet_UserTCP538:
;SE9M.c,1406 :: 		EEPROM_Write(12, (ipMaskPom3[1]-48)*10 + (ipMaskPom3[2]-48));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom3+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1407 :: 		}
L_SPI_Ethernet_UserTCP231:
;SE9M.c,1408 :: 		if ( (ipMaskPom3[0] < '1') && (ipMaskPom3[1] < '1') && (ipMaskPom3[2] >= '0') && (ipMaskPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP234
	MOVLW       49
	SUBWF       _ipMaskPom3+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP234
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP234
	MOVF        _ipMaskPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP234
L__SPI_Ethernet_UserTCP537:
;SE9M.c,1409 :: 		EEPROM_Write(12, (ipMaskPom3[2]-48));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1410 :: 		}
L_SPI_Ethernet_UserTCP234:
;SE9M.c,1414 :: 		if ( (dnsIpAddrPom0[0] >= '1') && (dnsIpAddrPom0[0] <= '9') && (dnsIpAddrPom0[1] >= '0') && (dnsIpAddrPom0[1] <= '9') && (dnsIpAddrPom0[2] >= '0') && (dnsIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP237
	MOVF        _dnsIpAddrPom0+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP237
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP237
	MOVF        _dnsIpAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP237
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP237
	MOVF        _dnsIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP237
L__SPI_Ethernet_UserTCP536:
;SE9M.c,1415 :: 		EEPROM_Write(13, (dnsIpAddrPom0[0]-48)*100 + (dnsIpAddrPom0[1]-48)*10 + (dnsIpAddrPom0[2]-48));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1416 :: 		}
L_SPI_Ethernet_UserTCP237:
;SE9M.c,1417 :: 		if ( (dnsIpAddrPom0[0] < '1') && (dnsIpAddrPom0[1] >= '1') && (dnsIpAddrPom0[1] <= '9') && (dnsIpAddrPom0[2] >= '0') && (dnsIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP240
	MOVLW       49
	SUBWF       _dnsIpAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP240
	MOVF        _dnsIpAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP240
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP240
	MOVF        _dnsIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP240
L__SPI_Ethernet_UserTCP535:
;SE9M.c,1418 :: 		EEPROM_Write(13, (dnsIpAddrPom0[1]-48)*10 + (dnsIpAddrPom0[2]-48));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1419 :: 		}
L_SPI_Ethernet_UserTCP240:
;SE9M.c,1420 :: 		if ( (dnsIpAddrPom0[0] < '1') && (dnsIpAddrPom0[1] < '1') && (dnsIpAddrPom0[2] >= '0') && (dnsIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP243
	MOVLW       49
	SUBWF       _dnsIpAddrPom0+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP243
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP243
	MOVF        _dnsIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP243
L__SPI_Ethernet_UserTCP534:
;SE9M.c,1421 :: 		EEPROM_Write(13, (dnsIpAddrPom0[2]-48));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1422 :: 		}
L_SPI_Ethernet_UserTCP243:
;SE9M.c,1424 :: 		if ( (dnsIpAddrPom1[0] >= '1') && (dnsIpAddrPom1[0] <= '9') && (dnsIpAddrPom1[1] >= '0') && (dnsIpAddrPom1[1] <= '9') && (dnsIpAddrPom1[2] >= '0') && (dnsIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP246
	MOVF        _dnsIpAddrPom1+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP246
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP246
	MOVF        _dnsIpAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP246
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP246
	MOVF        _dnsIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP246
L__SPI_Ethernet_UserTCP533:
;SE9M.c,1425 :: 		EEPROM_Write(14, (dnsIpAddrPom1[0]-48)*100 + (dnsIpAddrPom1[1]-48)*10 + (dnsIpAddrPom1[2]-48));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1426 :: 		}
L_SPI_Ethernet_UserTCP246:
;SE9M.c,1427 :: 		if ( (dnsIpAddrPom1[0] < '1') && (dnsIpAddrPom1[1] >= '1') && (dnsIpAddrPom1[1] <= '9') && (dnsIpAddrPom1[2] >= '0') && (dnsIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP249
	MOVLW       49
	SUBWF       _dnsIpAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP249
	MOVF        _dnsIpAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP249
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP249
	MOVF        _dnsIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP249
L__SPI_Ethernet_UserTCP532:
;SE9M.c,1428 :: 		EEPROM_Write(14, (dnsIpAddrPom1[1]-48)*10 + (dnsIpAddrPom1[2]-48));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1429 :: 		}
L_SPI_Ethernet_UserTCP249:
;SE9M.c,1430 :: 		if ( (dnsIpAddrPom1[0] < '1') && (dnsIpAddrPom1[1] < '1') && (dnsIpAddrPom1[2] >= '0') && (dnsIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP252
	MOVLW       49
	SUBWF       _dnsIpAddrPom1+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP252
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP252
	MOVF        _dnsIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP252
L__SPI_Ethernet_UserTCP531:
;SE9M.c,1431 :: 		EEPROM_Write(14, (dnsIpAddrPom1[2]-48));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1432 :: 		}
L_SPI_Ethernet_UserTCP252:
;SE9M.c,1434 :: 		if ( (dnsIpAddrPom2[0] >= '1') && (dnsIpAddrPom2[0] <= '9') && (dnsIpAddrPom2[1] >= '0') && (dnsIpAddrPom2[1] <= '9') && (dnsIpAddrPom2[2] >= '0') && (dnsIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP255
	MOVF        _dnsIpAddrPom2+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP255
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP255
	MOVF        _dnsIpAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP255
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP255
	MOVF        _dnsIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP255
L__SPI_Ethernet_UserTCP530:
;SE9M.c,1435 :: 		EEPROM_Write(15, (dnsIpAddrPom2[0]-48)*100 + (dnsIpAddrPom2[1]-48)*10 + (dnsIpAddrPom2[2]-48));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1436 :: 		}
L_SPI_Ethernet_UserTCP255:
;SE9M.c,1437 :: 		if ( (dnsIpAddrPom2[0] < '1') && (dnsIpAddrPom2[1] >= '1') && (dnsIpAddrPom2[1] <= '9') && (dnsIpAddrPom2[2] >= '0') && (dnsIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP258
	MOVLW       49
	SUBWF       _dnsIpAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP258
	MOVF        _dnsIpAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP258
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP258
	MOVF        _dnsIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP258
L__SPI_Ethernet_UserTCP529:
;SE9M.c,1438 :: 		EEPROM_Write(15, (dnsIpAddrPom2[1]-48)*10 + (dnsIpAddrPom2[2]-48));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1439 :: 		}
L_SPI_Ethernet_UserTCP258:
;SE9M.c,1440 :: 		if ( (dnsIpAddrPom2[0] < '1') && (dnsIpAddrPom2[1] < '1') && (dnsIpAddrPom2[2] >= '0') && (dnsIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP261
	MOVLW       49
	SUBWF       _dnsIpAddrPom2+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP261
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP261
	MOVF        _dnsIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP261
L__SPI_Ethernet_UserTCP528:
;SE9M.c,1441 :: 		EEPROM_Write(15, (dnsIpAddrPom2[2]-48));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1442 :: 		}
L_SPI_Ethernet_UserTCP261:
;SE9M.c,1444 :: 		if ( (dnsIpAddrPom3[0] >= '1') && (dnsIpAddrPom3[0] <= '9') && (dnsIpAddrPom3[1] >= '0') && (dnsIpAddrPom3[1] <= '9') && (dnsIpAddrPom3[2] >= '0') && (dnsIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom3+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP264
	MOVF        _dnsIpAddrPom3+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP264
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP264
	MOVF        _dnsIpAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP264
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP264
	MOVF        _dnsIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP264
L__SPI_Ethernet_UserTCP527:
;SE9M.c,1445 :: 		EEPROM_Write(16, (dnsIpAddrPom3[0]-48)*100 + (dnsIpAddrPom3[1]-48)*10 + (dnsIpAddrPom3[2]-48));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1446 :: 		}
L_SPI_Ethernet_UserTCP264:
;SE9M.c,1447 :: 		if ( (dnsIpAddrPom3[0] < '1') && (dnsIpAddrPom3[1] >= '1') && (dnsIpAddrPom3[1] <= '9') && (dnsIpAddrPom3[2] >= '0') && (dnsIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP267
	MOVLW       49
	SUBWF       _dnsIpAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP267
	MOVF        _dnsIpAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP267
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP267
	MOVF        _dnsIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP267
L__SPI_Ethernet_UserTCP526:
;SE9M.c,1448 :: 		EEPROM_Write(16, (dnsIpAddrPom3[1]-48)*10 + (dnsIpAddrPom3[2]-48));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1449 :: 		}
L_SPI_Ethernet_UserTCP267:
;SE9M.c,1450 :: 		if ( (dnsIpAddrPom3[0] < '1') && (dnsIpAddrPom3[1] < '1') && (dnsIpAddrPom3[2] >= '0') && (dnsIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP270
	MOVLW       49
	SUBWF       _dnsIpAddrPom3+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP270
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP270
	MOVF        _dnsIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP270
L__SPI_Ethernet_UserTCP525:
;SE9M.c,1451 :: 		EEPROM_Write(16, (dnsIpAddrPom3[2]-48));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1452 :: 		}
L_SPI_Ethernet_UserTCP270:
;SE9M.c,1453 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_SPI_Ethernet_UserTCP271:
	DECFSZ      R13, 1, 1
	BRA         L_SPI_Ethernet_UserTCP271
	DECFSZ      R12, 1, 1
	BRA         L_SPI_Ethernet_UserTCP271
	DECFSZ      R11, 1, 1
	BRA         L_SPI_Ethernet_UserTCP271
;SE9M.c,1454 :: 		Rst_Eth();
	CALL        _Rst_Eth+0, 0
;SE9M.c,1455 :: 		}
L_SPI_Ethernet_UserTCP126:
;SE9M.c,1456 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP122
;SE9M.c,1457 :: 		case 'n':
L_SPI_Ethernet_UserTCP272:
;SE9M.c,1459 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP273
;SE9M.c,1460 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP274
;SE9M.c,1461 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1462 :: 		ByteToStr(pomocni,IpAddrPom0);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1463 :: 		}
L_SPI_Ethernet_UserTCP274:
;SE9M.c,1464 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP275
;SE9M.c,1465 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1466 :: 		ByteToStr(pomocni,ipMaskPom0);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1467 :: 		}
L_SPI_Ethernet_UserTCP275:
;SE9M.c,1468 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP276
;SE9M.c,1469 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1470 :: 		ByteToStr(pomocni,gwIpAddrPom0);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1471 :: 		}
L_SPI_Ethernet_UserTCP276:
;SE9M.c,1472 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP277
;SE9M.c,1473 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1474 :: 		ByteToStr(pomocni,dnsIpAddrPom0);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1475 :: 		}
L_SPI_Ethernet_UserTCP277:
;SE9M.c,1476 :: 		}
L_SPI_Ethernet_UserTCP273:
;SE9M.c,1477 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP122
;SE9M.c,1478 :: 		case 'o':
L_SPI_Ethernet_UserTCP278:
;SE9M.c,1480 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP279
;SE9M.c,1481 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP280
;SE9M.c,1482 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1483 :: 		ByteToStr(pomocni,IpAddrPom1);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1484 :: 		}
L_SPI_Ethernet_UserTCP280:
;SE9M.c,1485 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP281
;SE9M.c,1486 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1487 :: 		ByteToStr(pomocni,ipMaskPom1);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1488 :: 		}
L_SPI_Ethernet_UserTCP281:
;SE9M.c,1489 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP282
;SE9M.c,1490 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1491 :: 		ByteToStr(pomocni,gwIpAddrPom1);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1492 :: 		}
L_SPI_Ethernet_UserTCP282:
;SE9M.c,1493 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP283
;SE9M.c,1494 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1495 :: 		ByteToStr(pomocni,dnsIpAddrPom1);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1496 :: 		}
L_SPI_Ethernet_UserTCP283:
;SE9M.c,1497 :: 		}
L_SPI_Ethernet_UserTCP279:
;SE9M.c,1498 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP122
;SE9M.c,1499 :: 		case 'p':
L_SPI_Ethernet_UserTCP284:
;SE9M.c,1501 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP285
;SE9M.c,1502 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP286
;SE9M.c,1503 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1504 :: 		ByteToStr(pomocni,IpAddrPom2);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1505 :: 		}
L_SPI_Ethernet_UserTCP286:
;SE9M.c,1506 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP287
;SE9M.c,1507 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1508 :: 		ByteToStr(pomocni,ipMaskPom2);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1509 :: 		}
L_SPI_Ethernet_UserTCP287:
;SE9M.c,1510 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP288
;SE9M.c,1511 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1512 :: 		ByteToStr(pomocni,gwIpAddrPom2);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1513 :: 		}
L_SPI_Ethernet_UserTCP288:
;SE9M.c,1514 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP289
;SE9M.c,1515 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1516 :: 		ByteToStr(pomocni,dnsIpAddrPom2);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1517 :: 		}
L_SPI_Ethernet_UserTCP289:
;SE9M.c,1518 :: 		}
L_SPI_Ethernet_UserTCP285:
;SE9M.c,1519 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP122
;SE9M.c,1520 :: 		case 'q':
L_SPI_Ethernet_UserTCP290:
;SE9M.c,1522 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP291
;SE9M.c,1523 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP292
;SE9M.c,1524 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1525 :: 		ByteToStr(pomocni,IpAddrPom3);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1526 :: 		}
L_SPI_Ethernet_UserTCP292:
;SE9M.c,1527 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP293
;SE9M.c,1528 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1529 :: 		ByteToStr(pomocni,ipMaskPom3);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1530 :: 		}
L_SPI_Ethernet_UserTCP293:
;SE9M.c,1531 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP294
;SE9M.c,1532 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1533 :: 		ByteToStr(pomocni,gwIpAddrPom3);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1534 :: 		}
L_SPI_Ethernet_UserTCP294:
;SE9M.c,1535 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP295
;SE9M.c,1536 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1537 :: 		ByteToStr(pomocni,dnsIpAddrPom3);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1538 :: 		}
L_SPI_Ethernet_UserTCP295:
;SE9M.c,1539 :: 		}
L_SPI_Ethernet_UserTCP291:
;SE9M.c,1540 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP122
;SE9M.c,1541 :: 		case 'v':
L_SPI_Ethernet_UserTCP296:
;SE9M.c,1544 :: 		pomocnaSifra[0] = getRequest[sizeof(path_private) + 2] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+9, 0 
	MOVWF       _pomocnaSifra+0 
;SE9M.c,1545 :: 		pomocnaSifra[1] = getRequest[sizeof(path_private) + 3] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+10, 0 
	MOVWF       _pomocnaSifra+1 
;SE9M.c,1546 :: 		pomocnaSifra[2] = getRequest[sizeof(path_private) + 4] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+11, 0 
	MOVWF       _pomocnaSifra+2 
;SE9M.c,1547 :: 		pomocnaSifra[3] = getRequest[sizeof(path_private) + 5] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+12, 0 
	MOVWF       _pomocnaSifra+3 
;SE9M.c,1548 :: 		pomocnaSifra[4] = getRequest[sizeof(path_private) + 6] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+13, 0 
	MOVWF       _pomocnaSifra+4 
;SE9M.c,1549 :: 		pomocnaSifra[5] = getRequest[sizeof(path_private) + 7] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+14, 0 
	MOVWF       _pomocnaSifra+5 
;SE9M.c,1550 :: 		pomocnaSifra[6] = getRequest[sizeof(path_private) + 8] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+15, 0 
	MOVWF       _pomocnaSifra+6 
;SE9M.c,1551 :: 		pomocnaSifra[7] = getRequest[sizeof(path_private) + 9] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+16, 0 
	MOVWF       _pomocnaSifra+7 
;SE9M.c,1552 :: 		pomocnaSifra[8] = 0;
	CLRF        _pomocnaSifra+8 
;SE9M.c,1555 :: 		if (strcmp(sifra,pomocnaSifra) == 0) {
	MOVLW       _sifra+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       _pomocnaSifra+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(_pomocnaSifra+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP610
	MOVLW       0
	XORWF       R0, 0 
L__SPI_Ethernet_UserTCP610:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP297
;SE9M.c,1556 :: 		tmr_rst_en = 1;
	MOVLW       1
	MOVWF       _tmr_rst_en+0 
;SE9M.c,1557 :: 		admin = 1;
	MOVLW       1
	MOVWF       _admin+0 
;SE9M.c,1558 :: 		len = 0;
	CLRF        SPI_Ethernet_UserTCP_len_L0+0 
	CLRF        SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1559 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1560 :: 		len += putConstString(HTMLredirect) ;
	MOVF        _HTMLredirect+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLredirect+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLredirect+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1561 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1562 :: 		goto ZAVRSI;
	GOTO        ___SPI_Ethernet_UserTCP_ZAVRSI
;SE9M.c,1564 :: 		}
L_SPI_Ethernet_UserTCP297:
;SE9M.c,1565 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP122
;SE9M.c,1566 :: 		case 'x':
L_SPI_Ethernet_UserTCP298:
;SE9M.c,1569 :: 		oldSifra[0] = getRequest[sizeof(path_private) + 2] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+9, 0 
	MOVWF       _oldSifra+0 
;SE9M.c,1570 :: 		oldSifra[1] = getRequest[sizeof(path_private) + 3] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+10, 0 
	MOVWF       _oldSifra+1 
;SE9M.c,1571 :: 		oldSifra[2] = getRequest[sizeof(path_private) + 4] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+11, 0 
	MOVWF       _oldSifra+2 
;SE9M.c,1572 :: 		oldSifra[3] = getRequest[sizeof(path_private) + 5] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+12, 0 
	MOVWF       _oldSifra+3 
;SE9M.c,1573 :: 		oldSifra[4] = getRequest[sizeof(path_private) + 6] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+13, 0 
	MOVWF       _oldSifra+4 
;SE9M.c,1574 :: 		oldSifra[5] = getRequest[sizeof(path_private) + 7] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+14, 0 
	MOVWF       _oldSifra+5 
;SE9M.c,1575 :: 		oldSifra[6] = getRequest[sizeof(path_private) + 8] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+15, 0 
	MOVWF       _oldSifra+6 
;SE9M.c,1576 :: 		oldSifra[7] = getRequest[sizeof(path_private) + 9] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+16, 0 
	MOVWF       _oldSifra+7 
;SE9M.c,1577 :: 		oldSifra[8] = 0;
	CLRF        _oldSifra+8 
;SE9M.c,1578 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP122
;SE9M.c,1579 :: 		case 'y':
L_SPI_Ethernet_UserTCP299:
;SE9M.c,1582 :: 		newSifra[0] = getRequest[sizeof(path_private) + 2] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+9, 0 
	MOVWF       _newSifra+0 
;SE9M.c,1583 :: 		newSifra[1] = getRequest[sizeof(path_private) + 3] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+10, 0 
	MOVWF       _newSifra+1 
;SE9M.c,1584 :: 		newSifra[2] = getRequest[sizeof(path_private) + 4] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+11, 0 
	MOVWF       _newSifra+2 
;SE9M.c,1585 :: 		newSifra[3] = getRequest[sizeof(path_private) + 5] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+12, 0 
	MOVWF       _newSifra+3 
;SE9M.c,1586 :: 		newSifra[4] = getRequest[sizeof(path_private) + 6] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+13, 0 
	MOVWF       _newSifra+4 
;SE9M.c,1587 :: 		newSifra[5] = getRequest[sizeof(path_private) + 7] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+14, 0 
	MOVWF       _newSifra+5 
;SE9M.c,1588 :: 		newSifra[6] = getRequest[sizeof(path_private) + 8] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+15, 0 
	MOVWF       _newSifra+6 
;SE9M.c,1589 :: 		newSifra[7] = getRequest[sizeof(path_private) + 9] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+16, 0 
	MOVWF       _newSifra+7 
;SE9M.c,1590 :: 		newSifra[8] = 0;
	CLRF        _newSifra+8 
;SE9M.c,1591 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP122
;SE9M.c,1593 :: 		case 'w' :
L_SPI_Ethernet_UserTCP300:
;SE9M.c,1595 :: 		if (strcmp(sifra, oldSifra) == 0) {
	MOVLW       _sifra+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP611
	MOVLW       0
	XORWF       R0, 0 
L__SPI_Ethernet_UserTCP611:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP301
;SE9M.c,1596 :: 		rest = strcpy(sifra, newSifra);
	MOVLW       _sifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	MOVF        R0, 0 
	MOVWF       _rest+0 
	MOVF        R1, 0 
	MOVWF       _rest+1 
;SE9M.c,1597 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,1598 :: 		}
L_SPI_Ethernet_UserTCP301:
;SE9M.c,1599 :: 		EEPROM_Write(20, sifra[0]);
	MOVLW       20
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1600 :: 		EEPROM_Write(21, sifra[1]);
	MOVLW       21
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1601 :: 		EEPROM_Write(22, sifra[2]);
	MOVLW       22
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1602 :: 		EEPROM_Write(23, sifra[3]);
	MOVLW       23
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1603 :: 		EEPROM_Write(24, sifra[4]);
	MOVLW       24
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1604 :: 		EEPROM_Write(25, sifra[5]);
	MOVLW       25
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1605 :: 		EEPROM_Write(26, sifra[6]);
	MOVLW       26
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1606 :: 		EEPROM_Write(27, sifra[7]);
	MOVLW       27
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1607 :: 		EEPROM_Write(28, sifra[8]);
	MOVLW       28
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1608 :: 		strcpy(oldSifra, "OLD     ");
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr169_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr169_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1609 :: 		strcpy(newSifra, "NEW     ");
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr170_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr170_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1610 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_SPI_Ethernet_UserTCP302:
	DECFSZ      R13, 1, 1
	BRA         L_SPI_Ethernet_UserTCP302
	DECFSZ      R12, 1, 1
	BRA         L_SPI_Ethernet_UserTCP302
	DECFSZ      R11, 1, 1
	BRA         L_SPI_Ethernet_UserTCP302
;SE9M.c,1611 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP122
;SE9M.c,1612 :: 		case 'u':
L_SPI_Ethernet_UserTCP303:
;SE9M.c,1613 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP304
;SE9M.c,1614 :: 		s_ip = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _s_ip+0 
;SE9M.c,1615 :: 		s_ip += 1 ;
	MOVF        R0, 0 
	ADDLW       1
	MOVWF       _s_ip+0 
;SE9M.c,1616 :: 		}
L_SPI_Ethernet_UserTCP304:
;SE9M.c,1617 :: 		saveConf() ;
	CALL        _saveConf+0, 0
;SE9M.c,1618 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP122
;SE9M.c,1620 :: 		case 't':
L_SPI_Ethernet_UserTCP305:
;SE9M.c,1622 :: 		conf.tz = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+2 
;SE9M.c,1623 :: 		conf.tz -= 11 ;
	MOVLW       11
	SUBWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _conf+2 
;SE9M.c,1624 :: 		Eeprom_Write(102, conf.tz);
	MOVLW       102
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1625 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_SPI_Ethernet_UserTCP306:
	DECFSZ      R13, 1, 1
	BRA         L_SPI_Ethernet_UserTCP306
	DECFSZ      R12, 1, 1
	BRA         L_SPI_Ethernet_UserTCP306
	DECFSZ      R11, 1, 1
	BRA         L_SPI_Ethernet_UserTCP306
;SE9M.c,1626 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP122
;SE9M.c,1627 :: 		}
L_SPI_Ethernet_UserTCP121:
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP123
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       114
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP125
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       110
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP272
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       111
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP278
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       112
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP284
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       113
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP290
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       118
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP296
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       120
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP298
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       121
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP299
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       119
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP300
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       117
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP303
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       116
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP305
L_SPI_Ethernet_UserTCP122:
;SE9M.c,1629 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1630 :: 		if (admin == 0) {
	MOVF        _admin+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP307
;SE9M.c,1631 :: 		len += putConstString(HTMLadmin0);
	MOVF        _HTMLadmin0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLadmin0+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLadmin0+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1632 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP308
L_SPI_Ethernet_UserTCP307:
;SE9M.c,1633 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP309
;SE9M.c,1634 :: 		len += putConstString(HTMLadmin1) ;
	MOVF        _HTMLadmin1+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLadmin1+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLadmin1+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1635 :: 		}
L_SPI_Ethernet_UserTCP309:
;SE9M.c,1636 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP310
;SE9M.c,1637 :: 		len += putConstString(HTMLadmin2) ;
	MOVF        _HTMLadmin2+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLadmin2+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLadmin2+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1638 :: 		}
L_SPI_Ethernet_UserTCP310:
;SE9M.c,1639 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP311
;SE9M.c,1640 :: 		len += putConstString(HTMLadmin3) ;
	MOVF        _HTMLadmin3+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLadmin3+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLadmin3+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1641 :: 		}
L_SPI_Ethernet_UserTCP311:
;SE9M.c,1642 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP312
;SE9M.c,1643 :: 		len += putConstString(HTMLadmin4) ;
	MOVF        _HTMLadmin4+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLadmin4+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLadmin4+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1644 :: 		}
L_SPI_Ethernet_UserTCP312:
;SE9M.c,1645 :: 		}
L_SPI_Ethernet_UserTCP308:
;SE9M.c,1646 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1647 :: 		}
L_SPI_Ethernet_UserTCP120:
;SE9M.c,1649 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP313
L_SPI_Ethernet_UserTCP58:
;SE9M.c,1650 :: 		else switch(getRequest[1])
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,1653 :: 		case 's':
L_SPI_Ethernet_UserTCP316:
;SE9M.c,1655 :: 		if(lastSync == 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       _lastSync+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP612
	MOVF        R0, 0 
	XORWF       _lastSync+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP612
	MOVF        R0, 0 
	XORWF       _lastSync+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP612
	MOVF        _lastSync+0, 0 
	XORLW       0
L__SPI_Ethernet_UserTCP612:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP317
;SE9M.c,1657 :: 		len = putConstString(CSSred) ;          // not sync
	MOVF        _CSSred+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _CSSred+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _CSSred+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1658 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP318
L_SPI_Ethernet_UserTCP317:
;SE9M.c,1661 :: 		len = putConstString(CSSgreen) ;        // sync
	MOVF        _CSSgreen+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _CSSgreen+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _CSSgreen+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1662 :: 		}
L_SPI_Ethernet_UserTCP318:
;SE9M.c,1663 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP315
;SE9M.c,1664 :: 		case 'a':
L_SPI_Ethernet_UserTCP319:
;SE9M.c,1667 :: 		len = putConstString(httpHeader) ;
	MOVLW       _httpHeader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1668 :: 		len += putConstString(httpMimeTypeScript) ;
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1671 :: 		ts2str(dyna, &ts, TS2STR_ALL | TS2STR_TZ) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _ts+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       7
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,1672 :: 		len += putConstString("var NOW=\"") ;
	MOVLW       ?lstr_171_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_171_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_171_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1673 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1674 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_172_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_172_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_172_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1677 :: 		int2str(epoch, dyna) ;
	MOVF        _epoch+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVF        _epoch+1, 0 
	MOVWF       FARG_int2str_l+1 
	MOVF        _epoch+2, 0 
	MOVWF       FARG_int2str_l+2 
	MOVF        _epoch+3, 0 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1678 :: 		len += putConstString("var EPOCH=") ;
	MOVLW       ?lstr_173_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_173_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_173_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1679 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1680 :: 		len += putConstString(";") ;
	MOVLW       ?lstr_174_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_174_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_174_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1683 :: 		if(lastSync == 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       _lastSync+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP613
	MOVF        R0, 0 
	XORWF       _lastSync+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP613
	MOVF        R0, 0 
	XORWF       _lastSync+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP613
	MOVF        _lastSync+0, 0 
	XORLW       0
L__SPI_Ethernet_UserTCP613:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP320
;SE9M.c,1685 :: 		strcpy(dyna, "???") ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr175_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr175_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1686 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP321
L_SPI_Ethernet_UserTCP320:
;SE9M.c,1689 :: 		Time_epochToDate(t_rec + tmzn * 3600, &ls) ;
	MOVF        _tmzn+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _tmzn+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       16
	MOVWF       R4 
	MOVLW       14
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       _t_rec+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        R1, 0 
	ADDWFC      _t_rec+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _t_rec+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _t_rec+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVLW       _ls+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(_ls+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,1690 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,1691 :: 		ts2str(dyna, &ls, TS2STR_ALL | TS2STR_TZ) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _ls+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_ls+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       7
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,1692 :: 		}
L_SPI_Ethernet_UserTCP321:
;SE9M.c,1693 :: 		len += putConstString("var LAST=\"") ;
	MOVLW       ?lstr_176_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_176_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_176_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1694 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1695 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_177_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_177_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_177_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1697 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP315
;SE9M.c,1699 :: 		case 'b':
L_SPI_Ethernet_UserTCP322:
;SE9M.c,1702 :: 		len = putConstString(httpHeader) ;
	MOVLW       _httpHeader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1703 :: 		len += putConstString(httpMimeTypeScript) ;
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1706 :: 		ip2str(dyna, conf.sntpIP) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _conf+3
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1707 :: 		len += putConstString("var SNTP=\"") ;
	MOVLW       ?lstr_178_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_178_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_178_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1708 :: 		len += putString(conf.sntpServer) ;
	MOVLW       _conf+7
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_conf+7)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1709 :: 		len += putConstString(" (") ;
	MOVLW       ?lstr_179_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_179_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_179_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1710 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1711 :: 		len += putConstString(")") ;
	MOVLW       ?lstr_180_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_180_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_180_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1712 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_181_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_181_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_181_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1715 :: 		if(serverStratum == 0)
	MOVF        _serverStratum+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP323
;SE9M.c,1717 :: 		strcpy(dyna, "Unspecified") ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr182_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr182_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1718 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP324
L_SPI_Ethernet_UserTCP323:
;SE9M.c,1719 :: 		else if(serverStratum == 1)
	MOVF        _serverStratum+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP325
;SE9M.c,1721 :: 		strcpy(dyna, "1 (primary)") ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr183_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr183_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1722 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP326
L_SPI_Ethernet_UserTCP325:
;SE9M.c,1723 :: 		else if(serverStratum < 16)
	MOVLW       16
	SUBWF       _serverStratum+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP327
;SE9M.c,1725 :: 		int2str(serverStratum, dyna) ;
	MOVF        _serverStratum+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVLW       0
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1726 :: 		strcat(dyna, "(secondary)") ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr184_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr184_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,1727 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP328
L_SPI_Ethernet_UserTCP327:
;SE9M.c,1730 :: 		int2str(serverStratum, dyna) ;
	MOVF        _serverStratum+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVLW       0
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1731 :: 		strcat(dyna, " (reserved)") ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr185_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr185_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,1732 :: 		}
L_SPI_Ethernet_UserTCP328:
L_SPI_Ethernet_UserTCP326:
L_SPI_Ethernet_UserTCP324:
;SE9M.c,1733 :: 		len += putConstString("var STRATUM=\"") ;
	MOVLW       ?lstr_186_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_186_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_186_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1734 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1735 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_187_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_187_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_187_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1738 :: 		switch(serverFlags & 0b11000000)
	MOVLW       192
	ANDWF       _serverFlags+0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserTCP+0 
	GOTO        L_SPI_Ethernet_UserTCP329
;SE9M.c,1740 :: 		case 0b00000000: strcpy(dyna, "No warning") ; break ;
L_SPI_Ethernet_UserTCP331:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr188_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr188_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP330
;SE9M.c,1741 :: 		case 0b01000000: strcpy(dyna, "Last minute has 61 seconds") ; break ;
L_SPI_Ethernet_UserTCP332:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr189_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr189_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP330
;SE9M.c,1742 :: 		case 0b10000000: strcpy(dyna, "Last minute has 59 seconds") ; break ;
L_SPI_Ethernet_UserTCP333:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr190_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr190_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP330
;SE9M.c,1743 :: 		case 0b11000000: strcpy(dyna, "SNTP server not synchronized") ; break ;
L_SPI_Ethernet_UserTCP334:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr191_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr191_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP330
;SE9M.c,1744 :: 		}
L_SPI_Ethernet_UserTCP329:
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP331
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       64
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP332
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       128
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP333
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       192
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP334
L_SPI_Ethernet_UserTCP330:
;SE9M.c,1745 :: 		len += putConstString("var LEAP=\"") ;
	MOVLW       ?lstr_192_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_192_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_192_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1746 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1747 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_193_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_193_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_193_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1749 :: 		int2str(serverPrecision, dyna) ;
	MOVF        _serverPrecision+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVLW       0
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1750 :: 		len += putConstString("var PRECISION=\"") ;
	MOVLW       ?lstr_194_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_194_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_194_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1751 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1752 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_195_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_195_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_195_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1754 :: 		switch(serverFlags & 0b00111000)
	MOVLW       56
	ANDWF       _serverFlags+0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserTCP+0 
	GOTO        L_SPI_Ethernet_UserTCP335
;SE9M.c,1756 :: 		case 0b00011000: strcpy(dyna, "IPv4 only") ; break ;
L_SPI_Ethernet_UserTCP337:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr196_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr196_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP336
;SE9M.c,1757 :: 		case 0b00110000: strcpy(dyna, "IPv4, IPv6 and OSI") ; break ;
L_SPI_Ethernet_UserTCP338:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr197_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr197_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP336
;SE9M.c,1758 :: 		default: strcpy(dyna, "Undefined") ; break ;
L_SPI_Ethernet_UserTCP339:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr198_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr198_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP336
;SE9M.c,1759 :: 		}
L_SPI_Ethernet_UserTCP335:
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       24
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP337
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP338
	GOTO        L_SPI_Ethernet_UserTCP339
L_SPI_Ethernet_UserTCP336:
;SE9M.c,1760 :: 		len += putConstString("var VN=\"") ;
	MOVLW       ?lstr_199_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_199_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_199_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1761 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1762 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_200_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_200_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_200_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1764 :: 		switch(serverFlags & 0b00000111)
	MOVLW       7
	ANDWF       _serverFlags+0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserTCP+0 
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1766 :: 		case 0b00000000: strcpy(dyna, "Reserved") ; break ;
L_SPI_Ethernet_UserTCP342:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr201_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr201_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP341
;SE9M.c,1767 :: 		case 0b00000001: strcpy(dyna, "Symmetric active") ; break ;
L_SPI_Ethernet_UserTCP343:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr202_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr202_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP341
;SE9M.c,1768 :: 		case 0b00000010: strcpy(dyna, "Symmetric passive") ; break ;
L_SPI_Ethernet_UserTCP344:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr203_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr203_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP341
;SE9M.c,1769 :: 		case 0b00000011: strcpy(dyna, "Client") ; break ;
L_SPI_Ethernet_UserTCP345:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr204_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr204_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP341
;SE9M.c,1770 :: 		case 0b00000100: strcpy(dyna, "Server") ; break ;
L_SPI_Ethernet_UserTCP346:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr205_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr205_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP341
;SE9M.c,1771 :: 		case 0b00000101: strcpy(dyna, "Broadcast") ; break ;
L_SPI_Ethernet_UserTCP347:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr206_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr206_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP341
;SE9M.c,1772 :: 		case 0b00000110: strcpy(dyna, "Reserved for NTP control message") ; break ;
L_SPI_Ethernet_UserTCP348:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr207_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr207_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP341
;SE9M.c,1773 :: 		case 0b00000111: strcpy(dyna, "Reserved for private use") ; break ;
L_SPI_Ethernet_UserTCP349:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr208_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr208_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP341
;SE9M.c,1774 :: 		}
L_SPI_Ethernet_UserTCP340:
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP342
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP343
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP344
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP345
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP346
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP347
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP348
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP349
L_SPI_Ethernet_UserTCP341:
;SE9M.c,1775 :: 		len += putConstString("var MODE=\"") ;
	MOVLW       ?lstr_209_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_209_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_209_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1776 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1777 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_210_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_210_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_210_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1778 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP315
;SE9M.c,1780 :: 		case 'c':
L_SPI_Ethernet_UserTCP350:
;SE9M.c,1783 :: 		len = putConstString(httpHeader) ;              // HTTP header
	MOVLW       _httpHeader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1784 :: 		len += putConstString(httpMimeTypeScript) ;     // with text MIME type
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1787 :: 		ip2str(dyna, ipAddr) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1788 :: 		len += putConstString("var IP=\"") ;
	MOVLW       ?lstr_211_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_211_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_211_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1789 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1790 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_212_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_212_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_212_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1792 :: 		byte2hex(dyna, macAddr[0]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+0, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1793 :: 		byte2hex(dyna + 3, macAddr[1]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+3
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+3)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+1, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1794 :: 		byte2hex(dyna + 6, macAddr[2]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+6
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+6)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+2, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1795 :: 		byte2hex(dyna + 9, macAddr[3]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+9
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+9)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+3, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1796 :: 		byte2hex(dyna + 12, macAddr[4]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+12
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+12)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+4, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1797 :: 		byte2hex(dyna + 15, macAddr[5]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+15
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+15)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+5, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1798 :: 		*(dyna + 17) = 0 ;
	CLRF        SPI_Ethernet_UserTCP_dyna_L0+17 
;SE9M.c,1799 :: 		len += putConstString("var MAC=\"") ;
	MOVLW       ?lstr_213_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_213_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_213_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1800 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1801 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_214_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_214_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_214_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1804 :: 		ip2str(dyna, remoteHost) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVF        FARG_SPI_Ethernet_UserTCP_remoteHost+0, 0 
	MOVWF       FARG_ip2str_ip+0 
	MOVF        FARG_SPI_Ethernet_UserTCP_remoteHost+1, 0 
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1805 :: 		len += putConstString("var CLIENT=\"") ;
	MOVLW       ?lstr_215_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_215_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_215_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1806 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1807 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_216_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_216_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_216_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1810 :: 		ip2str(dyna, gwIpAddr) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _gwIpAddr+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_gwIpAddr+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1811 :: 		len += putConstString("var GW=\"") ;
	MOVLW       ?lstr_217_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_217_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_217_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1812 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1813 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_218_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_218_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_218_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1816 :: 		ip2str(dyna, ipMask) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _ipMask+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_ipMask+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1817 :: 		len += putConstString("var MASK=\"") ;
	MOVLW       ?lstr_219_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_219_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_219_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1818 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1819 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_220_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_220_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_220_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1822 :: 		ip2str(dyna, dnsIpAddr) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _dnsIpAddr+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_dnsIpAddr+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1823 :: 		len += putConstString("var DNS=\"") ;
	MOVLW       ?lstr_221_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_221_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_221_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1824 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1825 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_222_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_222_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_222_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1827 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP315
;SE9M.c,1829 :: 		case 'd':
L_SPI_Ethernet_UserTCP351:
;SE9M.c,1834 :: 		len = putConstString(httpHeader) ;              // HTTP header
	MOVLW       _httpHeader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1835 :: 		len += putConstString(httpMimeTypeScript) ;     // with text MIME type
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1837 :: 		len += putConstString("var SYSTEM=\"ENC28J60\";") ;
	MOVLW       ?lstr_223_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_223_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_223_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1839 :: 		int2str(Clock_kHz(), dyna) ;
	MOVLW       0
	MOVWF       FARG_int2str_l+0 
	MOVLW       125
	MOVWF       FARG_int2str_l+1 
	MOVLW       0
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1840 :: 		len += putConstString("var CLK=\"") ;
	MOVLW       ?lstr_224_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_224_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_224_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1841 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1842 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_225_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_225_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_225_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1845 :: 		int2str(httpCounter, dyna) ;
	MOVF        _httpCounter+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVF        _httpCounter+1, 0 
	MOVWF       FARG_int2str_l+1 
	MOVLW       0
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1846 :: 		len += putConstString("var REQ=") ;
	MOVLW       ?lstr_226_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_226_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_226_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1847 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1848 :: 		len += putConstString(";") ;
	MOVLW       ?lstr_227_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_227_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_227_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1850 :: 		Time_epochToDate(epoch - SPI_Ethernet_UserTimerSec + tmzn * 3600, &t) ;
	MOVF        _epoch+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        _epoch+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVF        _epoch+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVF        _epoch+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVF        _SPI_Ethernet_UserTimerSec+0, 0 
	SUBWF       FARG_Time_epochToDate_e+0, 1 
	MOVF        _SPI_Ethernet_UserTimerSec+1, 0 
	SUBWFB      FARG_Time_epochToDate_e+1, 1 
	MOVF        _SPI_Ethernet_UserTimerSec+2, 0 
	SUBWFB      FARG_Time_epochToDate_e+2, 1 
	MOVF        _SPI_Ethernet_UserTimerSec+3, 0 
	SUBWFB      FARG_Time_epochToDate_e+3, 1 
	MOVF        _tmzn+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _tmzn+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       16
	MOVWF       R4 
	MOVLW       14
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_Time_epochToDate_e+0, 1 
	MOVF        R1, 0 
	ADDWFC      FARG_Time_epochToDate_e+1, 1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      FARG_Time_epochToDate_e+2, 1 
	ADDWFC      FARG_Time_epochToDate_e+3, 1 
	MOVLW       SPI_Ethernet_UserTCP_t_L2+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_t_L2+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,1851 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,1852 :: 		ts2str(dyna, &t, TS2STR_ALL | TS2STR_TZ) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       SPI_Ethernet_UserTCP_t_L2+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_t_L2+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       7
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,1853 :: 		len += putConstString("var UP=\"") ;
	MOVLW       ?lstr_228_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_228_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_228_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1854 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1855 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_229_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_229_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_229_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1858 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP315
;SE9M.c,1861 :: 		case '4':
L_SPI_Ethernet_UserTCP352:
;SE9M.c,1862 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,1863 :: 		strcpy(oldSifra, "OLD     ");
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr230_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr230_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1864 :: 		strcpy(newSifra, "NEW     ");
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr231_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr231_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1866 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1867 :: 		len += putConstString(HTMLsystem) ;
	MOVF        _HTMLsystem+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLsystem+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLsystem+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1868 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1869 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP315
;SE9M.c,1871 :: 		case '3':
L_SPI_Ethernet_UserTCP353:
;SE9M.c,1872 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,1873 :: 		strcpy(oldSifra, "OLD     ");
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr232_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr232_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1874 :: 		strcpy(newSifra, "NEW     ");
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr233_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr233_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1876 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1877 :: 		len += putConstString(HTMLnetwork) ;
	MOVF        _HTMLnetwork+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLnetwork+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLnetwork+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1878 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1879 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP315
;SE9M.c,1881 :: 		case '2':
L_SPI_Ethernet_UserTCP354:
;SE9M.c,1882 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,1883 :: 		strcpy(oldSifra, "OLD     ");
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr234_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr234_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1884 :: 		strcpy(newSifra, "NEW     ");
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr235_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr235_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1887 :: 		if (getRequest[3] == 'r') {
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+3, 0 
	XORLW       114
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP355
;SE9M.c,1889 :: 		sntpSync = 0;
	CLRF        _sntpSync+0 
;SE9M.c,1890 :: 		sync_flag = 1;
	MOVLW       1
	MOVWF       _sync_flag+0 
;SE9M.c,1891 :: 		}
L_SPI_Ethernet_UserTCP355:
;SE9M.c,1894 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1895 :: 		len += putConstString(HTMLsntp) ;
	MOVF        _HTMLsntp+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLsntp+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLsntp+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1896 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1897 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP315
;SE9M.c,1899 :: 		case '1':
L_SPI_Ethernet_UserTCP356:
;SE9M.c,1900 :: 		default:
L_SPI_Ethernet_UserTCP357:
;SE9M.c,1901 :: 		if (uzobyte == 1) {
	MOVF        _uzobyte+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP358
;SE9M.c,1902 :: 		uzobyte = 0;
	CLRF        _uzobyte+0 
;SE9M.c,1903 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP359
L_SPI_Ethernet_UserTCP358:
;SE9M.c,1904 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,1905 :: 		strcpy(oldSifra, "OLD     ");
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr236_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr236_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1906 :: 		strcpy(newSifra, "NEW     ");
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr237_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr237_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1907 :: 		}
L_SPI_Ethernet_UserTCP359:
;SE9M.c,1909 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1910 :: 		len += putConstString(HTMLtime) ;
	MOVF        _HTMLtime+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLtime+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLtime+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1911 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1912 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP315
L_SPI_Ethernet_UserTCP314:
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       115
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP316
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       97
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP319
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       98
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP322
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       99
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP350
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       100
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP351
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       52
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP352
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       51
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP353
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP354
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP356
	GOTO        L_SPI_Ethernet_UserTCP357
L_SPI_Ethernet_UserTCP315:
L_SPI_Ethernet_UserTCP313:
;SE9M.c,1914 :: 		httpCounter++ ;                             // one more request done
	INFSNZ      _httpCounter+0, 1 
	INCF        _httpCounter+1, 1 
;SE9M.c,1917 :: 		ZAVRSI:
___SPI_Ethernet_UserTCP_ZAVRSI:
;SE9M.c,1919 :: 		return(len) ;                               // return to the library with the number of bytes to transmit
	MOVF        SPI_Ethernet_UserTCP_len_L0+0, 0 
	MOVWF       R0 
	MOVF        SPI_Ethernet_UserTCP_len_L0+1, 0 
	MOVWF       R1 
;SE9M.c,1920 :: 		}
L_end_SPI_Ethernet_UserTCP:
	RETURN      0
; end of _SPI_Ethernet_UserTCP

_Print_Seg:

;SE9M.c,1923 :: 		char Print_Seg(char segm, char tacka) {
;SE9M.c,1925 :: 		if (segm == 0) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg360
;SE9M.c,1926 :: 		napolje = 0b01111110 | tacka;
	MOVLW       126
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1927 :: 		}
L_Print_Seg360:
;SE9M.c,1928 :: 		if (segm == 1) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg361
;SE9M.c,1929 :: 		napolje = 0b00011000 | tacka;
	MOVLW       24
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1930 :: 		}
L_Print_Seg361:
;SE9M.c,1931 :: 		if (segm == 2) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg362
;SE9M.c,1932 :: 		napolje = 0b10110110 | tacka;
	MOVLW       182
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1933 :: 		}
L_Print_Seg362:
;SE9M.c,1934 :: 		if (segm == 3) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg363
;SE9M.c,1935 :: 		napolje = 0b10111100 | tacka;
	MOVLW       188
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1936 :: 		}
L_Print_Seg363:
;SE9M.c,1937 :: 		if (segm == 4) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg364
;SE9M.c,1938 :: 		napolje = 0b11011000 | tacka;
	MOVLW       216
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1939 :: 		}
L_Print_Seg364:
;SE9M.c,1940 :: 		if (segm == 5) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg365
;SE9M.c,1941 :: 		napolje = 0b11101100 | tacka;
	MOVLW       236
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1942 :: 		}
L_Print_Seg365:
;SE9M.c,1943 :: 		if (segm == 6) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg366
;SE9M.c,1944 :: 		napolje = 0b11101110 | tacka;
	MOVLW       238
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1945 :: 		}
L_Print_Seg366:
;SE9M.c,1946 :: 		if (segm == 7) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg367
;SE9M.c,1947 :: 		napolje = 0b00111000 | tacka;
	MOVLW       56
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1948 :: 		}
L_Print_Seg367:
;SE9M.c,1949 :: 		if (segm == 8) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg368
;SE9M.c,1950 :: 		napolje = 0b11111110 | tacka;
	MOVLW       254
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1951 :: 		}
L_Print_Seg368:
;SE9M.c,1952 :: 		if (segm == 9) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg369
;SE9M.c,1953 :: 		napolje = 0b11111100 | tacka;
	MOVLW       252
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1954 :: 		}
L_Print_Seg369:
;SE9M.c,1956 :: 		if (segm == 10) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg370
;SE9M.c,1957 :: 		napolje = 0b11110010 | tacka;
	MOVLW       242
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1958 :: 		}
L_Print_Seg370:
;SE9M.c,1959 :: 		if (segm == 11) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg371
;SE9M.c,1960 :: 		napolje = 0b01110010 | tacka;
	MOVLW       114
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1961 :: 		}
L_Print_Seg371:
;SE9M.c,1962 :: 		if (segm == 12) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg372
;SE9M.c,1963 :: 		napolje = 0b01111000 | tacka;
	MOVLW       120
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1964 :: 		}
L_Print_Seg372:
;SE9M.c,1965 :: 		if (segm == 13) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg373
;SE9M.c,1966 :: 		napolje = 0b11100110 | tacka;
	MOVLW       230
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1967 :: 		}
L_Print_Seg373:
;SE9M.c,1968 :: 		if (segm == 14) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg374
;SE9M.c,1969 :: 		napolje = 0b00000100 | tacka;
	MOVLW       4
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1970 :: 		}
L_Print_Seg374:
;SE9M.c,1971 :: 		if (segm == 15) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg375
;SE9M.c,1972 :: 		napolje = 0b00000000;
	CLRF        R1 
;SE9M.c,1973 :: 		}
L_Print_Seg375:
;SE9M.c,1974 :: 		if (segm == 16) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg376
;SE9M.c,1975 :: 		napolje = 0b00000001;
	MOVLW       1
	MOVWF       R1 
;SE9M.c,1976 :: 		}
L_Print_Seg376:
;SE9M.c,1977 :: 		if (segm == 17) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg377
;SE9M.c,1978 :: 		napolje = 0b10000000;
	MOVLW       128
	MOVWF       R1 
;SE9M.c,1979 :: 		}
L_Print_Seg377:
;SE9M.c,1981 :: 		return napolje;
	MOVF        R1, 0 
	MOVWF       R0 
;SE9M.c,1982 :: 		}
L_end_Print_Seg:
	RETURN      0
; end of _Print_Seg

_PRINT_S:

;SE9M.c,1984 :: 		void PRINT_S(char ledovi) {
;SE9M.c,1986 :: 		pom = 0;
	CLRF        R3 
;SE9M.c,1987 :: 		for ( ir = 0; ir < 8; ir++ ) {
	CLRF        R4 
L_PRINT_S378:
	MOVLW       8
	SUBWF       R4, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_PRINT_S379
;SE9M.c,1988 :: 		pom1 = (ledovi << pom) & 0b10000000;
	MOVF        R3, 0 
	MOVWF       R1 
	MOVF        FARG_PRINT_S_ledovi+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__PRINT_S616:
	BZ          L__PRINT_S617
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__PRINT_S616
L__PRINT_S617:
	MOVLW       128
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       R2 
;SE9M.c,1989 :: 		if (pom1 == 0b10000000) {
	MOVF        R1, 0 
	XORLW       128
	BTFSS       STATUS+0, 2 
	GOTO        L_PRINT_S381
;SE9M.c,1990 :: 		SV_DATA = 1;
	BSF         RA1_bit+0, BitPos(RA1_bit+0) 
;SE9M.c,1991 :: 		}
L_PRINT_S381:
;SE9M.c,1992 :: 		if (pom1 == 0b00000000) {
	MOVF        R2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_PRINT_S382
;SE9M.c,1993 :: 		SV_DATA = 0;
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;SE9M.c,1994 :: 		}
L_PRINT_S382:
;SE9M.c,1995 :: 		asm nop;
	NOP
;SE9M.c,1996 :: 		asm nop;
	NOP
;SE9M.c,1997 :: 		asm nop;
	NOP
;SE9M.c,1998 :: 		SV_CLK = 0;
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
;SE9M.c,1999 :: 		asm nop;
	NOP
;SE9M.c,2000 :: 		asm nop;
	NOP
;SE9M.c,2001 :: 		asm nop;
	NOP
;SE9M.c,2002 :: 		SV_CLK = 1;
	BSF         RA2_bit+0, BitPos(RA2_bit+0) 
;SE9M.c,2003 :: 		pom++;
	INCF        R3, 1 
;SE9M.c,1987 :: 		for ( ir = 0; ir < 8; ir++ ) {
	INCF        R4, 1 
;SE9M.c,2004 :: 		}
	GOTO        L_PRINT_S378
L_PRINT_S379:
;SE9M.c,2005 :: 		}
L_end_PRINT_S:
	RETURN      0
; end of _PRINT_S

_Display_Time:

;SE9M.c,2007 :: 		void Display_Time() {
;SE9M.c,2009 :: 		sec1 = sekundi / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _sekundi+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _sec1+0 
;SE9M.c,2010 :: 		sec2 = sekundi - sec1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _sekundi+0, 0 
	MOVWF       _sec2+0 
;SE9M.c,2011 :: 		min1 = minuti / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _minuti+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _min1+0 
;SE9M.c,2012 :: 		min2 = minuti - min1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _minuti+0, 0 
	MOVWF       _min2+0 
;SE9M.c,2013 :: 		hr1 = sati / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _sati+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _hr1+0 
;SE9M.c,2014 :: 		hr2 = sati - hr1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _sati+0, 0 
	MOVWF       _hr2+0 
;SE9M.c,2015 :: 		day1 = dan / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _dan+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _day1+0 
;SE9M.c,2016 :: 		day2 = dan - day1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _dan+0, 0 
	MOVWF       _day2+0 
;SE9M.c,2017 :: 		mn1 = mesec / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _mesec+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _mn1+0 
;SE9M.c,2018 :: 		mn2 = mesec - mn1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _mesec+0, 0 
	MOVWF       _mn2+0 
;SE9M.c,2019 :: 		year1 = fingodina / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _fingodina+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _year1+0 
;SE9M.c,2020 :: 		year2 = fingodina - year1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _fingodina+0, 0 
	MOVWF       _year2+0 
;SE9M.c,2022 :: 		if (disp_mode == 1) {
	MOVF        _disp_mode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Display_Time383
;SE9M.c,2023 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2024 :: 		asm nop;
	NOP
;SE9M.c,2025 :: 		asm nop;
	NOP
;SE9M.c,2026 :: 		asm nop;
	NOP
;SE9M.c,2027 :: 		PRINT_S(Print_Seg(sec2, 0));
	MOVF        _sec2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2028 :: 		PRINT_S(Print_Seg(sec1, 0));
	MOVF        _sec1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2029 :: 		PRINT_S(Print_Seg(min2, 0));
	MOVF        _min2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2030 :: 		PRINT_S(Print_Seg(min1, 0));
	MOVF        _min1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2031 :: 		PRINT_S(Print_Seg(hr2, tacka1));
	MOVF        _hr2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka1+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2032 :: 		PRINT_S(Print_Seg(hr1, tacka2));
	MOVF        _hr1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka2+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2033 :: 		asm nop;
	NOP
;SE9M.c,2034 :: 		asm nop;
	NOP
;SE9M.c,2035 :: 		asm nop;
	NOP
;SE9M.c,2036 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2037 :: 		}
L_Display_Time383:
;SE9M.c,2038 :: 		if (disp_mode == 2) {
	MOVF        _disp_mode+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Display_Time384
;SE9M.c,2039 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2040 :: 		asm nop;
	NOP
;SE9M.c,2041 :: 		asm nop;
	NOP
;SE9M.c,2042 :: 		asm nop;
	NOP
;SE9M.c,2043 :: 		PRINT_S(Print_Seg(year2, 0));
	MOVF        _year2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2044 :: 		PRINT_S(Print_Seg(year1, 0));
	MOVF        _year1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2045 :: 		PRINT_S(Print_Seg(mn2, 0));
	MOVF        _mn2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2046 :: 		PRINT_S(Print_Seg(mn1, 0));
	MOVF        _mn1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2047 :: 		PRINT_S(Print_Seg(day2, tacka1));
	MOVF        _day2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka1+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2048 :: 		PRINT_S(Print_Seg(day1, tacka2));
	MOVF        _day1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka2+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2049 :: 		asm nop;
	NOP
;SE9M.c,2050 :: 		asm nop;
	NOP
;SE9M.c,2051 :: 		asm nop;
	NOP
;SE9M.c,2052 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2053 :: 		}
L_Display_Time384:
;SE9M.c,2055 :: 		}
L_end_Display_Time:
	RETURN      0
; end of _Display_Time

_Print_IP:

;SE9M.c,2058 :: 		void Print_IP() {
;SE9M.c,2062 :: 		cif1 =  ipAddr[3] / 100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _ipAddr+3, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       Print_IP_cif1_L0+0 
;SE9M.c,2063 :: 		cif2 = (ipAddr[3] - cif1 * 100) / 10;
	MOVLW       100
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	SUBWF       _ipAddr+3, 0 
	MOVWF       FLOC__Print_IP+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Print_IP+1 
	MOVLW       0
	SUBFWB      FLOC__Print_IP+1, 1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__Print_IP+0, 0 
	MOVWF       R0 
	MOVF        FLOC__Print_IP+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       Print_IP_cif2_L0+0 
;SE9M.c,2064 :: 		cif3 =  ipAddr[3] - cif1 * 100 - cif2 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       FLOC__Print_IP+0, 0 
	MOVWF       Print_IP_cif3_L0+0 
;SE9M.c,2065 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2066 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2067 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2068 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2069 :: 		PRINT_S(Print_Seg(cif3, 0));
	MOVF        Print_IP_cif3_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2070 :: 		PRINT_S(Print_Seg(cif2, 0));
	MOVF        Print_IP_cif2_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2071 :: 		PRINT_S(Print_Seg(cif1, 0));
	MOVF        Print_IP_cif1_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2072 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2073 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2074 :: 		delay_ms(2000);
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_Print_IP385:
	DECFSZ      R13, 1, 1
	BRA         L_Print_IP385
	DECFSZ      R12, 1, 1
	BRA         L_Print_IP385
	DECFSZ      R11, 1, 1
	BRA         L_Print_IP385
	NOP
;SE9M.c,2075 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2076 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2077 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2078 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2079 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2080 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2081 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2082 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2083 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2084 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2085 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_IP386:
	DECFSZ      R13, 1, 1
	BRA         L_Print_IP386
	DECFSZ      R12, 1, 1
	BRA         L_Print_IP386
	DECFSZ      R11, 1, 1
	BRA         L_Print_IP386
	NOP
;SE9M.c,2086 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2088 :: 		}
L_end_Print_IP:
	RETURN      0
; end of _Print_IP

_SPI_Ethernet_UserUDP:

;SE9M.c,2093 :: 		unsigned int  SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags)
;SE9M.c,2103 :: 		if (destPort == 10001) {
	MOVF        FARG_SPI_Ethernet_UserUDP_destPort+1, 0 
	XORLW       39
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP621
	MOVLW       17
	XORWF       FARG_SPI_Ethernet_UserUDP_destPort+0, 0 
L__SPI_Ethernet_UserUDP621:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP387
;SE9M.c,2105 :: 		if (reqLength == 9) {
	MOVLW       0
	XORWF       FARG_SPI_Ethernet_UserUDP_reqLength+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP622
	MOVLW       9
	XORWF       FARG_SPI_Ethernet_UserUDP_reqLength+0, 0 
L__SPI_Ethernet_UserUDP622:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP388
;SE9M.c,2106 :: 		for (i = 0 ; i < 9 ; i++) {
	CLRF        SPI_Ethernet_UserUDP_i_L0+0 
L_SPI_Ethernet_UserUDP389:
	MOVLW       9
	SUBWF       SPI_Ethernet_UserUDP_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserUDP390
;SE9M.c,2107 :: 		broadcmd[i] = SPI_Ethernet_getByte() ;
	MOVLW       SPI_Ethernet_UserUDP_broadcmd_L0+0
	MOVWF       FLOC__SPI_Ethernet_UserUDP+0 
	MOVLW       hi_addr(SPI_Ethernet_UserUDP_broadcmd_L0+0)
	MOVWF       FLOC__SPI_Ethernet_UserUDP+1 
	MOVF        SPI_Ethernet_UserUDP_i_L0+0, 0 
	ADDWF       FLOC__SPI_Ethernet_UserUDP+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__SPI_Ethernet_UserUDP+1, 1 
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVFF       FLOC__SPI_Ethernet_UserUDP+0, FSR1
	MOVFF       FLOC__SPI_Ethernet_UserUDP+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,2106 :: 		for (i = 0 ; i < 9 ; i++) {
	INCF        SPI_Ethernet_UserUDP_i_L0+0, 1 
;SE9M.c,2108 :: 		}
	GOTO        L_SPI_Ethernet_UserUDP389
L_SPI_Ethernet_UserUDP390:
;SE9M.c,2109 :: 		if ( (broadcmd[0] == 'I') && (broadcmd[1] == 'D') && (broadcmd[2] == 'E') && (broadcmd[3] == 'N') && (broadcmd[4] == 'T') && (broadcmd[5] == 'I') && (broadcmd[6] == 'F') && (broadcmd[7] == 'Y') && (broadcmd[8] == '!') ) {
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+0, 0 
	XORLW       73
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP394
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+1, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP394
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+2, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP394
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+3, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP394
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+4, 0 
	XORLW       84
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP394
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+5, 0 
	XORLW       73
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP394
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+6, 0 
	XORLW       70
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP394
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+7, 0 
	XORLW       89
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP394
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+8, 0 
	XORLW       33
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP394
L__SPI_Ethernet_UserUDP573:
;SE9M.c,2111 :: 		Print_IP();
	CALL        _Print_IP+0, 0
;SE9M.c,2113 :: 		}
L_SPI_Ethernet_UserUDP394:
;SE9M.c,2114 :: 		}
L_SPI_Ethernet_UserUDP388:
;SE9M.c,2115 :: 		}
L_SPI_Ethernet_UserUDP387:
;SE9M.c,2118 :: 		if(destPort == 123)             // check SNTP port number
	MOVLW       0
	XORWF       FARG_SPI_Ethernet_UserUDP_destPort+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP623
	MOVLW       123
	XORWF       FARG_SPI_Ethernet_UserUDP_destPort+0, 0 
L__SPI_Ethernet_UserUDP623:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP395
;SE9M.c,2120 :: 		if (remoteHost[3] == 10){
	MOVLW       3
	ADDWF       FARG_SPI_Ethernet_UserUDP_remoteHost+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SPI_Ethernet_UserUDP_remoteHost+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP396
;SE9M.c,2121 :: 		return (0);
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserUDP
;SE9M.c,2122 :: 		}
L_SPI_Ethernet_UserUDP396:
;SE9M.c,2124 :: 		else if (reqLength == 48) {
	MOVLW       0
	XORWF       FARG_SPI_Ethernet_UserUDP_reqLength+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP624
	MOVLW       48
	XORWF       FARG_SPI_Ethernet_UserUDP_reqLength+0, 0 
L__SPI_Ethernet_UserUDP624:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP398
;SE9M.c,2125 :: 		epoch_fract = presTmr * 274877.906944 ;
	MOVF        _presTmr+0, 0 
	MOVWF       R0 
	MOVF        _presTmr+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       189
	MOVWF       R4 
	MOVLW       55
	MOVWF       R5 
	MOVLW       6
	MOVWF       R6 
	MOVLW       145
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2longint+0, 0
	MOVF        R0, 0 
	MOVWF       _epoch_fract+0 
	MOVF        R1, 0 
	MOVWF       _epoch_fract+1 
	MOVF        R2, 0 
	MOVWF       _epoch_fract+2 
	MOVF        R3, 0 
	MOVWF       _epoch_fract+3 
;SE9M.c,2126 :: 		t_dst = epoch;
	MOVF        _epoch+0, 0 
	MOVWF       _t_dst+0 
	MOVF        _epoch+1, 0 
	MOVWF       _t_dst+1 
	MOVF        _epoch+2, 0 
	MOVWF       _t_dst+2 
	MOVF        _epoch+3, 0 
	MOVWF       _t_dst+3 
;SE9M.c,2127 :: 		t_dst_fract = epoch_fract ;
	MOVF        R0, 0 
	MOVWF       _t_dst_fract+0 
	MOVF        R1, 0 
	MOVWF       _t_dst_fract+1 
	MOVF        R2, 0 
	MOVWF       _t_dst_fract+2 
	MOVF        R3, 0 
	MOVWF       _t_dst_fract+3 
;SE9M.c,2128 :: 		serverFlags = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _serverFlags+0 
;SE9M.c,2129 :: 		serverStratum = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _serverStratum+0 
;SE9M.c,2130 :: 		poll = SPI_Ethernet_getByte() ;        // skip poll
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _poll+0 
;SE9M.c,2131 :: 		serverPrecision = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _serverPrecision+0 
;SE9M.c,2133 :: 		for(i = 0 ; i < 20 ; i++){
	CLRF        SPI_Ethernet_UserUDP_i_L0+0 
L_SPI_Ethernet_UserUDP399:
	MOVLW       20
	SUBWF       SPI_Ethernet_UserUDP_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserUDP400
;SE9M.c,2134 :: 		SPI_Ethernet_getByte() ;// skip all unused fileds
	CALL        _SPI_Ethernet_getByte+0, 0
;SE9M.c,2133 :: 		for(i = 0 ; i < 20 ; i++){
	INCF        SPI_Ethernet_UserUDP_i_L0+0, 1 
;SE9M.c,2135 :: 		}
	GOTO        L_SPI_Ethernet_UserUDP399
L_SPI_Ethernet_UserUDP400:
;SE9M.c,2137 :: 		Highest(t_org) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org+3 
;SE9M.c,2138 :: 		Higher(t_org) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org+2 
;SE9M.c,2139 :: 		Hi(t_org) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org+1 
;SE9M.c,2140 :: 		Lo(t_org) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org+0 
;SE9M.c,2141 :: 		Highest(t_org_fract) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org_fract+3 
;SE9M.c,2142 :: 		Higher(t_org_fract) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org_fract+2 
;SE9M.c,2143 :: 		Hi(t_org_fract) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org_fract+1 
;SE9M.c,2144 :: 		Lo(t_org_fract) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org_fract+0 
;SE9M.c,2146 :: 		Highest(t_rec) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec+3 
;SE9M.c,2147 :: 		Higher(t_rec) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec+2 
;SE9M.c,2148 :: 		Hi(t_rec) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec+1 
;SE9M.c,2149 :: 		Lo(t_rec) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec+0 
;SE9M.c,2150 :: 		Highest(t_rec_fract) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec_fract+3 
;SE9M.c,2151 :: 		Higher(t_rec_fract) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec_fract+2 
;SE9M.c,2152 :: 		Hi(t_rec_fract) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec_fract+1 
;SE9M.c,2153 :: 		Lo(t_rec_fract) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec_fract+0 
;SE9M.c,2155 :: 		Highest(t_xmt) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt+3 
;SE9M.c,2156 :: 		Higher(t_xmt) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt+2 
;SE9M.c,2157 :: 		Hi(t_xmt) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt+1 
;SE9M.c,2158 :: 		Lo(t_xmt) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt+0 
;SE9M.c,2159 :: 		Highest(t_xmt_fract) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt_fract+3 
;SE9M.c,2160 :: 		Higher(t_xmt_fract) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt_fract+2 
;SE9M.c,2161 :: 		Hi(t_xmt_fract) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt_fract+1 
;SE9M.c,2162 :: 		Lo(t_xmt_fract) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt_fract+0 
;SE9M.c,2165 :: 		LongtoStr(t_org,rez);
	MOVF        _t_org+0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        _t_org+1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        _t_org+2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        _t_org+3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       _rez+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;SE9M.c,2166 :: 		Time_EpochtoDate(t_org + 3600 *tmzn , &t1_s);
	MOVLW       16
	MOVWF       R0 
	MOVLW       14
	MOVWF       R1 
	MOVF        _tmzn+0, 0 
	MOVWF       R4 
	MOVLW       0
	BTFSC       _tmzn+0, 7 
	MOVLW       255
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       _t_org+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        R1, 0 
	ADDWFC      _t_org+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _t_org+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _t_org+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVLW       _t1_s+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(_t1_s+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,2167 :: 		ts2str(rez,&t1_s,TS2STR_TIME);
	MOVLW       _rez+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _t1_s+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_t1_s+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       2
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,2168 :: 		strcat (rez, ".");
	MOVLW       _rez+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr238_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr238_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,2169 :: 		LongtoStr(t_org_fract,fract);
	MOVF        _t_org_fract+0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        _t_org_fract+1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        _t_org_fract+2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        _t_org_fract+3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       _fract+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(_fract+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;SE9M.c,2170 :: 		strcat(rez,fract);
	MOVLW       _rez+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _fract+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_fract+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,2171 :: 		UART_Write_Text("Ovo je t1 sa servera:");
	MOVLW       ?lstr239_SE9M+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr239_SE9M+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,2172 :: 		UART_Write_Text(rez);
	MOVLW       _rez+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,2173 :: 		UART_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,2174 :: 		UART_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,2176 :: 		t_rec = t_rec - 2208988800;
	MOVF        _t_rec+0, 0 
	MOVWF       R0 
	MOVF        _t_rec+1, 0 
	MOVWF       R1 
	MOVF        _t_rec+2, 0 
	MOVWF       R2 
	MOVF        _t_rec+3, 0 
	MOVWF       R3 
	MOVLW       128
	SUBWF       R0, 1 
	MOVLW       126
	SUBWFB      R1, 1 
	MOVLW       170
	SUBWFB      R2, 1 
	MOVLW       131
	SUBWFB      R3, 1 
	MOVF        R0, 0 
	MOVWF       _t_rec+0 
	MOVF        R1, 0 
	MOVWF       _t_rec+1 
	MOVF        R2, 0 
	MOVWF       _t_rec+2 
	MOVF        R3, 0 
	MOVWF       _t_rec+3 
;SE9M.c,2177 :: 		LongtoStr(t_rec,rez);
	MOVF        R0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        R2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        R3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       _rez+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;SE9M.c,2178 :: 		strcat (rez, ".");
	MOVLW       _rez+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr240_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr240_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,2179 :: 		LongtoStr(t_rec_fract,fract);
	MOVF        _t_rec_fract+0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        _t_rec_fract+1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        _t_rec_fract+2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        _t_rec_fract+3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       _fract+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(_fract+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;SE9M.c,2180 :: 		strcat(rez,fract);
	MOVLW       _rez+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _fract+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_fract+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,2181 :: 		UART_Write_Text("Ovo je t2:");
	MOVLW       ?lstr241_SE9M+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr241_SE9M+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,2182 :: 		UART_Write_Text(rez);
	MOVLW       _rez+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,2183 :: 		UART_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,2184 :: 		UART_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,2186 :: 		t_xmt =  t_xmt - 2208988800;
	MOVF        _t_xmt+0, 0 
	MOVWF       R0 
	MOVF        _t_xmt+1, 0 
	MOVWF       R1 
	MOVF        _t_xmt+2, 0 
	MOVWF       R2 
	MOVF        _t_xmt+3, 0 
	MOVWF       R3 
	MOVLW       128
	SUBWF       R0, 1 
	MOVLW       126
	SUBWFB      R1, 1 
	MOVLW       170
	SUBWFB      R2, 1 
	MOVLW       131
	SUBWFB      R3, 1 
	MOVF        R0, 0 
	MOVWF       _t_xmt+0 
	MOVF        R1, 0 
	MOVWF       _t_xmt+1 
	MOVF        R2, 0 
	MOVWF       _t_xmt+2 
	MOVF        R3, 0 
	MOVWF       _t_xmt+3 
;SE9M.c,2187 :: 		LongtoStr(t_xmt,rez);
	MOVF        R0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        R2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        R3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       _rez+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;SE9M.c,2188 :: 		strcat (rez, ".");
	MOVLW       _rez+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr242_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr242_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,2189 :: 		LongtoStr(t_xmt_fract,fract);
	MOVF        _t_xmt_fract+0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        _t_xmt_fract+1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        _t_xmt_fract+2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        _t_xmt_fract+3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       _fract+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(_fract+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;SE9M.c,2190 :: 		strcat(rez,fract);
	MOVLW       _rez+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _fract+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_fract+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,2191 :: 		UART_Write_Text("Ovo je t3:");
	MOVLW       ?lstr243_SE9M+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr243_SE9M+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,2192 :: 		UART_Write_Text(rez);
	MOVLW       _rez+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,2193 :: 		UART_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,2194 :: 		UART_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,2196 :: 		LongtoStr(t_dst,rez);
	MOVF        _t_dst+0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        _t_dst+1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        _t_dst+2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        _t_dst+3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       _rez+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;SE9M.c,2197 :: 		strcat (rez, ".");
	MOVLW       _rez+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr244_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr244_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,2198 :: 		LongtoStr(t_dst_fract,fract);
	MOVF        _t_dst_fract+0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        _t_dst_fract+1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        _t_dst_fract+2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        _t_dst_fract+3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       _fract+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(_fract+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;SE9M.c,2199 :: 		strcat(rez,fract);
	MOVLW       _rez+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _fract+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_fract+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,2200 :: 		UART_Write_Text("Ovo je t4 na klijentu:");
	MOVLW       ?lstr245_SE9M+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr245_SE9M+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,2201 :: 		UART_Write_Text(rez);
	MOVLW       _rez+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,2202 :: 		UART_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,2203 :: 		UART_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,2206 :: 		if (t_dst == t_org){
	MOVF        _t_dst+3, 0 
	XORWF       _t_org+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP625
	MOVF        _t_dst+2, 0 
	XORWF       _t_org+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP625
	MOVF        _t_dst+1, 0 
	XORWF       _t_org+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP625
	MOVF        _t_dst+0, 0 
	XORWF       _t_org+0, 0 
L__SPI_Ethernet_UserUDP625:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP402
;SE9M.c,2207 :: 		delta = ( t_dst_fract - t_org_fract) - (t_xmt_fract - t_rec_fract );
	MOVF        _t_dst_fract+0, 0 
	MOVWF       R8 
	MOVF        _t_dst_fract+1, 0 
	MOVWF       R9 
	MOVF        _t_dst_fract+2, 0 
	MOVWF       R10 
	MOVF        _t_dst_fract+3, 0 
	MOVWF       R11 
	MOVF        _t_org_fract+0, 0 
	SUBWF       R8, 1 
	MOVF        _t_org_fract+1, 0 
	SUBWFB      R9, 1 
	MOVF        _t_org_fract+2, 0 
	SUBWFB      R10, 1 
	MOVF        _t_org_fract+3, 0 
	SUBWFB      R11, 1 
	MOVF        _t_xmt_fract+0, 0 
	MOVWF       R4 
	MOVF        _t_xmt_fract+1, 0 
	MOVWF       R5 
	MOVF        _t_xmt_fract+2, 0 
	MOVWF       R6 
	MOVF        _t_xmt_fract+3, 0 
	MOVWF       R7 
	MOVF        _t_rec_fract+0, 0 
	SUBWF       R4, 1 
	MOVF        _t_rec_fract+1, 0 
	SUBWFB      R5, 1 
	MOVF        _t_rec_fract+2, 0 
	SUBWFB      R6, 1 
	MOVF        _t_rec_fract+3, 0 
	SUBWFB      R7, 1 
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R4, 0 
	SUBWF       R0, 1 
	MOVF        R5, 0 
	SUBWFB      R1, 1 
	MOVF        R6, 0 
	SUBWFB      R2, 1 
	MOVF        R7, 0 
	SUBWFB      R3, 1 
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserUDP_delta_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserUDP_delta_L0+1 
	MOVF        R2, 0 
	MOVWF       SPI_Ethernet_UserUDP_delta_L0+2 
	MOVF        R3, 0 
	MOVWF       SPI_Ethernet_UserUDP_delta_L0+3 
;SE9M.c,2208 :: 		LongtoStr(delta, rez);
	MOVF        R0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        R2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        R3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       _rez+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;SE9M.c,2209 :: 		UART_Write_Text("Ovo je t4 = t1:");
	MOVLW       ?lstr246_SE9M+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr246_SE9M+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,2210 :: 		UART_Write_Text(rez);
	MOVLW       _rez+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,2211 :: 		UART_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,2212 :: 		UART_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,2213 :: 		}
	GOTO        L_SPI_Ethernet_UserUDP403
L_SPI_Ethernet_UserUDP402:
;SE9M.c,2214 :: 		else if (t_dst != t_org){
	MOVF        _t_dst+3, 0 
	XORWF       _t_org+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP626
	MOVF        _t_dst+2, 0 
	XORWF       _t_org+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP626
	MOVF        _t_dst+1, 0 
	XORWF       _t_org+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP626
	MOVF        _t_dst+0, 0 
	XORWF       _t_org+0, 0 
L__SPI_Ethernet_UserUDP626:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP404
;SE9M.c,2215 :: 		delta = (4294967295 -  t_org_fract + t_dst_fract) - (t_xmt_fract - t_rec_fract );
	MOVLW       255
	MOVWF       R0 
	MOVLW       255
	MOVWF       R1 
	MOVLW       255
	MOVWF       R2 
	MOVLW       255
	MOVWF       R3 
	MOVF        _t_org_fract+0, 0 
	SUBWF       R0, 1 
	MOVF        _t_org_fract+1, 0 
	SUBWFB      R1, 1 
	MOVF        _t_org_fract+2, 0 
	SUBWFB      R2, 1 
	MOVF        _t_org_fract+3, 0 
	SUBWFB      R3, 1 
	MOVF        _t_dst_fract+0, 0 
	ADDWF       R0, 0 
	MOVWF       R8 
	MOVF        _t_dst_fract+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R9 
	MOVF        _t_dst_fract+2, 0 
	ADDWFC      R2, 0 
	MOVWF       R10 
	MOVF        _t_dst_fract+3, 0 
	ADDWFC      R3, 0 
	MOVWF       R11 
	MOVF        _t_xmt_fract+0, 0 
	MOVWF       R4 
	MOVF        _t_xmt_fract+1, 0 
	MOVWF       R5 
	MOVF        _t_xmt_fract+2, 0 
	MOVWF       R6 
	MOVF        _t_xmt_fract+3, 0 
	MOVWF       R7 
	MOVF        _t_rec_fract+0, 0 
	SUBWF       R4, 1 
	MOVF        _t_rec_fract+1, 0 
	SUBWFB      R5, 1 
	MOVF        _t_rec_fract+2, 0 
	SUBWFB      R6, 1 
	MOVF        _t_rec_fract+3, 0 
	SUBWFB      R7, 1 
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R4, 0 
	SUBWF       R0, 1 
	MOVF        R5, 0 
	SUBWFB      R1, 1 
	MOVF        R6, 0 
	SUBWFB      R2, 1 
	MOVF        R7, 0 
	SUBWFB      R3, 1 
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserUDP_delta_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserUDP_delta_L0+1 
	MOVF        R2, 0 
	MOVWF       SPI_Ethernet_UserUDP_delta_L0+2 
	MOVF        R3, 0 
	MOVWF       SPI_Ethernet_UserUDP_delta_L0+3 
;SE9M.c,2216 :: 		LongtoStr(delta, rez);
	MOVF        R0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        R2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        R3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       _rez+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;SE9M.c,2217 :: 		UART_Write_Text("Ovo NIJE! t4 = t1:");
	MOVLW       ?lstr247_SE9M+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr247_SE9M+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,2218 :: 		UART_Write_Text(rez);
	MOVLW       _rez+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(_rez+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;SE9M.c,2219 :: 		UART_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,2220 :: 		UART_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART_Write__data+0 
	CALL        _UART_Write+0, 0
;SE9M.c,2221 :: 		}
L_SPI_Ethernet_UserUDP404:
L_SPI_Ethernet_UserUDP403:
;SE9M.c,2223 :: 		if ( (presTmr + delta /(2 * 274877.906944))  > 15625 ){
	MOVF        SPI_Ethernet_UserUDP_delta_L0+0, 0 
	MOVWF       R0 
	MOVF        SPI_Ethernet_UserUDP_delta_L0+1, 0 
	MOVWF       R1 
	MOVF        SPI_Ethernet_UserUDP_delta_L0+2, 0 
	MOVWF       R2 
	MOVF        SPI_Ethernet_UserUDP_delta_L0+3, 0 
	MOVWF       R3 
	CALL        _longint2double+0, 0
	MOVLW       189
	MOVWF       R4 
	MOVLW       55
	MOVWF       R5 
	MOVLW       6
	MOVWF       R6 
	MOVLW       146
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+0 
	MOVF        R1, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+1 
	MOVF        R2, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+2 
	MOVF        R3, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+3 
	MOVF        _presTmr+0, 0 
	MOVWF       R0 
	MOVF        _presTmr+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        FLOC__SPI_Ethernet_UserUDP+0, 0 
	MOVWF       R4 
	MOVF        FLOC__SPI_Ethernet_UserUDP+1, 0 
	MOVWF       R5 
	MOVF        FLOC__SPI_Ethernet_UserUDP+2, 0 
	MOVWF       R6 
	MOVF        FLOC__SPI_Ethernet_UserUDP+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       36
	MOVWF       R1 
	MOVLW       116
	MOVWF       R2 
	MOVLW       140
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP405
;SE9M.c,2224 :: 		epoch  = t_xmt + 1;
	MOVLW       1
	ADDWF       _t_xmt+0, 0 
	MOVWF       _epoch+0 
	MOVLW       0
	ADDWFC      _t_xmt+1, 0 
	MOVWF       _epoch+1 
	MOVLW       0
	ADDWFC      _t_xmt+2, 0 
	MOVWF       _epoch+2 
	MOVLW       0
	ADDWFC      _t_xmt+3, 0 
	MOVWF       _epoch+3 
;SE9M.c,2225 :: 		presTmr = (presTmr + delta / (2 * 274877.906944)) - 15625;
	MOVF        SPI_Ethernet_UserUDP_delta_L0+0, 0 
	MOVWF       R0 
	MOVF        SPI_Ethernet_UserUDP_delta_L0+1, 0 
	MOVWF       R1 
	MOVF        SPI_Ethernet_UserUDP_delta_L0+2, 0 
	MOVWF       R2 
	MOVF        SPI_Ethernet_UserUDP_delta_L0+3, 0 
	MOVWF       R3 
	CALL        _longint2double+0, 0
	MOVLW       189
	MOVWF       R4 
	MOVLW       55
	MOVWF       R5 
	MOVLW       6
	MOVWF       R6 
	MOVLW       146
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+0 
	MOVF        R1, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+1 
	MOVF        R2, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+2 
	MOVF        R3, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+3 
	MOVF        _presTmr+0, 0 
	MOVWF       R0 
	MOVF        _presTmr+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        FLOC__SPI_Ethernet_UserUDP+0, 0 
	MOVWF       R4 
	MOVF        FLOC__SPI_Ethernet_UserUDP+1, 0 
	MOVWF       R5 
	MOVF        FLOC__SPI_Ethernet_UserUDP+2, 0 
	MOVWF       R6 
	MOVF        FLOC__SPI_Ethernet_UserUDP+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       36
	MOVWF       R5 
	MOVLW       116
	MOVWF       R6 
	MOVLW       140
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       _presTmr+0 
	MOVF        R1, 0 
	MOVWF       _presTmr+1 
;SE9M.c,2226 :: 		epoch_fract = presTmr * 274877.906944 ;
	CALL        _word2double+0, 0
	MOVLW       189
	MOVWF       R4 
	MOVLW       55
	MOVWF       R5 
	MOVLW       6
	MOVWF       R6 
	MOVLW       145
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2longint+0, 0
	MOVF        R0, 0 
	MOVWF       _epoch_fract+0 
	MOVF        R1, 0 
	MOVWF       _epoch_fract+1 
	MOVF        R2, 0 
	MOVWF       _epoch_fract+2 
	MOVF        R3, 0 
	MOVWF       _epoch_fract+3 
;SE9M.c,2227 :: 		}
	GOTO        L_SPI_Ethernet_UserUDP406
L_SPI_Ethernet_UserUDP405:
;SE9M.c,2229 :: 		epoch = t_xmt;
	MOVF        _t_xmt+0, 0 
	MOVWF       _epoch+0 
	MOVF        _t_xmt+1, 0 
	MOVWF       _epoch+1 
	MOVF        _t_xmt+2, 0 
	MOVWF       _epoch+2 
	MOVF        _t_xmt+3, 0 
	MOVWF       _epoch+3 
;SE9M.c,2230 :: 		epoch_fract += delta/2;
	MOVF        SPI_Ethernet_UserUDP_delta_L0+0, 0 
	MOVWF       R0 
	MOVF        SPI_Ethernet_UserUDP_delta_L0+1, 0 
	MOVWF       R1 
	MOVF        SPI_Ethernet_UserUDP_delta_L0+2, 0 
	MOVWF       R2 
	MOVF        SPI_Ethernet_UserUDP_delta_L0+3, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	BTFSS       R3, 7 
	GOTO        L__SPI_Ethernet_UserUDP627
	BTFSS       STATUS+0, 0 
	GOTO        L__SPI_Ethernet_UserUDP627
	MOVLW       1
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
L__SPI_Ethernet_UserUDP627:
	MOVF        R0, 0 
	ADDWF       _epoch_fract+0, 1 
	MOVF        R1, 0 
	ADDWFC      _epoch_fract+1, 1 
	MOVF        R2, 0 
	ADDWFC      _epoch_fract+2, 1 
	MOVF        R3, 0 
	ADDWFC      _epoch_fract+3, 1 
;SE9M.c,2231 :: 		}
L_SPI_Ethernet_UserUDP406:
;SE9M.c,2233 :: 		lastSync = epoch;
	MOVF        _epoch+0, 0 
	MOVWF       _lastSync+0 
	MOVF        _epoch+1, 0 
	MOVWF       _lastSync+1 
	MOVF        _epoch+2, 0 
	MOVWF       _lastSync+2 
	MOVF        _epoch+3, 0 
	MOVWF       _lastSync+3 
;SE9M.c,2236 :: 		marquee = bufInfo ;
	MOVLW       _bufInfo+0
	MOVWF       _marquee+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       _marquee+1 
;SE9M.c,2238 :: 		notime = 0;
	CLRF        _notime+0 
;SE9M.c,2239 :: 		notime_ovf = 0;
	CLRF        _notime_ovf+0 
;SE9M.c,2241 :: 		Time_epochToDate(epoch + tmzn * 3600, &ts) ;
	MOVF        _tmzn+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _tmzn+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       16
	MOVWF       R4 
	MOVLW       14
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       _epoch+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        R1, 0 
	ADDWFC      _epoch+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _epoch+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _epoch+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVLW       _ts+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,2243 :: 		presTmr = 0;
	CLRF        _presTmr+0 
	CLRF        _presTmr+1 
;SE9M.c,2244 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,2245 :: 		if (lcdEvent) {
	MOVF        _lcdEvent+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP407
;SE9M.c,2246 :: 		mkLCDLine(1, conf.dhcpen) ; // update lcd: first row
	MOVLW       1
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+0, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2247 :: 		mkLCDLine(2, conf.lcdL2) ; // update lcd: second row
	MOVLW       2
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+1, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2248 :: 		lcdEvent = 0 ;             // clear lcd update flag
	CLRF        _lcdEvent+0 
;SE9M.c,2249 :: 		marquee++ ;                // set marquee pointer
	INFSNZ      _marquee+0, 1 
	INCF        _marquee+1, 1 
;SE9M.c,2250 :: 		}
L_SPI_Ethernet_UserUDP407:
;SE9M.c,2252 :: 		presTmr = 0;
	CLRF        _presTmr+0 
	CLRF        _presTmr+1 
;SE9M.c,2253 :: 		lcdTmr = 0;
	CLRF        _lcdTmr+0 
	CLRF        _lcdTmr+1 
;SE9M.c,2254 :: 		Display_Time();
	CALL        _Display_Time+0, 0
;SE9M.c,2255 :: 		} else {
	GOTO        L_SPI_Ethernet_UserUDP408
L_SPI_Ethernet_UserUDP398:
;SE9M.c,2256 :: 		return(0) ;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserUDP
;SE9M.c,2257 :: 		}
L_SPI_Ethernet_UserUDP408:
;SE9M.c,2258 :: 		} else {
	GOTO        L_SPI_Ethernet_UserUDP409
L_SPI_Ethernet_UserUDP395:
;SE9M.c,2259 :: 		return(0) ;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserUDP
;SE9M.c,2260 :: 		}
L_SPI_Ethernet_UserUDP409:
;SE9M.c,2261 :: 		}
L_end_SPI_Ethernet_UserUDP:
	RETURN      0
; end of _SPI_Ethernet_UserUDP

_interrupt:

;SE9M.c,2263 :: 		void interrupt() {
;SE9M.c,2265 :: 		if (PIR1.RCIF == 1) {
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt410
;SE9M.c,2266 :: 		prkomanda = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _prkomanda+0 
;SE9M.c,2267 :: 		if ( ( (ipt == 0) && (prkomanda == 0xAA) ) || (ipt != 0) ) {
	MOVF        _ipt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt577
	MOVF        _prkomanda+0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt577
	GOTO        L__interrupt576
L__interrupt577:
	MOVF        _ipt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt576
	GOTO        L_interrupt415
L__interrupt576:
;SE9M.c,2268 :: 		comand[ipt] = prkomanda;
	MOVLW       _comand+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_comand+0)
	MOVWF       FSR1H 
	MOVF        _ipt+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        _prkomanda+0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,2269 :: 		ipt++;
	INCF        _ipt+0, 1 
;SE9M.c,2270 :: 		}
L_interrupt415:
;SE9M.c,2271 :: 		if (prkomanda == 0xBB) {
	MOVF        _prkomanda+0, 0 
	XORLW       187
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt416
;SE9M.c,2272 :: 		komgotovo = 1;
	MOVLW       1
	MOVWF       _komgotovo+0 
;SE9M.c,2273 :: 		ipt = 0;
	CLRF        _ipt+0 
;SE9M.c,2274 :: 		}
L_interrupt416:
;SE9M.c,2275 :: 		if (ipt > 18) {
	MOVF        _ipt+0, 0 
	SUBLW       18
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt417
;SE9M.c,2276 :: 		ipt = 0;
	CLRF        _ipt+0 
;SE9M.c,2277 :: 		}
L_interrupt417:
;SE9M.c,2278 :: 		}
L_interrupt410:
;SE9M.c,2280 :: 		if (INTCON.TMR0IF) {
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt418
;SE9M.c,2281 :: 		presTmr++ ;
	INFSNZ      _presTmr+0, 1 
	INCF        _presTmr+1, 1 
;SE9M.c,2282 :: 		lcdTmr++ ;
	INFSNZ      _lcdTmr+0, 1 
	INCF        _lcdTmr+1, 1 
;SE9M.c,2284 :: 		if (presTmr == 15625) {
	MOVF        _presTmr+1, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt630
	MOVLW       9
	XORWF       _presTmr+0, 0 
L__interrupt630:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt419
;SE9M.c,2287 :: 		if (tmr_rst_en == 1) {
	MOVF        _tmr_rst_en+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt420
;SE9M.c,2288 :: 		tmr_rst++;
	INCF        _tmr_rst+0, 1 
;SE9M.c,2289 :: 		if (tmr_rst == 178) {
	MOVF        _tmr_rst+0, 0 
	XORLW       178
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt421
;SE9M.c,2290 :: 		tmr_rst = 0;
	CLRF        _tmr_rst+0 
;SE9M.c,2291 :: 		tmr_rst_en = 0;
	CLRF        _tmr_rst_en+0 
;SE9M.c,2292 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,2293 :: 		}
L_interrupt421:
;SE9M.c,2294 :: 		} else {
	GOTO        L_interrupt422
L_interrupt420:
;SE9M.c,2295 :: 		tmr_rst = 0;
	CLRF        _tmr_rst+0 
;SE9M.c,2296 :: 		}
L_interrupt422:
;SE9M.c,2300 :: 		notime++;
	INCF        _notime+0, 1 
;SE9M.c,2301 :: 		if (notime == 32) {
	MOVF        _notime+0, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt423
;SE9M.c,2302 :: 		notime = 0;
	CLRF        _notime+0 
;SE9M.c,2303 :: 		notime_ovf = 1;
	MOVLW       1
	MOVWF       _notime_ovf+0 
;SE9M.c,2304 :: 		}
L_interrupt423:
;SE9M.c,2308 :: 		if ( (lease_tmr == 1) && (lease_time < 250) ) {
	MOVF        _lease_tmr+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt426
	MOVLW       250
	SUBWF       _lease_time+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt426
L__interrupt575:
;SE9M.c,2309 :: 		lease_time++;
	INCF        _lease_time+0, 1 
;SE9M.c,2310 :: 		} else {
	GOTO        L_interrupt427
L_interrupt426:
;SE9M.c,2311 :: 		lease_time = 0;
	CLRF        _lease_time+0 
;SE9M.c,2312 :: 		}
L_interrupt427:
;SE9M.c,2316 :: 		SPI_Ethernet_UserTimerSec++ ;
	MOVLW       1
	ADDWF       _SPI_Ethernet_UserTimerSec+0, 1 
	MOVLW       0
	ADDWFC      _SPI_Ethernet_UserTimerSec+1, 1 
	ADDWFC      _SPI_Ethernet_UserTimerSec+2, 1 
	ADDWFC      _SPI_Ethernet_UserTimerSec+3, 1 
;SE9M.c,2317 :: 		epoch++ ;
	MOVLW       1
	ADDWF       _epoch+0, 1 
	MOVLW       0
	ADDWFC      _epoch+1, 1 
	ADDWFC      _epoch+2, 1 
	ADDWFC      _epoch+3, 1 
;SE9M.c,2318 :: 		presTmr = 0 ;
	CLRF        _presTmr+0 
	CLRF        _presTmr+1 
;SE9M.c,2322 :: 		if (timer_flag < 2555) {
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORLW       9
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt631
	MOVLW       251
	SUBWF       _timer_flag+0, 0 
L__interrupt631:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt428
;SE9M.c,2323 :: 		timer_flag++;
	INCF        _timer_flag+0, 1 
;SE9M.c,2324 :: 		} else {
	GOTO        L_interrupt429
L_interrupt428:
;SE9M.c,2325 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2326 :: 		}
L_interrupt429:
;SE9M.c,2331 :: 		req_tmr_1++;
	INCF        _req_tmr_1+0, 1 
;SE9M.c,2332 :: 		if (req_tmr_1 == 60) {
	MOVF        _req_tmr_1+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt430
;SE9M.c,2333 :: 		req_tmr_1 = 0;
	CLRF        _req_tmr_1+0 
;SE9M.c,2334 :: 		req_tmr_2++;
	INCF        _req_tmr_2+0, 1 
;SE9M.c,2335 :: 		}
L_interrupt430:
;SE9M.c,2336 :: 		if (req_tmr_2 == 60) {
	MOVF        _req_tmr_2+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt431
;SE9M.c,2337 :: 		req_tmr_2 = 0;
	CLRF        _req_tmr_2+0 
;SE9M.c,2338 :: 		req_tmr_3++;
	INCF        _req_tmr_3+0, 1 
;SE9M.c,2339 :: 		}
L_interrupt431:
;SE9M.c,2343 :: 		if (rst_flag == 1) {
	MOVF        _rst_flag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt432
;SE9M.c,2344 :: 		rst_flag_1++;
	INCF        _rst_flag_1+0, 1 
;SE9M.c,2345 :: 		}
L_interrupt432:
;SE9M.c,2349 :: 		if ( (rst_fab_tmr == 1) && (rst_fab_flag < 200) ) {
	MOVF        _rst_fab_tmr+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt435
	MOVLW       200
	SUBWF       _rst_fab_flag+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt435
L__interrupt574:
;SE9M.c,2350 :: 		rst_fab_flag++;
	INCF        _rst_fab_flag+0, 1 
;SE9M.c,2351 :: 		}
L_interrupt435:
;SE9M.c,2354 :: 		}
L_interrupt419:
;SE9M.c,2356 :: 		if (lcdTmr == 3125) {
	MOVF        _lcdTmr+1, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt632
	MOVLW       53
	XORWF       _lcdTmr+0, 0 
L__interrupt632:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt436
;SE9M.c,2357 :: 		lcdEvent = 1;
	MOVLW       1
	MOVWF       _lcdEvent+0 
;SE9M.c,2358 :: 		lcdTmr = 0;
	CLRF        _lcdTmr+0 
	CLRF        _lcdTmr+1 
;SE9M.c,2359 :: 		}
L_interrupt436:
;SE9M.c,2360 :: 		INTCON.TMR0IF = 0 ;              // clear timer0 overflow flag
	BCF         INTCON+0, 2 
;SE9M.c,2361 :: 		}
L_interrupt418:
;SE9M.c,2362 :: 		}
L_end_interrupt:
L__interrupt629:
	RETFIE      1
; end of _interrupt

_Print_Blank:

;SE9M.c,2365 :: 		void Print_Blank() {
;SE9M.c,2366 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2367 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2368 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2369 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2370 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2371 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2372 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2373 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2374 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2375 :: 		delay_ms(1000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_Print_Blank437:
	DECFSZ      R13, 1, 1
	BRA         L_Print_Blank437
	DECFSZ      R12, 1, 1
	BRA         L_Print_Blank437
	DECFSZ      R11, 1, 1
	BRA         L_Print_Blank437
;SE9M.c,2376 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2377 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2378 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2379 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2380 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2381 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2382 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2383 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2384 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2385 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2386 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_Blank438:
	DECFSZ      R13, 1, 1
	BRA         L_Print_Blank438
	DECFSZ      R12, 1, 1
	BRA         L_Print_Blank438
	DECFSZ      R11, 1, 1
	BRA         L_Print_Blank438
	NOP
;SE9M.c,2387 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2388 :: 		}
L_end_Print_Blank:
	RETURN      0
; end of _Print_Blank

_Print_All:

;SE9M.c,2390 :: 		void Print_All() {
;SE9M.c,2394 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2395 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2396 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2397 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2398 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2399 :: 		PRINT_S(Print_Seg(15, 1));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	MOVLW       1
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2400 :: 		PRINT_S(Print_Seg(15, 1));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	MOVLW       1
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2401 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2402 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2403 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_All439:
	DECFSZ      R13, 1, 1
	BRA         L_Print_All439
	DECFSZ      R12, 1, 1
	BRA         L_Print_All439
	DECFSZ      R11, 1, 1
	BRA         L_Print_All439
	NOP
;SE9M.c,2404 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2405 :: 		for (pebr = 0; pebr <= 9; pebr++) {
	CLRF        Print_All_pebr_L0+0 
L_Print_All440:
	MOVF        Print_All_pebr_L0+0, 0 
	SUBLW       9
	BTFSS       STATUS+0, 0 
	GOTO        L_Print_All441
;SE9M.c,2406 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2407 :: 		if ( (pebr == 1) || (pebr == 3) || (pebr == 5) || (pebr == 7) || (pebr == 9) ) {
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All578
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All578
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All578
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All578
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All578
	GOTO        L_Print_All445
L__Print_All578:
;SE9M.c,2408 :: 		tck1 = 1;
	MOVLW       1
	MOVWF       Print_All_tck1_L0+0 
;SE9M.c,2409 :: 		tck2 = 0;
	CLRF        Print_All_tck2_L0+0 
;SE9M.c,2410 :: 		} else {
	GOTO        L_Print_All446
L_Print_All445:
;SE9M.c,2411 :: 		tck1 = 0;
	CLRF        Print_All_tck1_L0+0 
;SE9M.c,2412 :: 		tck2 = 1;
	MOVLW       1
	MOVWF       Print_All_tck2_L0+0 
;SE9M.c,2413 :: 		}
L_Print_All446:
;SE9M.c,2414 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2415 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2416 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2417 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2418 :: 		PRINT_S(Print_Seg(pebr, tck1));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        Print_All_tck1_L0+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2419 :: 		PRINT_S(Print_Seg(pebr, tck2));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        Print_All_tck2_L0+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2420 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2421 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2422 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_All447:
	DECFSZ      R13, 1, 1
	BRA         L_Print_All447
	DECFSZ      R12, 1, 1
	BRA         L_Print_All447
	DECFSZ      R11, 1, 1
	BRA         L_Print_All447
	NOP
;SE9M.c,2423 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2405 :: 		for (pebr = 0; pebr <= 9; pebr++) {
	INCF        Print_All_pebr_L0+0, 1 
;SE9M.c,2424 :: 		}
	GOTO        L_Print_All440
L_Print_All441:
;SE9M.c,2425 :: 		}
L_end_Print_All:
	RETURN      0
; end of _Print_All

_Print_Pme:

;SE9M.c,2428 :: 		void Print_Pme() {
;SE9M.c,2429 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2430 :: 		PRINT_S(Print_Seg(14, 0));
	MOVLW       14
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2431 :: 		PRINT_S(Print_Seg(14, 0));
	MOVLW       14
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2432 :: 		PRINT_S(Print_Seg(13, 0));
	MOVLW       13
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2433 :: 		PRINT_S(Print_Seg(12, 0));
	MOVLW       12
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2434 :: 		PRINT_S(Print_Seg(11, 0));
	MOVLW       11
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2435 :: 		PRINT_S(Print_Seg(10, 0));
	MOVLW       10
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2436 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2437 :: 		}
L_end_Print_Pme:
	RETURN      0
; end of _Print_Pme

_Print_Light:

;SE9M.c,2440 :: 		void Print_Light() {
;SE9M.c,2441 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;SE9M.c,2442 :: 		light_res = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _light_res+0 
	MOVF        R1, 0 
	MOVWF       _light_res+1 
;SE9M.c,2443 :: 		result = light_res * 0.00322265625;  // scale adc result by 100000 (3.22mV/lsb => 3.3V / 1024 = 0.00322265625...V)
	CALL        _word2double+0, 0
	MOVLW       51
	MOVWF       R4 
	MOVLW       51
	MOVWF       R5 
	MOVLW       83
	MOVWF       R6 
	MOVLW       118
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _result+0 
	MOVF        R1, 0 
	MOVWF       _result+1 
	MOVF        R2, 0 
	MOVWF       _result+2 
	MOVF        R3, 0 
	MOVWF       _result+3 
;SE9M.c,2445 :: 		if (result <= 1.3) {                            // 1.1
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       102
	MOVWF       R0 
	MOVLW       102
	MOVWF       R1 
	MOVLW       38
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Print_Light448
;SE9M.c,2446 :: 		PWM1_Set_Duty(max_light);
	MOVF        _max_light+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2447 :: 		}
L_Print_Light448:
;SE9M.c,2448 :: 		if ( (result > 1.3) && (result <= 2.3) ) {      // 1.1 - 2.2
	MOVF        _result+0, 0 
	MOVWF       R4 
	MOVF        _result+1, 0 
	MOVWF       R5 
	MOVF        _result+2, 0 
	MOVWF       R6 
	MOVF        _result+3, 0 
	MOVWF       R7 
	MOVLW       102
	MOVWF       R0 
	MOVLW       102
	MOVWF       R1 
	MOVLW       38
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Print_Light451
	MOVF        _result+0, 0 
	MOVWF       R4 
	MOVF        _result+1, 0 
	MOVWF       R5 
	MOVF        _result+2, 0 
	MOVWF       R6 
	MOVF        _result+3, 0 
	MOVWF       R7 
	MOVLW       51
	MOVWF       R0 
	MOVLW       51
	MOVWF       R1 
	MOVLW       19
	MOVWF       R2 
	MOVLW       128
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Print_Light451
L__Print_Light579:
;SE9M.c,2449 :: 		PWM1_Set_Duty((max_light*2)/3);
	MOVF        _max_light+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	RLCF        R1, 1 
	BCF         R0, 0 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2450 :: 		}
L_Print_Light451:
;SE9M.c,2451 :: 		if (result > 2.3) {
	MOVF        _result+0, 0 
	MOVWF       R4 
	MOVF        _result+1, 0 
	MOVWF       R5 
	MOVF        _result+2, 0 
	MOVWF       R6 
	MOVF        _result+3, 0 
	MOVWF       R7 
	MOVLW       51
	MOVWF       R0 
	MOVLW       51
	MOVWF       R1 
	MOVLW       19
	MOVWF       R2 
	MOVLW       128
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Print_Light452
;SE9M.c,2452 :: 		PWM1_Set_Duty(max_light/3);                  // 2.2
	MOVLW       3
	MOVWF       R4 
	MOVF        _max_light+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2453 :: 		}
L_Print_Light452:
;SE9M.c,2455 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2456 :: 		}
L_end_Print_Light:
	RETURN      0
; end of _Print_Light

_Mem_Read:

;SE9M.c,2459 :: 		void Mem_Read() {
;SE9M.c,2461 :: 		MSSPEN  = 1;
	BSF         RE0_bit+0, BitPos(RE0_bit+0) 
;SE9M.c,2462 :: 		asm nop;
	NOP
;SE9M.c,2463 :: 		asm nop;
	NOP
;SE9M.c,2464 :: 		asm nop;
	NOP
;SE9M.c,2465 :: 		I2C1_Init(100000);
	MOVLW       80
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;SE9M.c,2466 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;SE9M.c,2467 :: 		I2C1_Wr(0xA2);
	MOVLW       162
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SE9M.c,2468 :: 		I2C1_Wr(0xFA);
	MOVLW       250
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SE9M.c,2469 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;SE9M.c,2470 :: 		I2C1_Wr(0xA3);
	MOVLW       163
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SE9M.c,2471 :: 		for(membr=0 ; membr<=4 ; membr++) {
	CLRF        Mem_Read_membr_L0+0 
L_Mem_Read453:
	MOVF        Mem_Read_membr_L0+0, 0 
	SUBLW       4
	BTFSS       STATUS+0, 0 
	GOTO        L_Mem_Read454
;SE9M.c,2472 :: 		macAddr[membr] = I2C1_Rd(1);
	MOVLW       _macAddr+0
	MOVWF       FLOC__Mem_Read+0 
	MOVLW       hi_addr(_macAddr+0)
	MOVWF       FLOC__Mem_Read+1 
	MOVF        Mem_Read_membr_L0+0, 0 
	ADDWF       FLOC__Mem_Read+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__Mem_Read+1, 1 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVFF       FLOC__Mem_Read+0, FSR1
	MOVFF       FLOC__Mem_Read+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,2471 :: 		for(membr=0 ; membr<=4 ; membr++) {
	INCF        Mem_Read_membr_L0+0, 1 
;SE9M.c,2473 :: 		}
	GOTO        L_Mem_Read453
L_Mem_Read454:
;SE9M.c,2474 :: 		macAddr[5] = I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _macAddr+5 
;SE9M.c,2475 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;SE9M.c,2476 :: 		MSSPEN  = 0;
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;SE9M.c,2477 :: 		asm nop;
	NOP
;SE9M.c,2478 :: 		asm nop;
	NOP
;SE9M.c,2479 :: 		asm nop;
	NOP
;SE9M.c,2481 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;SE9M.c,2482 :: 		}
L_end_Mem_Read:
	RETURN      0
; end of _Mem_Read

_main:

;SE9M.c,2487 :: 		void main() {
;SE9M.c,2489 :: 		TRISA = 0b00000001;
	MOVLW       1
	MOVWF       TRISA+0 
;SE9M.c,2490 :: 		PORTA = 0;
	CLRF        PORTA+0 
;SE9M.c,2491 :: 		TRISB = 0;
	CLRF        TRISB+0 
;SE9M.c,2492 :: 		PORTB = 0;
	CLRF        PORTB+0 
;SE9M.c,2493 :: 		TRISC = 0;
	CLRF        TRISC+0 
;SE9M.c,2494 :: 		PORTC = 0;
	CLRF        PORTC+0 
;SE9M.c,2496 :: 		Com_En_Direction = 0;
	BCF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;SE9M.c,2497 :: 		Com_En = 1;
	BSF         RB0_bit+0, BitPos(RB0_bit+0) 
;SE9M.c,2499 :: 		Kom_En_1_Direction = 0;
	BCF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;SE9M.c,2500 :: 		Kom_En_1 = 1;
	BSF         RB1_bit+0, BitPos(RB1_bit+0) 
;SE9M.c,2502 :: 		Kom_En_2_Direction = 0;
	BCF         TRISB3_bit+0, BitPos(TRISB3_bit+0) 
;SE9M.c,2503 :: 		Kom_En_2 = 0;
	BCF         RB3_bit+0, BitPos(RB3_bit+0) 
;SE9M.c,2505 :: 		Eth1_Link_Direction = 1;
	BSF         TRISB5_bit+0, BitPos(TRISB5_bit+0) 
;SE9M.c,2507 :: 		SPI_Ethernet_Rst_Direction = 0;
	BCF         TRISA5_bit+0, BitPos(TRISA5_bit+0) 
;SE9M.c,2508 :: 		SPI_Ethernet_Rst = 0;
	BCF         RA5_bit+0, BitPos(RA5_bit+0) 
;SE9M.c,2509 :: 		SPI_Ethernet_CS_Direction  = 0;
	BCF         TRISA4_bit+0, BitPos(TRISA4_bit+0) 
;SE9M.c,2510 :: 		SPI_Ethernet_CS  = 0;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
;SE9M.c,2512 :: 		RSTPIN_Direction = 1;
	BSF         TRISD4_bit+0, BitPos(TRISD4_bit+0) 
;SE9M.c,2514 :: 		DISPEN_Direction = 0;
	BCF         TRISE2_bit+0, BitPos(TRISE2_bit+0) 
;SE9M.c,2515 :: 		DISPEN = 0;
	BCF         RE2_bit+0, BitPos(RE2_bit+0) 
;SE9M.c,2517 :: 		MSSPEN_Direction = 0;
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;SE9M.c,2518 :: 		MSSPEN = 0;
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;SE9M.c,2520 :: 		SV_DATA_Direction = 0;
	BCF         TRISA1_bit+0, BitPos(TRISA1_bit+0) 
;SE9M.c,2521 :: 		SV_DATA = 0;
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;SE9M.c,2522 :: 		SV_CLK_Direction = 0;
	BCF         TRISA2_bit+0, BitPos(TRISA2_bit+0) 
;SE9M.c,2523 :: 		SV_CLK = 0;
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
;SE9M.c,2524 :: 		STROBE_Direction = 0;
	BCF         TRISA3_bit+0, BitPos(TRISA3_bit+0) 
;SE9M.c,2525 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2527 :: 		BCKL_Direction = 0;
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;SE9M.c,2528 :: 		BCKL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;SE9M.c,2530 :: 		ANSEL = 0;
	CLRF        ANSEL+0 
;SE9M.c,2531 :: 		ANSELH = 0;
	CLRF        ANSELH+0 
;SE9M.c,2533 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;SE9M.c,2534 :: 		ADCON1 = 0b00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;SE9M.c,2536 :: 		max_light = 180;
	MOVLW       180
	MOVWF       _max_light+0 
;SE9M.c,2537 :: 		min_light = 30;
	MOVLW       30
	MOVWF       _min_light+0 
;SE9M.c,2539 :: 		PWM1_Init(2000);
	BSF         T2CON+0, 0, 0
	BSF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;SE9M.c,2540 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;SE9M.c,2541 :: 		PWM1_Set_Duty(max_light);      // 90
	MOVF        _max_light+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2544 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       3
	MOVWF       SPBRGH+0 
	MOVLW       64
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;SE9M.c,2545 :: 		PIE1.RCIE = 1;
	BSF         PIE1+0, 5 
;SE9M.c,2546 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;SE9M.c,2547 :: 		PEIE_bit = 1;
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;SE9M.c,2550 :: 		T0CON = 0b11000000 ;
	MOVLW       192
	MOVWF       T0CON+0 
;SE9M.c,2551 :: 		INTCON.TMR0IF = 0 ;
	BCF         INTCON+0, 2 
;SE9M.c,2552 :: 		INTCON.TMR0IE = 1 ;
	BSF         INTCON+0, 5 
;SE9M.c,2555 :: 		while(1) {
L_main456:
;SE9M.c,2557 :: 		pom_time_pom = EEPROM_Read(0);
	CLRF        FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pom_time_pom+0 
;SE9M.c,2559 :: 		if ( (pom_time_pom != 0xAA) || (rst_fab == 1) ) {
	MOVF        R0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L__main586
	MOVF        _rst_fab+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__main586
	GOTO        L_main460
L__main586:
;SE9M.c,2561 :: 		conf.dhcpen = 1;
	MOVLW       1
	MOVWF       _conf+0 
;SE9M.c,2562 :: 		EEPROM_Write(103, conf.dhcpen);
	MOVLW       103
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2563 :: 		mode = 1;
	MOVLW       1
	MOVWF       _mode+0 
;SE9M.c,2564 :: 		EEPROM_Write(104, mode);
	MOVLW       104
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2565 :: 		dhcp_flag = 0;
	CLRF        _dhcp_flag+0 
;SE9M.c,2566 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2568 :: 		strcpy(sifra, "adminpme");
	MOVLW       _sifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr248_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr248_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2569 :: 		for (j=0;j<=8;j++) {
	CLRF        _j+0 
L_main461:
	MOVF        _j+0, 0 
	SUBLW       8
	BTFSS       STATUS+0, 0 
	GOTO        L_main462
;SE9M.c,2570 :: 		EEPROM_Write(j+20, sifra[j]);
	MOVLW       20
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Write_address+1, 1 
	MOVLW       _sifra+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FSR0H 
	MOVF        _j+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2569 :: 		for (j=0;j<=8;j++) {
	INCF        _j+0, 1 
;SE9M.c,2571 :: 		}
	GOTO        L_main461
L_main462:
;SE9M.c,2573 :: 		strcpy(server1, "swisstime.ethz.ch");
	MOVLW       _server1+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_server1+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr249_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr249_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2574 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main464:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main465
;SE9M.c,2575 :: 		EEPROM_Write(j+29, server1[j]);
	MOVLW       29
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Write_address+1, 1 
	MOVLW       _server1+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_server1+0)
	MOVWF       FSR0H 
	MOVF        _j+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2574 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2576 :: 		}
	GOTO        L_main464
L_main465:
;SE9M.c,2577 :: 		strcpy(server2, "0.rs.pool.ntp.org");
	MOVLW       _server2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_server2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr250_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr250_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2578 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main467:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main468
;SE9M.c,2579 :: 		EEPROM_Write(j+56, server2[j]);
	MOVLW       56
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Write_address+1, 1 
	MOVLW       _server2+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_server2+0)
	MOVWF       FSR0H 
	MOVF        _j+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2578 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2580 :: 		}
	GOTO        L_main467
L_main468:
;SE9M.c,2581 :: 		strcpy(server3, "pool.ntp.org");
	MOVLW       _server3+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_server3+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr251_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr251_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2582 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main470:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main471
;SE9M.c,2583 :: 		EEPROM_Write(j+110, server3[j]);
	MOVLW       110
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Write_address+1, 1 
	MOVLW       _server3+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_server3+0)
	MOVWF       FSR0H 
	MOVF        _j+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2582 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2584 :: 		}
	GOTO        L_main470
L_main471:
;SE9M.c,2590 :: 		ipAddr[0]    = 192;
	MOVLW       192
	MOVWF       _ipAddr+0 
;SE9M.c,2591 :: 		ipAddr[1]    = 168;
	MOVLW       168
	MOVWF       _ipAddr+1 
;SE9M.c,2592 :: 		ipAddr[2]    = 1;
	MOVLW       1
	MOVWF       _ipAddr+2 
;SE9M.c,2593 :: 		ipAddr[3]    = 99;
	MOVLW       99
	MOVWF       _ipAddr+3 
;SE9M.c,2594 :: 		gwIpAddr[0]  = 192;
	MOVLW       192
	MOVWF       _gwIpAddr+0 
;SE9M.c,2595 :: 		gwIpAddr[1]  = 168;
	MOVLW       168
	MOVWF       _gwIpAddr+1 
;SE9M.c,2596 :: 		gwIpAddr[2]  = 1;
	MOVLW       1
	MOVWF       _gwIpAddr+2 
;SE9M.c,2597 :: 		gwIpAddr[3]  = 1;
	MOVLW       1
	MOVWF       _gwIpAddr+3 
;SE9M.c,2598 :: 		ipMask[0]    = 255;
	MOVLW       255
	MOVWF       _ipMask+0 
;SE9M.c,2599 :: 		ipMask[1]    = 255;
	MOVLW       255
	MOVWF       _ipMask+1 
;SE9M.c,2600 :: 		ipMask[2]    = 255;
	MOVLW       255
	MOVWF       _ipMask+2 
;SE9M.c,2601 :: 		ipMask[3]    = 0;
	CLRF        _ipMask+3 
;SE9M.c,2602 :: 		dnsIpAddr[0] = 192;
	MOVLW       192
	MOVWF       _dnsIpAddr+0 
;SE9M.c,2603 :: 		dnsIpAddr[1] = 168;
	MOVLW       168
	MOVWF       _dnsIpAddr+1 
;SE9M.c,2604 :: 		dnsIpAddr[2] = 1;
	MOVLW       1
	MOVWF       _dnsIpAddr+2 
;SE9M.c,2605 :: 		dnsIpAddr[3] = 1;
	MOVLW       1
	MOVWF       _dnsIpAddr+3 
;SE9M.c,2608 :: 		EEPROM_Write(1, ipAddr[0]);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2609 :: 		EEPROM_Write(2, ipAddr[1]);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2610 :: 		EEPROM_Write(3, ipAddr[2]);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2611 :: 		EEPROM_Write(4, ipAddr[3]);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2612 :: 		EEPROM_Write(5, gwIpAddr[0]);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2613 :: 		EEPROM_Write(6, gwIpAddr[1]);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2614 :: 		EEPROM_Write(7, gwIpAddr[2]);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2615 :: 		EEPROM_Write(8, gwIpAddr[3]);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2616 :: 		EEPROM_Write(9, ipMask[0]);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2617 :: 		EEPROM_Write(10, ipMask[1]);
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2618 :: 		EEPROM_Write(11, ipMask[2]);
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2619 :: 		EEPROM_Write(12, ipMask[3]);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2620 :: 		EEPROM_Write(13, dnsIpAddr[0]);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2621 :: 		EEPROM_Write(14, dnsIpAddr[1]);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2622 :: 		EEPROM_Write(15, dnsIpAddr[2]);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2623 :: 		EEPROM_Write(16, dnsIpAddr[3]);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2625 :: 		ByteToStr(ipAddr[0], IpAddrPom0);
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2626 :: 		ByteToStr(ipAddr[1], IpAddrPom1);
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2627 :: 		ByteToStr(ipAddr[2], IpAddrPom2);
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2628 :: 		ByteToStr(ipAddr[3], IpAddrPom3);
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2630 :: 		ByteToStr(gwIpAddr[0], gwIpAddrPom0);
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2631 :: 		ByteToStr(gwIpAddr[1], gwIpAddrPom1);
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2632 :: 		ByteToStr(gwIpAddr[2], gwIpAddrPom2);
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2633 :: 		ByteToStr(gwIpAddr[3], gwIpAddrPom3);
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2635 :: 		ByteToStr(ipMask[0], ipMaskPom0);
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2636 :: 		ByteToStr(ipMask[1], ipMaskPom1);
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2637 :: 		ByteToStr(ipMask[2], ipMaskPom2);
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2638 :: 		ByteToStr(ipMask[3], ipMaskPom3);
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2640 :: 		ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2641 :: 		ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2642 :: 		ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2643 :: 		ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2645 :: 		rst_fab = 0;
	CLRF        _rst_fab+0 
;SE9M.c,2646 :: 		pom_time_pom = 0xAA;
	MOVLW       170
	MOVWF       _pom_time_pom+0 
;SE9M.c,2647 :: 		EEPROM_Write(0, pom_time_pom);
	CLRF        FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       170
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2648 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main473:
	DECFSZ      R13, 1, 1
	BRA         L_main473
	DECFSZ      R12, 1, 1
	BRA         L_main473
	DECFSZ      R11, 1, 1
	BRA         L_main473
;SE9M.c,2649 :: 		}
L_main460:
;SE9M.c,2651 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2653 :: 		sifra[0]    = EEPROM_Read(20);
	MOVLW       20
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+0 
;SE9M.c,2654 :: 		sifra[1]    = EEPROM_Read(21);
	MOVLW       21
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+1 
;SE9M.c,2655 :: 		sifra[2]    = EEPROM_Read(22);
	MOVLW       22
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+2 
;SE9M.c,2656 :: 		sifra[3]    = EEPROM_Read(23);
	MOVLW       23
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+3 
;SE9M.c,2657 :: 		sifra[4]    = EEPROM_Read(24);
	MOVLW       24
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+4 
;SE9M.c,2658 :: 		sifra[5]    = EEPROM_Read(25);
	MOVLW       25
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+5 
;SE9M.c,2659 :: 		sifra[6]    = EEPROM_Read(26);
	MOVLW       26
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+6 
;SE9M.c,2660 :: 		sifra[7]    = EEPROM_Read(27);
	MOVLW       27
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+7 
;SE9M.c,2661 :: 		sifra[8]    = EEPROM_Read(28);
	MOVLW       28
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+8 
;SE9M.c,2663 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main474:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main475
;SE9M.c,2664 :: 		server1[j] = EEPROM_Read(j+29);
	MOVLW       _server1+0
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_server1+0)
	MOVWF       FLOC__main+1 
	MOVF        _j+0, 0 
	ADDWF       FLOC__main+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__main+1, 1 
	MOVLW       29
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Read_address+1, 1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,2663 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2665 :: 		}
	GOTO        L_main474
L_main475:
;SE9M.c,2666 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main477:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main478
;SE9M.c,2667 :: 		server2[j] = EEPROM_Read(j+56);
	MOVLW       _server2+0
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_server2+0)
	MOVWF       FLOC__main+1 
	MOVF        _j+0, 0 
	ADDWF       FLOC__main+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__main+1, 1 
	MOVLW       56
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Read_address+1, 1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,2666 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2668 :: 		}
	GOTO        L_main477
L_main478:
;SE9M.c,2669 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main480:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main481
;SE9M.c,2670 :: 		server3[j] = EEPROM_Read(j+110);
	MOVLW       _server3+0
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_server3+0)
	MOVWF       FLOC__main+1 
	MOVF        _j+0, 0 
	ADDWF       FLOC__main+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__main+1, 1 
	MOVLW       110
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Read_address+1, 1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,2669 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2671 :: 		}
	GOTO        L_main480
L_main481:
;SE9M.c,2673 :: 		ipAddr[0]    = EEPROM_Read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+0 
;SE9M.c,2674 :: 		ipAddr[1]    = EEPROM_Read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+1 
;SE9M.c,2675 :: 		ipAddr[2]    = EEPROM_Read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+2 
;SE9M.c,2676 :: 		ipAddr[3]    = EEPROM_Read(4);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+3 
;SE9M.c,2677 :: 		gwIpAddr[0]  = EEPROM_Read(5);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+0 
;SE9M.c,2678 :: 		gwIpAddr[1]  = EEPROM_Read(6);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+1 
;SE9M.c,2679 :: 		gwIpAddr[2]  = EEPROM_Read(7);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+2 
;SE9M.c,2680 :: 		gwIpAddr[3]  = EEPROM_Read(8);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+3 
;SE9M.c,2681 :: 		ipMask[0]    = EEPROM_Read(9);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+0 
;SE9M.c,2682 :: 		ipMask[1]    = EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+1 
;SE9M.c,2683 :: 		ipMask[2]    = EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+2 
;SE9M.c,2684 :: 		ipMask[3]    = EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+3 
;SE9M.c,2685 :: 		dnsIpAddr[0] = EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+0 
;SE9M.c,2686 :: 		dnsIpAddr[1] = EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+1 
;SE9M.c,2687 :: 		dnsIpAddr[2] = EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+2 
;SE9M.c,2688 :: 		dnsIpAddr[3] = EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+3 
;SE9M.c,2691 :: 		if (prolaz == 1) {
	MOVF        _prolaz+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main483
;SE9M.c,2692 :: 		ByteToStr(ipAddr[0], IpAddrPom0);
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2693 :: 		ByteToStr(ipAddr[1], IpAddrPom1);
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2694 :: 		ByteToStr(ipAddr[2], IpAddrPom2);
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2695 :: 		ByteToStr(ipAddr[3], IpAddrPom3);
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2697 :: 		ByteToStr(gwIpAddr[0], gwIpAddrPom0);
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2698 :: 		ByteToStr(gwIpAddr[1], gwIpAddrPom1);
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2699 :: 		ByteToStr(gwIpAddr[2], gwIpAddrPom2);
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2700 :: 		ByteToStr(gwIpAddr[3], gwIpAddrPom3);
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2702 :: 		ByteToStr(ipMask[0], ipMaskPom0);
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2703 :: 		ByteToStr(ipMask[1], ipMaskPom1);
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2704 :: 		ByteToStr(ipMask[2], ipMaskPom2);
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2705 :: 		ByteToStr(ipMask[3], ipMaskPom3);
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2707 :: 		ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2708 :: 		ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2709 :: 		ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2710 :: 		ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2712 :: 		prolaz = 0;
	CLRF        _prolaz+0 
;SE9M.c,2713 :: 		Print_All();
	CALL        _Print_All+0, 0
;SE9M.c,2714 :: 		}
L_main483:
;SE9M.c,2716 :: 		conf.tz = EEPROM_Read(102);
	MOVLW       102
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+2 
;SE9M.c,2717 :: 		conf.dhcpen = EEPROM_Read(103);
	MOVLW       103
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+0 
;SE9M.c,2718 :: 		mode = EEPROM_Read(104);
	MOVLW       104
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _mode+0 
;SE9M.c,2719 :: 		dhcp_flag = EEPROM_Read(105);
	MOVLW       105
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dhcp_flag+0 
;SE9M.c,2721 :: 		if ( (conf.dhcpen == 0) && (dhcp_flag == 1) ) {
	MOVF        _conf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main486
	MOVF        _dhcp_flag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main486
L__main585:
;SE9M.c,2722 :: 		conf.dhcpen = 1;
	MOVLW       1
	MOVWF       _conf+0 
;SE9M.c,2723 :: 		EEPROM_Write(103, conf.dhcpen);
	MOVLW       103
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2724 :: 		dhcp_flag = 0;
	CLRF        _dhcp_flag+0 
;SE9M.c,2725 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2726 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main487:
	DECFSZ      R13, 1, 1
	BRA         L_main487
	DECFSZ      R12, 1, 1
	BRA         L_main487
	DECFSZ      R11, 1, 1
	BRA         L_main487
;SE9M.c,2727 :: 		}
L_main486:
;SE9M.c,2729 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2731 :: 		if (reset_eth == 1) {
	MOVF        _reset_eth+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main488
;SE9M.c,2732 :: 		reset_eth = 0;
	CLRF        _reset_eth+0 
;SE9M.c,2733 :: 		prvi_timer = 1;
	MOVLW       1
	MOVWF       _prvi_timer+0 
;SE9M.c,2734 :: 		drugi_timer = 0;
	CLRF        _drugi_timer+0 
;SE9M.c,2735 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2736 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2737 :: 		}
L_main488:
;SE9M.c,2738 :: 		if ( (prvi_timer == 1) && (timer_flag >= 1) ) {
	MOVF        _prvi_timer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main491
	MOVLW       1
	SUBWF       _timer_flag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main491
L__main584:
;SE9M.c,2739 :: 		prvi_timer = 0;
	CLRF        _prvi_timer+0 
;SE9M.c,2740 :: 		drugi_timer = 1;
	MOVLW       1
	MOVWF       _drugi_timer+0 
;SE9M.c,2741 :: 		SPI_Ethernet_Rst = 1;
	BSF         RA5_bit+0, BitPos(RA5_bit+0) 
;SE9M.c,2742 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2743 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2744 :: 		}
L_main491:
;SE9M.c,2745 :: 		if ( (drugi_timer == 1) && (timer_flag >= 1) ) {
	MOVF        _drugi_timer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main494
	MOVLW       1
	SUBWF       _timer_flag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main494
L__main583:
;SE9M.c,2746 :: 		prvi_timer = 0;
	CLRF        _prvi_timer+0 
;SE9M.c,2747 :: 		drugi_timer = 0;
	CLRF        _drugi_timer+0 
;SE9M.c,2748 :: 		link_enable = 1;
	MOVLW       1
	MOVWF       _link_enable+0 
;SE9M.c,2749 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2750 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2751 :: 		}
L_main494:
;SE9M.c,2752 :: 		if ( (Eth1_Link == 0) && (link == 0) && (link_enable == 1) ) {
	BTFSC       RB5_bit+0, BitPos(RB5_bit+0) 
	GOTO        L_main497
	MOVF        _link+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main497
	MOVF        _link_enable+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main497
L__main582:
;SE9M.c,2753 :: 		link = 1;
	MOVLW       1
	MOVWF       _link+0 
;SE9M.c,2754 :: 		tacka1 = 1;
	MOVLW       1
	MOVWF       _tacka1+0 
;SE9M.c,2755 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2757 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;SE9M.c,2758 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2759 :: 		if (conf.dhcpen == 0) {
	MOVF        _conf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main498
;SE9M.c,2760 :: 		Mem_Read();
	CALL        _Mem_Read+0, 0
;SE9M.c,2761 :: 		ipAddr[0] = 0;
	CLRF        _ipAddr+0 
;SE9M.c,2762 :: 		ipAddr[1] = 0;
	CLRF        _ipAddr+1 
;SE9M.c,2763 :: 		ipAddr[2] = 0;
	CLRF        _ipAddr+2 
;SE9M.c,2764 :: 		ipAddr[3] = 0;
	CLRF        _ipAddr+3 
;SE9M.c,2766 :: 		dhcp_flag = 1;
	MOVLW       1
	MOVWF       _dhcp_flag+0 
;SE9M.c,2767 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2769 :: 		Spi_Ethernet_Init(macAddr, ipAddr, Spi_Ethernet_FULLDUPLEX) ;
	MOVLW       _macAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_mac+0 
	MOVLW       hi_addr(_macAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_mac+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_ip+1 
	MOVLW       1
	MOVWF       FARG_SPI_Ethernet_Init_fullDuplex+0 
	CALL        _SPI_Ethernet_Init+0, 0
;SE9M.c,2771 :: 		while (SPI_Ethernet_initDHCP(5) == 0) ; // try to get one from DHCP until it works
L_main499:
	MOVLW       5
	MOVWF       FARG_SPI_Ethernet_initDHCP_tmax+0 
	CALL        _SPI_Ethernet_initDHCP+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main500
	GOTO        L_main499
L_main500:
;SE9M.c,2772 :: 		memcpy(ipAddr,    SPI_Ethernet_getIpAddress(),    4) ; // get assigned IP address
	CALL        _SPI_Ethernet_getIpAddress+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        R1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,2773 :: 		memcpy(ipMask,    SPI_Ethernet_getIpMask(),       4) ; // get assigned IP mask
	CALL        _SPI_Ethernet_getIpMask+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        R1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       _ipMask+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_ipMask+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,2774 :: 		memcpy(gwIpAddr,  SPI_Ethernet_getGwIpAddress(),  4) ; // get assigned gateway IP address
	CALL        _SPI_Ethernet_getGwIpAddress+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        R1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       _gwIpAddr+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_gwIpAddr+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,2775 :: 		memcpy(dnsIpAddr, SPI_Ethernet_getDnsIpAddress(), 4) ; // get assigned dns IP address
	CALL        _SPI_Ethernet_getDnsIpAddress+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        R1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       _dnsIpAddr+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_dnsIpAddr+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,2777 :: 		lease_tmr = 1;
	MOVLW       1
	MOVWF       _lease_tmr+0 
;SE9M.c,2778 :: 		lease_time = 0;
	CLRF        _lease_time+0 
;SE9M.c,2780 :: 		EEPROM_Write(1, ipAddr[0]);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2781 :: 		EEPROM_Write(2, ipAddr[1]);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2782 :: 		EEPROM_Write(3, ipAddr[2]);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2783 :: 		EEPROM_Write(4, ipAddr[3]);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2784 :: 		EEPROM_Write(5, gwIpAddr[0]);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2785 :: 		EEPROM_Write(6, gwIpAddr[1]);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2786 :: 		EEPROM_Write(7, gwIpAddr[2]);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2787 :: 		EEPROM_Write(8, gwIpAddr[3]);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2788 :: 		EEPROM_Write(9, ipMask[0]);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2789 :: 		EEPROM_Write(10, ipMask[1]);
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2790 :: 		EEPROM_Write(11, ipMask[2]);
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2791 :: 		EEPROM_Write(12, ipMask[3]);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2792 :: 		EEPROM_Write(13, dnsIpAddr[0]);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2793 :: 		EEPROM_Write(14, dnsIpAddr[1]);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2794 :: 		EEPROM_Write(15, dnsIpAddr[2]);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2795 :: 		EEPROM_Write(16, dnsIpAddr[3]);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2797 :: 		ByteToStr(ipAddr[0], IpAddrPom0);
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2798 :: 		ByteToStr(ipAddr[1], IpAddrPom1);
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2799 :: 		ByteToStr(ipAddr[2], IpAddrPom2);
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2800 :: 		ByteToStr(ipAddr[3], IpAddrPom3);
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2802 :: 		ByteToStr(gwIpAddr[0], gwIpAddrPom0);
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2803 :: 		ByteToStr(gwIpAddr[1], gwIpAddrPom1);
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2804 :: 		ByteToStr(gwIpAddr[2], gwIpAddrPom2);
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2805 :: 		ByteToStr(gwIpAddr[3], gwIpAddrPom3);
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2807 :: 		ByteToStr(ipMask[0], ipMaskPom0);
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2808 :: 		ByteToStr(ipMask[1], ipMaskPom1);
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2809 :: 		ByteToStr(ipMask[2], ipMaskPom2);
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2810 :: 		ByteToStr(ipMask[3], ipMaskPom3);
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2812 :: 		ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2813 :: 		ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2814 :: 		ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2815 :: 		ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2817 :: 		dhcp_flag = 0;
	CLRF        _dhcp_flag+0 
;SE9M.c,2818 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2820 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main501:
	DECFSZ      R13, 1, 1
	BRA         L_main501
	DECFSZ      R12, 1, 1
	BRA         L_main501
	DECFSZ      R11, 1, 1
	BRA         L_main501
;SE9M.c,2821 :: 		Print_IP();
	CALL        _Print_IP+0, 0
;SE9M.c,2822 :: 		}
L_main498:
;SE9M.c,2823 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main502
;SE9M.c,2824 :: 		lease_tmr = 0;
	CLRF        _lease_tmr+0 
;SE9M.c,2825 :: 		Mem_Read();
	CALL        _Mem_Read+0, 0
;SE9M.c,2826 :: 		Spi_Ethernet_Init(macAddr, ipAddr, Spi_Ethernet_FULLDUPLEX) ;
	MOVLW       _macAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_mac+0 
	MOVLW       hi_addr(_macAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_mac+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_ip+1 
	MOVLW       1
	MOVWF       FARG_SPI_Ethernet_Init_fullDuplex+0 
	CALL        _SPI_Ethernet_Init+0, 0
;SE9M.c,2827 :: 		SPI_Ethernet_confNetwork(ipMask, gwIpAddr, dnsIpAddr) ;
	MOVLW       _ipMask+0
	MOVWF       FARG_SPI_Ethernet_confNetwork_ipMask+0 
	MOVLW       hi_addr(_ipMask+0)
	MOVWF       FARG_SPI_Ethernet_confNetwork_ipMask+1 
	MOVLW       _gwIpAddr+0
	MOVWF       FARG_SPI_Ethernet_confNetwork_gwIpAddr+0 
	MOVLW       hi_addr(_gwIpAddr+0)
	MOVWF       FARG_SPI_Ethernet_confNetwork_gwIpAddr+1 
	MOVLW       _dnsIpAddr+0
	MOVWF       FARG_SPI_Ethernet_confNetwork_dnsIpAddr+0 
	MOVLW       hi_addr(_dnsIpAddr+0)
	MOVWF       FARG_SPI_Ethernet_confNetwork_dnsIpAddr+1 
	CALL        _SPI_Ethernet_confNetwork+0, 0
;SE9M.c,2828 :: 		Print_IP();
	CALL        _Print_IP+0, 0
;SE9M.c,2829 :: 		}
L_main502:
;SE9M.c,2830 :: 		tacka1 = 0;
	CLRF        _tacka1+0 
;SE9M.c,2831 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2833 :: 		}
L_main497:
;SE9M.c,2836 :: 		if (Eth1_Link == 1) {
	BTFSS       RB5_bit+0, BitPos(RB5_bit+0) 
	GOTO        L_main503
;SE9M.c,2837 :: 		link = 0;
	CLRF        _link+0 
;SE9M.c,2839 :: 		}
L_main503:
;SE9M.c,2841 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2844 :: 		if (req_tmr_3 == 12) {
	MOVF        _req_tmr_3+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_main504
;SE9M.c,2845 :: 		sntpSync = 0;
	CLRF        _sntpSync+0 
;SE9M.c,2846 :: 		req_tmr_1 = 0;
	CLRF        _req_tmr_1+0 
;SE9M.c,2847 :: 		req_tmr_2 = 0;
	CLRF        _req_tmr_2+0 
;SE9M.c,2848 :: 		req_tmr_3 = 0;
	CLRF        _req_tmr_3+0 
;SE9M.c,2849 :: 		}
L_main504:
;SE9M.c,2852 :: 		if (RSTPIN == 0) {
	BTFSC       RD4_bit+0, BitPos(RD4_bit+0) 
	GOTO        L_main505
;SE9M.c,2853 :: 		rst_fab_tmr = 1;
	MOVLW       1
	MOVWF       _rst_fab_tmr+0 
;SE9M.c,2854 :: 		} else {
	GOTO        L_main506
L_main505:
;SE9M.c,2855 :: 		rst_fab_tmr = 0;
	CLRF        _rst_fab_tmr+0 
;SE9M.c,2856 :: 		rst_fab_flag = 0;
	CLRF        _rst_fab_flag+0 
;SE9M.c,2857 :: 		}
L_main506:
;SE9M.c,2858 :: 		if (rst_fab_flag >= 5) {
	MOVLW       5
	SUBWF       _rst_fab_flag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main507
;SE9M.c,2859 :: 		rst_fab_tmr = 0;
	CLRF        _rst_fab_tmr+0 
;SE9M.c,2860 :: 		rst_fab_flag = 0;
	CLRF        _rst_fab_flag+0 
;SE9M.c,2861 :: 		rst_fab = 1;
	MOVLW       1
	MOVWF       _rst_fab+0 
;SE9M.c,2862 :: 		Rst_Eth();
	CALL        _Rst_Eth+0, 0
;SE9M.c,2863 :: 		}
L_main507:
;SE9M.c,2865 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2868 :: 		if (komgotovo == 1) {
	MOVF        _komgotovo+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main508
;SE9M.c,2869 :: 		komgotovo = 0;
	CLRF        _komgotovo+0 
;SE9M.c,2870 :: 		chksum = (comand[3] ^ comand[4] ^ comand[5] ^ comand[6] ^ comand[7] ^comand[8] ^ comand[9] ^ comand[10] ^ comand[11]) & 0x7F;
	MOVF        _comand+4, 0 
	XORWF       _comand+3, 0 
	MOVWF       _chksum+0 
	MOVF        _comand+5, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+6, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+7, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+8, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+9, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+10, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+11, 0 
	XORWF       _chksum+0, 1 
	MOVLW       127
	ANDWF       _chksum+0, 1 
;SE9M.c,2871 :: 		if ((comand[0] == 0xAA) && (comand[1] == 0xAA) && (comand[2] == 0xAA) && (comand[12] == chksum) && (comand[13] == 0xBB) && (link_enable == 1)) {
	MOVF        _comand+0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main511
	MOVF        _comand+1, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main511
	MOVF        _comand+2, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main511
	MOVF        _comand+12, 0 
	XORWF       _chksum+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main511
	MOVF        _comand+13, 0 
	XORLW       187
	BTFSS       STATUS+0, 2 
	GOTO        L_main511
	MOVF        _link_enable+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main511
L__main581:
;SE9M.c,2872 :: 		sati = comand[3];
	MOVF        _comand+3, 0 
	MOVWF       _sati+0 
;SE9M.c,2873 :: 		minuti = comand[4];
	MOVF        _comand+4, 0 
	MOVWF       _minuti+0 
;SE9M.c,2874 :: 		sekundi = comand[5];
	MOVF        _comand+5, 0 
	MOVWF       _sekundi+0 
;SE9M.c,2875 :: 		dan = comand[6];
	MOVF        _comand+6, 0 
	MOVWF       _dan+0 
;SE9M.c,2876 :: 		mesec = comand[7];
	MOVF        _comand+7, 0 
	MOVWF       _mesec+0 
;SE9M.c,2877 :: 		fingodina = comand[8];
	MOVF        _comand+8, 0 
	MOVWF       _fingodina+0 
;SE9M.c,2878 :: 		notime = 0;
	CLRF        _notime+0 
;SE9M.c,2879 :: 		notime_ovf = 0;
	CLRF        _notime_ovf+0 
;SE9M.c,2880 :: 		}
L_main511:
;SE9M.c,2881 :: 		}
L_main508:
;SE9M.c,2883 :: 		if (pom_mat_sek != sekundi) {
	MOVF        _pom_mat_sek+0, 0 
	XORWF       _sekundi+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main512
;SE9M.c,2884 :: 		pom_mat_sek = sekundi;
	MOVF        _sekundi+0, 0 
	MOVWF       _pom_mat_sek+0 
;SE9M.c,2885 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2887 :: 		if (disp_mode == 1) {
	MOVF        _disp_mode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main513
;SE9M.c,2888 :: 		tacka2 = 0;
	CLRF        _tacka2+0 
;SE9M.c,2889 :: 		if (tacka1 == 0) {
	MOVF        _tacka1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main514
;SE9M.c,2890 :: 		tacka1 = 1;
	MOVLW       1
	MOVWF       _tacka1+0 
;SE9M.c,2891 :: 		goto DALJE2;
	GOTO        ___main_DALJE2
;SE9M.c,2892 :: 		}
L_main514:
;SE9M.c,2893 :: 		if (tacka1 == 1) {
	MOVF        _tacka1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main515
;SE9M.c,2894 :: 		tacka1 = 0;
	CLRF        _tacka1+0 
;SE9M.c,2895 :: 		goto DALJE2;
	GOTO        ___main_DALJE2
;SE9M.c,2896 :: 		}
L_main515:
;SE9M.c,2897 :: 		DALJE2:
___main_DALJE2:
;SE9M.c,2898 :: 		bljump = 0;
	CLRF        _bljump+0 
;SE9M.c,2899 :: 		}
L_main513:
;SE9M.c,2900 :: 		if (disp_mode == 2) {
	MOVF        _disp_mode+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main516
;SE9M.c,2901 :: 		tacka1 = 0;
	CLRF        _tacka1+0 
;SE9M.c,2902 :: 		tacka2 = 1;
	MOVLW       1
	MOVWF       _tacka2+0 
;SE9M.c,2903 :: 		}
L_main516:
;SE9M.c,2904 :: 		if (notime_ovf == 1) {
	MOVF        _notime_ovf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main517
;SE9M.c,2905 :: 		tacka1 = 1;
	MOVLW       1
	MOVWF       _tacka1+0 
;SE9M.c,2906 :: 		tacka2 = 1;
	MOVLW       1
	MOVWF       _tacka2+0 
;SE9M.c,2907 :: 		}
L_main517:
;SE9M.c,2908 :: 		if (notime_ovf == 0) {
	MOVF        _notime_ovf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main518
;SE9M.c,2909 :: 		if ( (sekundi == 0) || (sekundi == 10) || (sekundi == 20) || (sekundi == 30) || (sekundi == 40) || (sekundi == 50) ) {
	MOVF        _sekundi+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__main580
	MOVF        _sekundi+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L__main580
	MOVF        _sekundi+0, 0 
	XORLW       20
	BTFSC       STATUS+0, 2 
	GOTO        L__main580
	MOVF        _sekundi+0, 0 
	XORLW       30
	BTFSC       STATUS+0, 2 
	GOTO        L__main580
	MOVF        _sekundi+0, 0 
	XORLW       40
	BTFSC       STATUS+0, 2 
	GOTO        L__main580
	MOVF        _sekundi+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L__main580
	GOTO        L_main521
L__main580:
;SE9M.c,2910 :: 		Print_Light();
	CALL        _Print_Light+0, 0
;SE9M.c,2911 :: 		}
L_main521:
;SE9M.c,2912 :: 		} else {
	GOTO        L_main522
L_main518:
;SE9M.c,2913 :: 		PWM1_Set_Duty(min_light);
	MOVF        _min_light+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2914 :: 		}
L_main522:
;SE9M.c,2915 :: 		Display_Time();
	CALL        _Display_Time+0, 0
;SE9M.c,2916 :: 		}
L_main512:
;SE9M.c,2918 :: 		Time_epochToDate(epoch + tmzn * 3600, &ts) ;
	MOVF        _tmzn+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _tmzn+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       16
	MOVWF       R4 
	MOVLW       14
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       _epoch+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        R1, 0 
	ADDWFC      _epoch+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _epoch+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _epoch+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVLW       _ts+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,2920 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2921 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,2922 :: 		if (lcdEvent) {
	MOVF        _lcdEvent+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main523
;SE9M.c,2923 :: 		mkLCDLine(1, conf.dhcpen) ; // update lcd: first row
	MOVLW       1
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+0, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2924 :: 		mkLCDLine(2, conf.lcdL2) ; // update lcd: second row
	MOVLW       2
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+1, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2925 :: 		lcdEvent = 0 ;             // clear lcd update flag
	CLRF        _lcdEvent+0 
;SE9M.c,2926 :: 		marquee++ ;                // set marquee pointer
	INFSNZ      _marquee+0, 1 
	INCF        _marquee+1, 1 
;SE9M.c,2927 :: 		}
L_main523:
;SE9M.c,2929 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2930 :: 		}
	GOTO        L_main456
;SE9M.c,2931 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
