/*
  +------------------------------------------------------------------------+
  | Phalcon Framework                                                      |
  +------------------------------------------------------------------------+
  | Copyright (c) 2011-2013 Phalcon Team (http://www.phalconphp.com)       |
  +------------------------------------------------------------------------+
  | This source file is subject to the New BSD License that is bundled     |
  | with this package in the file docs/LICENSE.txt.                        |
  |                                                                        |
  | If you did not receive a copy of the license and are unable to         |
  | obtain it through the world-wide-web, please send an email             |
  | to license@phalconphp.com so we can send you a copy immediately.       |
  +------------------------------------------------------------------------+
  | Authors: Andres Gutierrez <andres@phalconphp.com>                      |
  |          Eduar Carvajal <eduar@phalconphp.com>                         |
  +------------------------------------------------------------------------+
*/

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "php.h"
#include "php_phalcon.h"

#include "scanner.h"

#define KKCTYPE unsigned char
#define KKCURSOR (s->start)
#define KKLIMIT (s->end)
#define KKMARKER q

void phvolt_rtrim(phvolt_scanner_token *token) {

	char *cursor, *removed_str;
	unsigned int i;
	unsigned char ch;

	if (token->len > 0) {

		cursor = token->value;
		cursor += (token->len - 1);
		for (i = token->len; i > 0; i--) {
			ch = (*cursor);
			if (ch == '\t' || ch == '\n' || ch == '\r' || ch == ' ' || ch == '\v') {
				cursor--;
				continue;
			}
			break;
		}

		removed_str = emalloc(i + 1);
		memcpy(removed_str, token->value, i);
		removed_str[i] = '\0';

		efree(token->value);
		token->value = removed_str;
		token->len = i;
	}

}

void phvolt_ltrim(phvolt_scanner_token *token) {

	char *cursor, *removed_str;
	unsigned int i;
	unsigned char ch;

	if (token->len > 0) {

		cursor = token->value;
		for (i = 0; i < token->len; i++) {
			ch = (*cursor);
			if (ch == '\t' || ch == '\n' || ch == '\r' || ch == ' ' || ch == '\v') {
				cursor++;
				continue;
			}
			break;
		}

		removed_str = emalloc(token->len - i + 1);
		memcpy(removed_str, token->value + i, token->len - i);
		removed_str[token->len - i] = '\0';

		efree(token->value);
		token->value = removed_str;
		token->len = token->len - i;
	}

}

