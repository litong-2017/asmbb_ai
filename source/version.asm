
; This file includes the fossil CMS generated file "manifest.uuid"
; which contains the current source code checkout version.
;
; If you downloaded only the sources and not cloned the repository,
; you will probably don't have it in your source tree.
;
; In this case you can simply create some source file at least 16 chars long
; and these chars will be used as a version string.

iglobal

  if used cVersion
    cVersion  db   '<b>AsmBB v3.0</b> (check-in: <a href="http://asm32.info/fossil/asmbb/info/'
              file "../manifest.uuid":0,16     ; on error, read the header comments.
              db   '">'
              file "../manifest.uuid":0,16     ; on error, read the header comments.
              db   "</a>)"
              dd 0
  end if

endg
