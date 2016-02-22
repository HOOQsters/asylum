"============================================================================
"File:        asylum.vim
"Description: JavaScript syntax checker - using asylum
"Maintainer:  Dhi Aurrahman <dio@hooq.tv>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"============================================================================

if exists('g:loaded_syntastic_javascript_asylum_checker')
    finish
endif
let g:loaded_syntastic_javascript_asylum_checker = 1

if !exists('g:syntastic_javascript_asylum_generic')
    let g:syntastic_javascript_asylum_generic = 0
endif

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_javascript_asylum_IsAvailable() dict
    if g:syntastic_javascript_asylum_generic
        call self.log('generic asylum, exec =', self.getExec())
    endif

    if !executable(self.getExec())
        return 0
    endif
    return g:syntastic_javascript_asylum_generic || syntastic#util#versionIsAtLeast(self.getVersion(), [1, 0, 0])
endfunction

function! SyntaxCheckers_javascript_asylum_GetLocList() dict
    let makeprg = self.makeprgBuild({ 'args': '-v' })

    let errorformat = '  %f:%l:%c: %m'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'subtype': 'Style',
        \ 'defaults': {'type': 'W'},
        \ 'returns': [0, 1] })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'javascript',
    \ 'name': 'asylum'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