int phvolt_get_token(phvolt_scanner_state *s, phvolt_scanner_token *token) {

	unsigned char next, double_next;
	char *q = KKCURSOR, *start = KKCURSOR;
	int status = PHVOLT_SCANNER_RETCODE_IMPOSSIBLE;

	while (PHVOLT_SCANNER_RETCODE_IMPOSSIBLE == status) {

		if (s->mode == PHVOLT_MODE_RAW || s->mode == PHVOLT_MODE_COMMENT) {

			next = '\0';
			double_next = '\0';

			if (*KKCURSOR == '\n') {
				s->active_line++;
			}

			if (*KKCURSOR != '\0') {
				next = *(KKCURSOR + 1);
				if (next != '\0') {
					double_next = *(KKCURSOR + 2);
				}
			}

			if (*KKCURSOR == '\0' || (*KKCURSOR == '{' && (next == '%' || next == '{' || next == '#'))) {

				if (next != '#') {

					s->mode = PHVOLT_MODE_CODE;

					if (s->raw_buffer_cursor > 0) {

						token->opcode = PHVOLT_T_RAW_FRAGMENT;
						token->value = emalloc(sizeof(char) * s->raw_buffer_cursor + 1);
						memcpy(token->value, s->raw_buffer, s->raw_buffer_cursor);
						token->value[s->raw_buffer_cursor] = 0;
						token->len = s->raw_buffer_cursor;

						if (s->whitespace_control == 1) {
							phvolt_ltrim(token);
							s->whitespace_control = 0;
						}

						if (double_next == '-') {
							phvolt_rtrim(token);
						}

						s->raw_buffer_cursor = 0;
						q = KKCURSOR;
					} else {
						token->opcode = PHVOLT_T_IGNORE;
					}

				} else {

					while ((next = *(++KKCURSOR))) {
						if (next == '#' && *(KKCURSOR + 1) == '}') {
							KKCURSOR+=2;
							token->opcode = PHVOLT_T_IGNORE;
							return 0;
						} else {
							if (next == '\n') {
								s->active_line++;
							}
						}
					}

					return PHVOLT_SCANNER_RETCODE_EOF;
				}

				return 0;

			} else {

				if (s->raw_buffer_cursor == s->raw_buffer_size) {
					s->raw_buffer_size += PHVOLT_RAW_BUFFER_SIZE;
					s->raw_buffer = erealloc(s->raw_buffer, s->raw_buffer_size);
				}

				memcpy(s->raw_buffer+s->raw_buffer_cursor, KKCURSOR, 1);
				s->raw_buffer_cursor++;

				++KKCURSOR;
			}

		} else {

		
// 184 "scanner.c"
		{
			KKCTYPE kkch;
			unsigned int kkaccept = 0;

			kkch = *KKCURSOR;
			switch (kkch) {
			case 0x00:	goto kk70;
			case '\t':
			case '\r':
			case ' ':	goto kk66;
			case '\n':	goto kk68;
			case '!':	goto kk58;
			case '"':	goto kk27;
			case '%':	goto kk21;
			case '\'':	goto kk29;
			case '(':	goto kk44;
			case ')':	goto kk46;
			case '*':	goto kk34;
			case '+':	goto kk32;
			case ',':	goto kk42;
			case '-':	goto kk23;
			case '.':	goto kk40;
			case '/':	goto kk36;
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':	goto kk2;
			case ':':	goto kk62;
			case '<':	goto kk52;
			case '=':	goto kk54;
			case '>':	goto kk56;
			case '?':	goto kk64;
			case 'A':
			case 'a':	goto kk11;
			case 'B':
			case 'b':	goto kk13;
			case 'C':
			case 'c':	goto kk15;
			case 'D':
			case 'd':	goto kk18;
			case 'E':
			case 'e':	goto kk6;
			case 'F':
			case 'f':	goto kk7;
			case 'G':
			case 'H':
			case 'J':
			case 'K':
			case 'L':
			case 'P':
			case 'Q':
			case 'U':
			case 'V':
			case 'X':
			case 'Y':
			case 'Z':
			case '_':
			case 'g':
			case 'h':
			case 'j':
			case 'k':
			case 'l':
			case 'p':
			case 'q':
			case 'u':
			case 'v':
			case 'x':
			case 'y':
			case 'z':	goto kk31;
			case 'I':
			case 'i':	goto kk4;
			case 'M':
			case 'm':	goto kk14;
			case 'N':
			case 'n':	goto kk9;
			case 'O':
			case 'o':	goto kk12;
			case 'R':
			case 'r':	goto kk17;
			case 'S':
			case 's':	goto kk8;
			case 'T':
			case 't':	goto kk10;
			case 'W':
			case 'w':	goto kk16;
			case '[':	goto kk48;
			case '\\':	goto kk30;
			case ']':	goto kk50;
			case '{':	goto kk19;
			case '|':	goto kk60;
			case '}':	goto kk25;
			case '~':	goto kk38;
			default:	goto kk72;
			}
kk2:
			kkaccept = 0;
			kkch = *(KKMARKER = ++KKCURSOR);
			goto kk292;
kk3:
// 185 "scanner.re"
			{
			token->opcode = PHVOLT_T_INTEGER;
			token->value = estrndup(start, KKCURSOR - start);
			token->len = KKCURSOR - start;
			q = KKCURSOR;
			return 0;
		}
// 298 "scanner.c"
kk4:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case 'F':
			case 'f':	goto kk278;
			case 'N':
			case 'n':	goto kk280;
			case 'S':
			case 's':	goto kk282;
			default:	goto kk100;
			}
kk5:
// 450 "scanner.re"
			{
			token->opcode = PHVOLT_T_IDENTIFIER;
			token->value = estrndup(start, KKCURSOR - start);
			token->len = KKCURSOR - start;
			q = KKCURSOR;
			return 0;
		}
// 319 "scanner.c"
kk6:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'L':
			case 'l':	goto kk219;
			case 'N':
			case 'n':	goto kk220;
			case 'X':
			case 'x':	goto kk221;
			default:	goto kk100;
			}
kk7:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'A':
			case 'a':	goto kk211;
			case 'O':
			case 'o':	goto kk212;
			default:	goto kk100;
			}
kk8:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk208;
			default:	goto kk100;
			}
kk9:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'O':
			case 'o':	goto kk201;
			case 'U':
			case 'u':	goto kk202;
			default:	goto kk100;
			}
kk10:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'R':
			case 'r':	goto kk197;
			default:	goto kk100;
			}
kk11:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'N':
			case 'n':	goto kk184;
			case 'U':
			case 'u':	goto kk185;
			default:	goto kk100;
			}
kk12:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'R':
			case 'r':	goto kk182;
			default:	goto kk100;
			}
kk13:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'L':
			case 'l':	goto kk172;
			case 'R':
			case 'r':	goto kk173;
			default:	goto kk100;
			}
kk14:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'A':
			case 'a':	goto kk167;
			default:	goto kk100;
			}
kk15:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'A':
			case 'a':	goto kk151;
			case 'O':
			case 'o':	goto kk152;
			default:	goto kk100;
			}
