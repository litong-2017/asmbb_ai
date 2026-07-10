respIgnoreOK            text "Status: 200 Success", 13, 10, "Content-Type: text/plain", 13, 10, 13, 10
respIgnoreUnauthorized  text "Status: 401 Unauthorized", 13, 10, "Content-Type: text/plain", 13, 10, 13, 10
respIgnoreUserMissing   text "Status: 404 User not exists", 13, 10, "Content-Type: text/plain", 13, 10, 13, 10
respIgnoreMethod        text "Status: 405 Method not allowed", 13, 10, "Content-Type: text/plain", 13, 10, 13, 10
respIgnoreServer        text "Status: 500 Internal Server Error", 13, 10, "Content-Type: text/plain", 13, 10, 13, 10

sqlUnignore text "delete from Blacklist where userID = ?1 and ignoreID = (select id from users where nick=?2)"
proc UnIgnoreUser, .pSpecial
.stmt dd ?
begin
        pushad

        mov     esi, [.pSpecial]

        mov     edi, respIgnoreMethod
        cmp     [esi+TSpecialParams.post_array], 0
        je      .finish

        mov     edi, respIgnoreUnauthorized
        cmp     [esi+TSpecialParams.userID], 0
        je      .finish

        mov     edi, respIgnoreUserMissing
        stdcall GetPostString, [esi+TSpecialParams.post_array], txt 'user', 0
        test    eax, eax
        jz      .finish

        mov     ebx, eax        ; the user name. Must be StrDel.

        lea     eax, [.stmt]
        cinvoke sqlitePrepare_v2, [hMainDatabase], sqlUnignore, sqlUnignore.length, eax, 0
        cinvoke sqliteBindInt, [.stmt], 1, [esi+TSpecialParams.userID]

        stdcall StrPtr, ebx
        cinvoke sqliteBindText, [.stmt], 2, eax, [eax+string.len], SQLITE_STATIC

        cinvoke sqliteStep, [.stmt]

        mov     edi, respIgnoreServer
        cmp     eax, SQLITE_DONE
        jne     .cleanup

        mov     edi, respIgnoreOK

.cleanup:
        cinvoke sqliteFinalize, [.stmt]
        stdcall StrDel, ebx

.finish:
        stdcall TextCreate, sizeof.TText
        stdcall TextCat, eax, edi

        stc
        mov     [esp+4*regEAX], edx
        popad
        return
endp


sqlIgnore text "insert into Blacklist values (?1, (select id from users where nick = ?2))"

proc IgnoreUser, .pSpecial
.stmt dd ?
begin
        pushad

        mov     esi, [.pSpecial]

        mov     edi, respIgnoreMethod
        cmp     [esi+TSpecialParams.post_array], 0
        je      .finish

        mov     edi, respIgnoreUnauthorized
        cmp     [esi+TSpecialParams.userID], 0
        je      .finish

        mov     edi, respIgnoreUserMissing
        stdcall GetPostString, [esi+TSpecialParams.post_array], txt 'user', 0
        test    eax, eax
        jz      .finish

        mov     ebx, eax        ; the user name. Must be StrDel.

        lea     eax, [.stmt]
        cinvoke sqlitePrepare_v2, [hMainDatabase], sqlIgnore, sqlIgnore.length, eax, 0
        cinvoke sqliteBindInt, [.stmt], 1, [esi+TSpecialParams.userID]

        stdcall StrPtr, ebx
        cinvoke sqliteBindText, [.stmt], 2, eax, [eax+string.len], SQLITE_STATIC

        cinvoke sqliteStep, [.stmt]
        cmp     eax, SQLITE_CONSTRAINT
        je      .cleanup

        mov     edi, respIgnoreServer
        cmp     eax, SQLITE_DONE
        jne     .cleanup

        mov     edi, respIgnoreOK

.cleanup:
        cinvoke sqliteFinalize, [.stmt]
        stdcall StrDel, ebx

.finish:
        stdcall TextCreate, sizeof.TText
        stdcall TextCat, eax, edi

        stc
        mov     [esp+4*regEAX], edx
        popad
        return
endp




sqlGetIgnored text "select U.nick from Blacklist B left join Users U on B.ignoreID = U.id where B.userID = ?1"
ignoreStyleDefault text "display: none"

proc RenderBlacklist, .pSpecial
.stmt dd ?
.style dd ?
begin
        pushad

        mov     esi, [.pSpecial]

        stdcall TextCreate, sizeof.TText
        mov     ebx, eax

        test    esi, esi
        jz      .exit

        mov     eax, ignoreStyleDefault
        stdcall GetParam, "ignore_style", gpString
        mov     [.style], eax

        lea     eax, [.stmt]
        cinvoke sqlitePrepare_v2, [hMainDatabase], sqlGetIgnored, sqlGetIgnored.length, eax, 0
        cinvoke sqliteBindInt, [.stmt], 1, [esi+TSpecialParams.userID]

.loop:
        cinvoke sqliteStep, [.stmt]
        cmp     eax, SQLITE_ROW
        jne     .finish

        cmp     [ebx+TText.GapBegin], 0
        je      .first_ok

        stdcall TextCat, ebx, txt ','
        mov     ebx, edx

.first_ok:
        cinvoke sqliteColumnText, [.stmt], 0

        stdcall TextCat, ebx, txt '[author="'
        stdcall TextCat, edx, eax
        stdcall TextCat, edx, txt '"]'
        mov     ebx, edx

        jmp     .loop

.finish:
        cinvoke sqliteFinalize, [.stmt]

        cmp     [ebx+TText.GapBegin], 0
        je      .clean

        stdcall TextCat, ebx, txt "{"
        stdcall TextCat, edx, [.style]
        stdcall TextCat, edx, txt "}"
        mov     ebx, edx

.clean:
        cmp     [.style], ignoreStyleDefault
        je      .exit

        stdcall StrDel, [.style]

.exit:
        mov     [esp+4*regEAX], ebx
        popad
        return
endp



sqlIsIgnored text "select exists(select 1 from blacklist where userID = ?1 and ignoreID = ?2)"

proc GetIgnoredBool, .userID, .pSpecial
.stmt dd ?
begin
        pushad

        mov     esi, [.pSpecial]
        xor     ebx, ebx
        
        lea     eax, [.stmt]
        cinvoke sqlitePrepare_v2, [hMainDatabase], sqlIsIgnored, sqlIsIgnored.length, eax, 0
        cinvoke sqliteBindInt, [.stmt], 1, [esi+TSpecialParams.userID]
        cinvoke sqliteBindInt, [.stmt], 2, [.userID]
        cinvoke sqliteStep, [.stmt]
        cmp     eax, SQLITE_ROW
        jne     .finalize

        cinvoke sqliteColumnInt, [.stmt], 0
        mov     ebx, eax

.finalize:
        cinvoke sqliteFinalize, [.stmt]

        mov     [esp+4*regEAX], ebx
        popad
        return
endp
