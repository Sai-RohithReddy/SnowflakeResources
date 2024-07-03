-- Detailed explanation about Regular Expressions is given in below page.
-- https://docs.snowflake.com/en/sql-reference/functions-regexp

-- Set up sample data

CREATE TABLE PUBLIC.REGEXP(text varchar(100));

INSERT INTO PUBLIC.REGEXP(text) VALUES
('Snowflake'),
('Snow flake'),
('Snow-flake'),
('Snow123flake'),
('Snowflake Regexp'),
('Regular Expression'),
('Snowflake contains 3 layers'),
('Regexp with \\backslash'),
('12345');

SELECT * FROM PUBLIC.REGEXP;

/* ----------
1. REGEXP - Returns true if the subject matches the specified pattern. 
Both inputs must be text expressions
---------- */

-- To search all the strings starts with word Snow
SELECT text from PUBLIC.REGEXP where text REGEXP 'Snow.*';

-- To search all the strings starts with word Regexp
SELECT text from PUBLIC.REGEXP where text REGEXP 'Regexp.*';

-- To search all the strings that contains word Regexp
SELECT text from PUBLIC.REGEXP where text REGEXP '.*Regexp.*';

-- To search all the strings that contains Digits(0-9)
SELECT text from PUBLIC.REGEXP where text REGEXP '.*\\d.*';
or
SELECT text from PUBLIC.REGEXP where text REGEXP '.*[0-9].*';

-- To search all the strings that starts with Digits(0-9)
SELECT text from PUBLIC.REGEXP where text REGEXP '\\d.*';
or
SELECT text from PUBLIC.REGEXP where text REGEXP '.*^[0-9].*';

-- To search all the strings that contains Spaces
SELECT text from PUBLIC.REGEXP where text REGEXP '.*\\s.*';

-- To search all the strings that matches whole words
SELECT text from PUBLIC.REGEXP where text REGEXP '\\bSnow\\b.*';

-- To search all the strings that contains space followed by backslash
SELECT text from PUBLIC.REGEXP where text REGEXP '.*\\s\\\\.*';


/* ----------
2. REGEXP_COUNT - Returns the number of times that a pattern occurs in a string.
---------- */

-- Number of occurences of 'is'
SELECT REGEXP_COUNT('Snowflake is a cloud database, this IS best in the market', 'is', 1) as result 
from DUAL; -- 3

-- Number of occurences of whole word 'is'
SELECT REGEXP_COUNT('Snowflake is a cloud database, this is best in the market', '\\bis\\b', 1) as result 
from DUAL; -- 2

-- Number of occurences of 'is' -- with case-sensitive
SELECT REGEXP_COUNT('Snowflake is a cloud database, this IS best in the market', 'is', 1, 'c') as result 
from DUAL; -- 2

-- Number of occurences of whole word 'is' -- with case-sensitive
SELECT REGEXP_COUNT('Snowflake is a cloud database, this IS best in the market', '\\bis\\b', 1, 'c') as result 
from DUAL; -- 1

-- Number of occurences of whole word 'is' -- with case-insensitive
SELECT REGEXP_COUNT('Snowflake is a cloud database, this IS best in the market', '\\bis\\b', 1, 'i') as result 
from DUAL; -- 2


/* ----------
3. REGEXP_SUBSTR_ALL - Returns an ARRAY that contains all substrings that match a regular expression within a string. If no match is found, the function returns an empty ARRAY.
---------- */

-- To get all occurances of letter 'a' followed by a digit
SELECT regexp_substr_all('a1_a2a3_a4A5_a6a6', 'a[[:digit:]]') FROM DUAL;
SELECT regexp_extract_all('a1_a2a3_a4A5_a6a6', 'a[[:digit:]]') FROM DUAL;

-- To get all occurances of letter 'a' followed by a digit from 4th position
SELECT regexp_substr_all('a1_a2a3_a4A5_a6a6', 'a[[:digit:]]', 4) FROM DUAL;
SELECT regexp_extract_all('a1_a2a3_a4A5_a6a6', 'a[[:digit:]]', 4) FROM DUAL;

-- To get all occurances of letter 'a' followed by a digit starting from 3rd occurance
SELECT regexp_substr_all('a1_a2a3_a4A5_a6a6', 'a[[:digit:]]', 1, 3) FROM DUAL;
SELECT regexp_extract_all('a1_a2a3_a4A5_a6a6', 'a[[:digit:]]', 1, 3) FROM DUAL;