kk16:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'I':
			case 'i':	goto kk147;
			default:	goto kk100;
			}
kk17:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk141;
			default:	goto kk100;
			}
kk18:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk132;
			case 'O':
			case 'o':	goto kk133;
			default:	goto kk100;
			}
kk19:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '%':	goto kk126;
			case '{':	goto kk124;
			default:	goto kk20;
			}
kk20:
// 533 "scanner.re"
			{
			token->opcode = PHVOLT_T_CBRACKET_OPEN;
			return 0;
		}
// 440 "scanner.c"
kk21:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '}':	goto kk122;
			default:	goto kk22;
			}
kk22:
// 478 "scanner.re"
			{
			token->opcode = PHVOLT_T_MOD;
			return 0;
		}
// 453 "scanner.c"
kk23:
			kkaccept = 1;
			kkch = *(KKMARKER = ++KKCURSOR);
			switch (kkch) {
			case '%':	goto kk117;
			case '-':	goto kk114;
			case '=':	goto kk112;
			case '}':	goto kk116;
			default:	goto kk24;
			}
kk24:
// 463 "scanner.re"
			{
			token->opcode = PHVOLT_T_SUB;
			return 0;
		}
// 470 "scanner.c"
kk25:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '}':	goto kk110;
			default:	goto kk26;
			}
kk26:
// 538 "scanner.re"
			{
			token->opcode = PHVOLT_T_CBRACKET_CLOSE;
			return 0;
		}
// 483 "scanner.c"
kk27:
			kkaccept = 2;
			kkch = *(KKMARKER = ++KKCURSOR);
			if (kkch >= 0x01) goto kk108;
kk28:
// 649 "scanner.re"
			{
			status = PHVOLT_SCANNER_RETCODE_ERR;
			break;
		}
// 494 "scanner.c"
kk29:
			kkaccept = 2;
			kkch = *(KKMARKER = ++KKCURSOR);
			if (kkch <= 0x00) goto kk28;
			goto kk102;
kk30:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk28;
			}
kk31:
			kkch = *++KKCURSOR;
			goto kk100;
kk32:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '+':	goto kk97;
			case '=':	goto kk95;
			default:	goto kk33;
			}
kk33:
// 458 "scanner.re"
			{
			token->opcode = PHVOLT_T_ADD;
			return 0;
		}
// 574 "scanner.c"
kk34:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '=':	goto kk93;
			default:	goto kk35;
			}
kk35:
// 468 "scanner.re"
			{
			token->opcode = PHVOLT_T_MUL;
			return 0;
		}
// 587 "scanner.c"
kk36:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '=':	goto kk91;
			default:	goto kk37;
			}
kk37:
// 473 "scanner.re"
			{
			token->opcode = PHVOLT_T_DIV;
			return 0;
		}
// 600 "scanner.c"
kk38:
			++KKCURSOR;
// 493 "scanner.re"
			{
			token->opcode = PHVOLT_T_CONCAT;
			return 0;
		}
// 608 "scanner.c"
kk40:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '.':	goto kk89;
			default:	goto kk41;
			}
kk41:
// 503 "scanner.re"
			{
			token->opcode = PHVOLT_T_DOT;
			return 0;
		}
// 621 "scanner.c"
kk42:
			++KKCURSOR;
// 508 "scanner.re"
			{
			token->opcode = PHVOLT_T_COMMA;
			return 0;
		}
// 629 "scanner.c"
kk44:
			++KKCURSOR;
// 513 "scanner.re"
			{
			token->opcode = PHVOLT_T_PARENTHESES_OPEN;
			return 0;
		}
// 637 "scanner.c"
kk46:
			++KKCURSOR;
// 518 "scanner.re"
			{
			token->opcode = PHVOLT_T_PARENTHESES_CLOSE;
			return 0;
		}
// 645 "scanner.c"
kk48:
			++KKCURSOR;
// 523 "scanner.re"
			{
			token->opcode = PHVOLT_T_SBRACKET_OPEN;
			return 0;
		}
// 653 "scanner.c"
kk50:
			++KKCURSOR;
// 528 "scanner.re"
			{
			token->opcode = PHVOLT_T_SBRACKET_CLOSE;
			return 0;
		}
// 661 "scanner.c"
kk52:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '=':	goto kk87;
			case '>':	goto kk85;
			default:	goto kk53;
			}
kk53:
// 608 "scanner.re"
			{
			token->opcode = PHVOLT_T_LESS;
			return 0;
		}
// 675 "scanner.c"
kk54:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '=':	goto kk81;
			default:	goto kk55;
			}
kk55:
// 548 "scanner.re"
			{
			token->opcode = PHVOLT_T_ASSIGN;
			return 0;
		}
