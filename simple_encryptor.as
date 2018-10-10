/*
Simple encryptor module for HSP
Version 1.00
*/

#ifndef __SIMPLLEENCRYPTOR__
#define __SIMPLLEENCRYPTOR__
#module simple_encryptor
#deffunc encryptor_init
/*
Initializes the encryption table. Must be called once before other function calls.
Remarks:
I recommend using different encryption tables for each of your application. Here's how to do it.
- Copy this module to your project folder (using the common directory is not recommended)
- Use `encryptor_createTable outFileName` to generate the new table
- past and overwrite the preexisting table
*/
/* Overwrite the area below */
dim enctable,256
enctable=229,240,168,233,25,32,248,150,123,253,89,154,173,163,33,180,67,112,73,204,136,54,120,254,251,8,198,16,22,5,211,210,237,134,111,72,241,138,110,105,114,223,153,57,225,11,29,106,102,121,28,212,55,24,113,203,74,90,238,99,222,62,86,79,209,176,38,148,40,193,187,51,135,9,174,182,145,82,161,109,221,146,140,247,35,83,116,147,215,206,63,95,75,15,216,44,85,81,141,195,126,165,119,59,164,162,115,218,186,143,60,188,88,30,41,190,47,144,244,13,131,125,78,142,228,31,239,97,17,48,157,124,34,56,117,235,87,94,208,12,129,167,243,201,43,50,103,194,139,53,245,77,183,196,149,10,191,58,234,96,6,160,207,122,80,177,159,179,170,172,231,100,108,66,76,69,20,152,21,133,68,192,26,189,3,91,181,14,249,232,246,84,200,230,128,93,98,252,71,42,224,178,19,49,118,155,242,4,18,64,70,213,46,219,175,202,23,27,127,255,169,130,132,166,52,220,7,151,156,65,39,45,107,197,36,205,1,104,227,250,171,92,101,37,236,137,184,226,199,61,158,2,185,214,0,217
/* Overwrite the area above */
initialized=1
return

#deffunc encryptor_createTable str _fname, local _buf1, local _buf2, local _r
/*
Creates a new encryption table. As for usage, see above.
*/
if _fname="":dialog "Please input the filename to save the new encryption table":return
randomize
dim _buf1,256
sdim _buf2,2048
_buf2="dim enctable,256\nenctable="
repeat 256
repeat
_r=rnd(256)
if _buf1(_r)=0:break
loop
_buf1(_r)=1
_buf2+=""+_r+","
loop
_buf2=strmid(_buf2,0,strlen(_buf2)-1)
bsave _fname,_buf2,strlen(_buf2)
return

#deffunc encryptor_encrypt var _in, int _insize, var _out, var _outsize, local _count
/*
encryptor_encrypt input_buffer,input_size,output_buffer,output_buffer_size,
*/
sdim _out,_insize+4
_count=_insize-1
_out="ENC_"
repeat _insize,4
poke _out,cnt,enctable(peek(_in,_count))
_count--
loop
_outsize=_insize+4
return

#deffunc encryptor_decrypt var _in, int _insize, var _out, var _outsize, local _count
/*
The opposite version of encryptor_encrypt
*/
sdim _out,_insize
_count=_insize-1
repeat _insize-4
poke _out,cnt,_search_enctable(peek(_in,_count))
_count--
loop
_outsize=_insize-4
return

#defcfunc encryptor_checkEncrypted var _in, local _chk
/*
result=encryptor_checkEncrypted(buffer_to_check)
Return value: 0 for non-encrypted data, 1 for encrypted data
*/
_chk=""
memcpy _chk,_in,4
return _chk=="ENC_"

#defcfunc _search_enctable int _index, local _r
/* Internal function, do not call */
_r=0
repeat 256
if enctable(cnt)==_index:_r=cnt:break
loop
return _r

#global
#endif
encryptor_createTable "a.txt"