-- To ignore case sensitive matches
SELECT regexp_substr_all('a1_a2a3_a4A5_a6a6', 'a[[:digit:]]',1,4,'i') FROM DUAL;
SELECT regexp_extract_all('a1_a2a3_a4A5_a6a6', 'a[[:digit:]]',1,4,'i') FROM DUAL;

-- To get all the digits into an array from the string
SELECT regexp_substr_all(text, '[[:digit:]]') FROM PUBLIC.REGEXP;
SELECT regexp_extract_all(text, '[[:digit:]]') FROM PUBLIC.REGEXP;


/* ----------
4. REGEXP_INSTR - Returns the position of the specified occurrence of the regular expression pattern in the string subject. If no match is found, returns 0.
---------- */

CREATE or REPLACE TABLE PUBLIC.REGEXP2 (str VARCHAR);
INSERT INTO PUBLIC.REGEXP2 (str) VALUES 
('apple1 apple2, apple3 Apple4'),
('apple1_apple-apple3,APPLE4');

-- Position of the word apple followed by a digit, by default 1st occurance
SELECT str,
      regexp_substr(str, 'apple\\d') AS "SUBSTRING", 
      regexp_instr( str, 'apple\\d') AS "POSITION"
FROM PUBLIC.REGEXP2;

-- Position of the word apple followed by a digit starting from 4th position, by default 1st occurance
SELECT str,
      regexp_substr(str, 'apple\\d',4) AS "SUBSTRING", 
      regexp_instr( str, 'apple\\d',4) AS "POSITION"
FROM PUBLIC.REGEXP2;

-- Position of the word apple followed by a digit starting from 4th position, 2nd occurance
SELECT str,
      regexp_substr(str, 'apple\\d',4,2) AS "SUBSTRING", 
      regexp_instr( str, 'apple\\d',4,2) AS "POSITION"
FROM PUBLIC.REGEXP2;

-- Start and End positions of the word apple followed by a digit starting from 4th position, 2nd occurance
SELECT str,
      regexp_substr(str, 'apple\\d',4,2) AS "SUBSTRING", 
      regexp_instr( str, 'apple\\d',4,2,0) AS "START_POSITION",
      regexp_instr( str, 'apple\\d',4,2,1) AS "END_POSITION"
FROM PUBLIC.REGEXP2;

-- Position of the word apple followed by a digit starting from 4th position, 2nd occurance, ignore case
SELECT str,
      regexp_substr(str, 'apple\\d',4,2,'i') AS "SUBSTRING", 
      regexp_instr( str, 'apple\\d',4,2,0,'i') AS "POSITION"
FROM PUBLIC.REGEXP2;


/* ----------
5. REGEXP_REPLACE - Returns the subject with the specified pattern either removed or replaced by a replacement string. If no matches are found, returns the original subject.
---------- */

-- To replace a word with another word, by default all occurances
SELECT regexp_replace('When there is a will, there is a way', 'there','that') as "result" FROM DUAL;

-- To replace a word with another word, specific occurance
SELECT regexp_replace('When there is a will, there is a way', 'there','that',1,2) as "result" FROM DUAL;

-- To remove all digits from the string
SELECT regexp_replace('I bought 4-Apples, for $10', '\\d','') as "result" FROM DUAL;
OR
SELECT regexp_replace('I bought 4-Apples, for $10', '[0-9]','') as "result" FROM DUAL;
OR
SELECT regexp_replace('I bought 4-Apples, for $10', '\\d') as "result" FROM DUAL;

-- To remove all characters other than numeric
SELECT regexp_replace('I bought 4-Apples, for $10', '[^0-9]') as "result" FROM DUAL;

-- To remove alphabetical characters
SELECT regexp_replace('I bought 4-Apples, for $10', '[a-z]') as "result" FROM DUAL;
SELECT regexp_replace('I bought 4-Apples, for $10', '[a-zA-Z]') as "result" FROM DUAL;

-- To remove all special characters
SELECT regexp_replace('I bought 4-Apples, for $10', '[^a-zA-Z0-9]') as "result" FROM DUAL;

-- To remove all alpha-numeric characters
SELECT regexp_replace('I bought 4-Apples, for $10', '[a-zA-Z0-9]') as "result" FROM DUAL;

-- To remove parentheses
select regexp_replace('I bought (4-Apples), for $10','\\(|\\)') as "result" FROM DUAL;