// 688 "scanner.c"
kk56:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '=':	goto kk79;
			default:	goto kk57;
			}
kk57:
// 613 "scanner.re"
			{
			token->opcode = PHVOLT_T_GREATER;
			return 0;
		}
// 701 "scanner.c"
kk58:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '=':	goto kk75;
			default:	goto kk59;
			}
kk59:
// 603 "scanner.re"
			{
			token->opcode = PHVOLT_T_NOT;
			return 0;
		}
// 714 "scanner.c"
kk60:
			++KKCURSOR;
// 618 "scanner.re"
			{
			token->opcode = PHVOLT_T_PIPE;
			return 0;
		}
// 722 "scanner.c"
kk62:
			++KKCURSOR;
// 623 "scanner.re"
			{
			token->opcode = PHVOLT_T_COLON;
			return 0;
		}
// 730 "scanner.c"
kk64:
			++KKCURSOR;
// 628 "scanner.re"
			{
			token->opcode = PHVOLT_T_QUESTION;
			return 0;
		}
// 738 "scanner.c"
kk66:
			++KKCURSOR;
			kkch = *KKCURSOR;
			goto kk74;
kk67:
// 633 "scanner.re"
			{
			token->opcode = PHVOLT_T_IGNORE;
			return 0;
		}
// 749 "scanner.c"
kk68:
			++KKCURSOR;
// 638 "scanner.re"
			{
			s->active_line++;
			token->opcode = PHVOLT_T_IGNORE;
			return 0;
		}
// 758 "scanner.c"
kk70:
			++KKCURSOR;
// 644 "scanner.re"
			{
			status = PHVOLT_SCANNER_RETCODE_EOF;
			break;
		}
// 766 "scanner.c"
kk72:
			kkch = *++KKCURSOR;
			goto kk28;
kk73:
			++KKCURSOR;
			kkch = *KKCURSOR;
kk74:
			switch (kkch) {
			case '\t':
			case '\r':
			case ' ':	goto kk73;
			default:	goto kk67;
			}
kk75:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '=':	goto kk77;
			default:	goto kk76;
			}
kk76:
// 583 "scanner.re"
			{
			token->opcode = PHVOLT_T_NOTEQUALS;
			return 0;
		}
// 792 "scanner.c"
kk77:
			++KKCURSOR;
// 598 "scanner.re"
			{
			token->opcode = PHVOLT_T_NOTIDENTICAL;
			return 0;
		}
// 800 "scanner.c"
kk79:
			++KKCURSOR;
// 573 "scanner.re"
			{
			token->opcode = PHVOLT_T_GREATEREQUAL;
			return 0;
		}
// 808 "scanner.c"
kk81:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '=':	goto kk83;
			default:	goto kk82;
			}
kk82:
// 578 "scanner.re"
			{
			token->opcode = PHVOLT_T_EQUALS;
			return 0;
		}
// 821 "scanner.c"
kk83:
			++KKCURSOR;
// 593 "scanner.re"
			{
			token->opcode = PHVOLT_T_IDENTICAL;
			return 0;
		}
// 829 "scanner.c"
kk85:
			++KKCURSOR;
// 588 "scanner.re"
			{
			token->opcode = PHVOLT_T_NOTEQUALS;
			return 0;
		}
// 837 "scanner.c"
kk87:
			++KKCURSOR;
// 543 "scanner.re"
			{
			token->opcode = PHVOLT_T_LESSEQUAL;
			return 0;
		}
// 845 "scanner.c"
kk89:
			++KKCURSOR;
// 498 "scanner.re"
			{
			token->opcode = PHVOLT_T_RANGE;
			return 0;
		}
// 853 "scanner.c"
kk91:
			++KKCURSOR;
// 568 "scanner.re"
			{
			token->opcode = PHVOLT_T_DIV_ASSIGN;
			return 0;
		}
// 861 "scanner.c"
kk93:
			++KKCURSOR;
// 563 "scanner.re"
			{
			token->opcode = PHVOLT_T_MUL_ASSIGN;
			return 0;
		}
// 869 "scanner.c"
kk95:
			++KKCURSOR;
// 553 "scanner.re"
			{
			token->opcode = PHVOLT_T_ADD_ASSIGN;
			return 0;
		}
// 877 "scanner.c"
kk97:
			++KKCURSOR;
// 483 "scanner.re"
			{
			token->opcode = PHVOLT_T_INCR;
			return 0;
		}
// 885 "scanner.c"
kk99:
			++KKCURSOR;
			kkch = *KKCURSOR;
kk100:
			switch (kkch) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk5;
			}
kk101:
			++KKCURSOR;
			kkch = *KKCURSOR;
kk102:
			switch (kkch) {
			case 0x00:	goto kk103;
			case '\'':	goto kk105;
			case '\\':	goto kk104;
			default:	goto kk101;
			}
kk103:
			KKCURSOR = KKMARKER;
			switch (kkaccept) {
			case 0: 	goto kk3;
			case 1: 	goto kk24;
			case 2: 	goto kk28;
			}
kk104:
			++KKCURSOR;
			kkch = *KKCURSOR;
			switch (kkch) {
			case '\n':	goto kk103;
			default:	goto kk101;
			}
kk105:
			++KKCURSOR;
// 441 "scanner.re"
			{
			token->opcode = PHVOLT_T_STRING;
			token->value = estrndup(q, KKCURSOR - q - 1);
			token->len = KKCURSOR - q - 1;
			q = KKCURSOR;
			return 0;
		}
// 991 "scanner.c"
kk107:
			++KKCURSOR;
			kkch = *KKCURSOR;
kk108:
			switch (kkch) {
			case 0x00:	goto kk103;
			case '"':	goto kk105;
			case '\\':	goto kk109;
			default:	goto kk107;
			}
kk109:
			++KKCURSOR;
			kkch = *KKCURSOR;
			switch (kkch) {
			case '\n':	goto kk103;
			default:	goto kk107;
			}
kk110:
			++KKCURSOR;
// 420 "scanner.re"
			{
			s->mode = PHVOLT_MODE_RAW;
			token->opcode = PHVOLT_T_CLOSE_EDELIMITER;
			return 0;
		}
// 1017 "scanner.c"
kk112:
			++KKCURSOR;
// 558 "scanner.re"
			{
			token->opcode = PHVOLT_T_SUB_ASSIGN;
			return 0;
		}
// 1025 "scanner.c"
kk114:
			++KKCURSOR;
// 488 "scanner.re"
			{
			token->opcode = PHVOLT_T_DECR;
			return 0;
		}
// 1033 "scanner.c"
kk116:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case '}':	goto kk120;
			default:	goto kk103;
			}
kk117:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case '}':	goto kk118;
			default:	goto kk103;
			}
kk118:
			++KKCURSOR;
// 406 "scanner.re"
			{
			s->mode = PHVOLT_MODE_RAW;
			s->whitespace_control = 1;
			token->opcode = PHVOLT_T_CLOSE_DELIMITER;
			return 0;
		}
// 1055 "scanner.c"
kk120:
			++KKCURSOR;
// 433 "scanner.re"
			{
			s->mode = PHVOLT_MODE_RAW;
			s->whitespace_control = 1;
			token->opcode = PHVOLT_T_CLOSE_EDELIMITER;
			return 0;
		}
// 1065 "scanner.c"
kk122:
			++KKCURSOR;
// 394 "scanner.re"
			{
			s->mode = PHVOLT_MODE_RAW;
			token->opcode = PHVOLT_T_CLOSE_DELIMITER;
			return 0;
		}
// 1074 "scanner.c"
kk124:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '-':	goto kk130;
			default:	goto kk125;
			}
kk125:
// 413 "scanner.re"
			{
			s->whitespace_control = 0;
			s->statement_position++;
			token->opcode = PHVOLT_T_OPEN_EDELIMITER;
			return 0;
		}
// 1089 "scanner.c"
kk126:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '-':	goto kk128;
			default:	goto kk127;
			}
kk127:
// 388 "scanner.re"
			{
			s->whitespace_control = 0;
			token->opcode = PHVOLT_T_OPEN_DELIMITER;
			return 0;
		}
// 1103 "scanner.c"
kk128:
			++KKCURSOR;
// 400 "scanner.re"
			{
			s->whitespace_control = 0;
			token->opcode = PHVOLT_T_OPEN_DELIMITER;
			return 0;
		}
// 1112 "scanner.c"
kk130:
			++KKCURSOR;
// 426 "scanner.re"
			{
			s->whitespace_control = 0;
			s->statement_position++;
			token->opcode = PHVOLT_T_OPEN_EDELIMITER;
			return 0;
		}
// 1122 "scanner.c"
kk132:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'F':
			case 'f':	goto kk135;
			default:	goto kk100;
			}
kk133:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk134;
			}
kk134:
// 358 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_DO;
			return 0;
		}
// 1206 "scanner.c"
kk135:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'I':
			case 'i':	goto kk136;
			default:	goto kk100;
			}
kk136:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'N':
			case 'n':	goto kk137;
			default:	goto kk100;
			}
kk137:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk138;
			default:	goto kk100;
			}
kk138:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'D':
			case 'd':	goto kk139;
			default:	goto kk100;
			}
kk139:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk140;
			}
kk140:
// 335 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_DEFINED;
			return 0;
		}
// 1311 "scanner.c"
kk141:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'T':
			case 't':	goto kk142;
			default:	goto kk100;
			}
kk142:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'U':
			case 'u':	goto kk143;
			default:	goto kk100;
			}
kk143:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'R':
			case 'r':	goto kk144;
			default:	goto kk100;
			}
kk144:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'N':
			case 'n':	goto kk145;
			default:	goto kk100;
			}
kk145:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk146;
			}
kk146:
// 312 "scanner.re"
			{
			token->opcode = PHVOLT_T_RETURN;
			return 0;
		}
// 1415 "scanner.c"
kk147:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'T':
			case 't':	goto kk148;
			default:	goto kk100;
			}
kk148:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'H':
			case 'h':	goto kk149;
			default:	goto kk100;
			}
kk149:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk150;
			}
kk150:
// 307 "scanner.re"
			{
			token->opcode = PHVOLT_T_WITH;
			return 0;
		}
// 1505 "scanner.c"
kk151:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'C':
			case 'c':	goto kk161;
			case 'L':
			case 'l':	goto kk160;
			default:	goto kk100;
			}
kk152:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'N':
			case 'n':	goto kk153;
			default:	goto kk100;
			}
kk153:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'T':
			case 't':	goto kk154;
			default:	goto kk100;
			}
kk154:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'I':
			case 'i':	goto kk155;
			default:	goto kk100;
			}
kk155:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'N':
			case 'n':	goto kk156;
			default:	goto kk100;
			}
kk156:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'U':
			case 'u':	goto kk157;
			default:	goto kk100;
			}
kk157:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk158;
			default:	goto kk100;
			}
kk158:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk159;
			}
kk159:
// 376 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_CONTINUE;
			return 0;
		}
// 1633 "scanner.c"
kk160:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'L':
			case 'l':	goto kk165;
			default:	goto kk100;
			}
kk161:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'H':
			case 'h':	goto kk162;
			default:	goto kk100;
			}
kk162:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk163;
			default:	goto kk100;
			}
kk163:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk164;
			}
kk164:
// 347 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_CACHE;
			return 0;
		}
// 1731 "scanner.c"
kk165:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk166;
			}
kk166:
// 296 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_CALL;
			return 0;
		}
// 1808 "scanner.c"
kk167:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'C':
			case 'c':	goto kk168;
			default:	goto kk100;
			}
kk168:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'R':
			case 'r':	goto kk169;
			default:	goto kk100;
			}
kk169:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'O':
			case 'o':	goto kk170;
			default:	goto kk100;
			}
kk170:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk171;
			}
kk171:
// 285 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_MACRO;
			return 0;
		}
// 1906 "scanner.c"
kk172:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'O':
			case 'o':	goto kk178;
			default:	goto kk100;
			}
kk173:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk174;
			default:	goto kk100;
			}
kk174:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'A':
			case 'a':	goto kk175;
			default:	goto kk100;
			}
kk175:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'K':
			case 'k':	goto kk176;
			default:	goto kk100;
			}
kk176:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk177;
			}
kk177:
// 382 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_BREAK;
			return 0;
		}
// 2011 "scanner.c"
kk178:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'C':
			case 'c':	goto kk179;
			default:	goto kk100;
			}
kk179:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'K':
			case 'k':	goto kk180;
			default:	goto kk100;
			}
kk180:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk181;
			}
kk181:
// 274 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_BLOCK;
			return 0;
		}
// 2102 "scanner.c"
kk182:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk183;
			}
kk183:
// 269 "scanner.re"
			{
			token->opcode = PHVOLT_T_OR;
			return 0;
		}
// 2178 "scanner.c"
kk184:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'D':
			case 'd':	goto kk195;
			default:	goto kk100;
			}
kk185:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'T':
			case 't':	goto kk186;
			default:	goto kk100;
			}
kk186:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'O':
			case 'o':	goto kk187;
			default:	goto kk100;
			}
kk187:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk188;
			default:	goto kk100;
			}
kk188:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'S':
			case 's':	goto kk189;
			default:	goto kk100;
			}
kk189:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'C':
			case 'c':	goto kk190;
			default:	goto kk100;
			}
kk190:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'A':
			case 'a':	goto kk191;
			default:	goto kk100;
			}
kk191:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'P':
			case 'p':	goto kk192;
			default:	goto kk100;
			}
kk192:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk193;
			default:	goto kk100;
			}
kk193:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk194;
			}
kk194:
// 364 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_AUTOESCAPE;
			return 0;
		}
// 2318 "scanner.c"
kk195:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk196;
			}
kk196:
// 264 "scanner.re"
			{
			token->opcode = PHVOLT_T_AND;
			return 0;
		}
// 2394 "scanner.c"
kk197:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'U':
			case 'u':	goto kk198;
			default:	goto kk100;
			}
kk198:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk199;
			default:	goto kk100;
			}
kk199:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk200;
			}
kk200:
// 259 "scanner.re"
			{
			token->opcode = PHVOLT_T_TRUE;
			return 0;
		}
// 2484 "scanner.c"
kk201:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'T':
			case 't':	goto kk206;
			default:	goto kk100;
			}
kk202:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'L':
			case 'l':	goto kk203;
			default:	goto kk100;
			}
kk203:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'L':
			case 'l':	goto kk204;
			default:	goto kk100;
			}
kk204:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk205;
			}
kk205:
// 249 "scanner.re"
			{
			token->opcode = PHVOLT_T_NULL;
			return 0;
		}
// 2581 "scanner.c"
kk206:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk207;
			}
kk207:
// 329 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_NOT;
			return 0;
		}
// 2658 "scanner.c"
kk208:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'T':
			case 't':	goto kk209;
			default:	goto kk100;
			}
kk209:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk210;
			}
kk210:
// 244 "scanner.re"
			{
			token->opcode = PHVOLT_T_SET;
			return 0;
		}
// 2741 "scanner.c"
kk211:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'L':
			case 'l':	goto kk215;
			default:	goto kk100;
			}
kk212:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'R':
			case 'r':	goto kk213;
			default:	goto kk100;
			}
kk213:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk214;
			}
kk214:
// 228 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_FOR;
			return 0;
		}
// 2832 "scanner.c"
kk215:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'S':
			case 's':	goto kk216;
			default:	goto kk100;
			}
kk216:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk217;
			default:	goto kk100;
			}
kk217:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk218;
			}
kk218:
// 254 "scanner.re"
			{
			token->opcode = PHVOLT_T_FALSE;
			return 0;
		}
// 2922 "scanner.c"
kk219:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'S':
			case 's':	goto kk268;
			default:	goto kk100;
			}
kk220:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'D':
			case 'd':	goto kk228;
			default:	goto kk100;
			}
kk221:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'T':
			case 't':	goto kk222;
			default:	goto kk100;
			}
kk222:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk223;
			default:	goto kk100;
			}
kk223:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'N':
			case 'n':	goto kk224;
			default:	goto kk100;
			}
kk224:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'D':
			case 'd':	goto kk225;
			default:	goto kk100;
			}
kk225:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'S':
			case 's':	goto kk226;
			default:	goto kk100;
			}
kk226:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk227;
			}
kk227:
// 317 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_EXTENDS;
			return 0;
		}
// 3048 "scanner.c"
kk228:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'A':
			case 'a':	goto kk229;
			case 'B':
			case 'b':	goto kk230;
			case 'C':
			case 'c':	goto kk231;
			case 'F':
			case 'f':	goto kk232;
			case 'I':
			case 'i':	goto kk233;
			case 'M':
			case 'm':	goto kk234;
			default:	goto kk100;
			}
kk229:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'U':
			case 'u':	goto kk258;
			default:	goto kk100;
			}
kk230:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'L':
			case 'l':	goto kk253;
			default:	goto kk100;
			}
kk231:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'A':
			case 'a':	goto kk245;
			default:	goto kk100;
			}
kk232:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'O':
			case 'o':	goto kk242;
			default:	goto kk100;
			}
kk233:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'F':
			case 'f':	goto kk240;
			default:	goto kk100;
			}
kk234:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'A':
			case 'a':	goto kk235;
			default:	goto kk100;
			}
kk235:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'C':
			case 'c':	goto kk236;
			default:	goto kk100;
			}
kk236:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'R':
			case 'r':	goto kk237;
			default:	goto kk100;
			}
kk237:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'O':
			case 'o':	goto kk238;
			default:	goto kk100;
			}
kk238:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk239;
			}
kk239:
// 291 "scanner.re"
			{
			token->opcode = PHVOLT_T_ENDMACRO;
			return 0;
		}
// 3204 "scanner.c"
kk240:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk241;
			}
kk241:
// 223 "scanner.re"
			{
			token->opcode = PHVOLT_T_ENDIF;
			return 0;
		}
// 3280 "scanner.c"
kk242:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'R':
			case 'r':	goto kk243;
			default:	goto kk100;
			}
kk243:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk244;
			}
kk244:
// 234 "scanner.re"
			{
			token->opcode = PHVOLT_T_ENDFOR;
			return 0;
		}
// 3363 "scanner.c"
kk245:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'C':
			case 'c':	goto kk246;
			case 'L':
			case 'l':	goto kk247;
			default:	goto kk100;
			}
kk246:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'H':
			case 'h':	goto kk250;
			default:	goto kk100;
			}
kk247:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'L':
			case 'l':	goto kk248;
			default:	goto kk100;
			}
kk248:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk249;
			}
kk249:
// 302 "scanner.re"
			{
			token->opcode = PHVOLT_T_ENDCALL;
			return 0;
		}
// 3462 "scanner.c"
kk250:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk251;
			default:	goto kk100;
			}
kk251:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk252;
			}
kk252:
// 353 "scanner.re"
			{
			token->opcode = PHVOLT_T_ENDCACHE;
			return 0;
		}
// 3545 "scanner.c"
kk253:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'O':
			case 'o':	goto kk254;
			default:	goto kk100;
			}
kk254:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'C':
			case 'c':	goto kk255;
			default:	goto kk100;
			}
kk255:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'K':
			case 'k':	goto kk256;
			default:	goto kk100;
			}
kk256:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk257;
			}
kk257:
// 280 "scanner.re"
			{
			token->opcode = PHVOLT_T_ENDBLOCK;
			return 0;
		}
// 3642 "scanner.c"
kk258:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'T':
			case 't':	goto kk259;
			default:	goto kk100;
			}
kk259:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'O':
			case 'o':	goto kk260;
			default:	goto kk100;
			}
kk260:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk261;
			default:	goto kk100;
			}
kk261:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'S':
			case 's':	goto kk262;
			default:	goto kk100;
			}
kk262:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'C':
			case 'c':	goto kk263;
			default:	goto kk100;
			}
kk263:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'A':
			case 'a':	goto kk264;
			default:	goto kk100;
			}
kk264:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'P':
			case 'p':	goto kk265;
			default:	goto kk100;
			}
kk265:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk266;
			default:	goto kk100;
			}
kk266:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk267;
			}
kk267:
// 370 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_ENDAUTOESCAPE;
			return 0;
		}
// 3775 "scanner.c"
kk268:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk269;
			default:	goto kk100;
			}
kk269:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'G':
			case 'H':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'g':
			case 'h':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			case 'F':
			case 'f':	goto kk271;
			case 'I':
			case 'i':	goto kk272;
			default:	goto kk270;
			}
kk270:
// 208 "scanner.re"
			{
			token->opcode = PHVOLT_T_ELSE;
			return 0;
		}
// 3858 "scanner.c"
kk271:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'O':
			case 'o':	goto kk275;
			default:	goto kk100;
			}
kk272:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'F':
			case 'f':	goto kk273;
			default:	goto kk100;
			}
kk273:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk274;
			}
kk274:
// 218 "scanner.re"
			{
			token->opcode = PHVOLT_T_ELSEIF;
			return 0;
		}
// 3948 "scanner.c"
kk275:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'R':
			case 'r':	goto kk276;
			default:	goto kk100;
			}
kk276:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk277;
			}
kk277:
// 213 "scanner.re"
			{
			token->opcode = PHVOLT_T_ELSEFOR;
			return 0;
		}
// 4031 "scanner.c"
kk278:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk279;
			}
kk279:
// 202 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_IF;
			return 0;
		}
// 4108 "scanner.c"
kk280:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			case 'C':
			case 'c':	goto kk284;
			default:	goto kk281;
			}
kk281:
// 239 "scanner.re"
			{
			token->opcode = PHVOLT_T_IN;
			return 0;
		}
// 4184 "scanner.c"
kk282:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk283;
			}
kk283:
// 323 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_IS;
			return 0;
		}
// 4261 "scanner.c"
kk284:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'L':
			case 'l':	goto kk285;
			default:	goto kk100;
			}
kk285:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'U':
			case 'u':	goto kk286;
			default:	goto kk100;
			}
kk286:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'D':
			case 'd':	goto kk287;
			default:	goto kk100;
			}
kk287:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case 'E':
			case 'e':	goto kk288;
			default:	goto kk100;
			}
kk288:
			++KKCURSOR;
			switch ((kkch = *KKCURSOR)) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case '\\':
			case '_':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':	goto kk99;
			default:	goto kk289;
			}
kk289:
// 341 "scanner.re"
			{
			s->statement_position++;
			token->opcode = PHVOLT_T_INCLUDE;
			return 0;
		}
// 4366 "scanner.c"
kk290:
			kkch = *++KKCURSOR;
			switch (kkch) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':	goto kk293;
			default:	goto kk103;
			}
kk291:
			kkaccept = 0;
			KKMARKER = ++KKCURSOR;
			kkch = *KKCURSOR;
kk292:
			switch (kkch) {
			case '.':	goto kk290;
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':	goto kk291;
			default:	goto kk3;
			}
kk293:
			++KKCURSOR;
			kkch = *KKCURSOR;
			switch (kkch) {
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':	goto kk293;
			default:	goto kk295;
			}
kk295:
// 194 "scanner.re"
			{
			token->opcode = PHVOLT_T_DOUBLE;
			token->value = estrndup(start, KKCURSOR - start);
			token->len = KKCURSOR - start;
			q = KKCURSOR;
			return 0;
		}
// 4426 "scanner.c"
		}
// 654 "scanner.re"


		}
	}

	return status;
}